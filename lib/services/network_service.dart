import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:liandan_flutter/main.dart';
import 'package:liandan_flutter/services/request/http_utils.dart';
import 'package:loggy/loggy.dart';
import 'package:encrypt/encrypt.dart' as encrypt;
import 'package:tuple/tuple.dart';

import 'cache/storage.dart';

const kDomainEncryptKey = "Q1#xpzu&F4Rh4Jz0";
const testUrl = "/operator/noauth/baseInfo";

class NetworkTestModel {
  String? url;
  int? speed;
  NetworkTestModel({this.url, this.speed});

  Future testSpeed() async {
    if (url == null || (url ?? "").isEmpty) {
      return null;
    }

    String finalUrl = url ?? "";
    if (url?.endsWith("/") == true) {
      finalUrl = finalUrl.substring(0, finalUrl.length - 1);
      url = finalUrl;
    }

    String path = "$finalUrl$testUrl";
    try {
      Stopwatch stopwatch = Stopwatch()..start();
      await HttpUtil.get(
        path,
      );
      stopwatch.stop();
      speed = stopwatch.elapsed.inMilliseconds;
      return null;
    } on DioError {
      return null;
    }
  }

  Map<String, dynamic> toJson() {
    return {
      "url": url,
      "speed": speed,
    };
  }
}

class NetworkTestService {
  final dio = Dio();

  List<String> domainList = [];

  NetworkTestService() {
    fetchOSSDomainList();
  }

  void startTest() async {
    if (domainList.length < 2) {
      return;
    }

    List<NetworkTestModel> modelList = domainList
        .map(
          (e) => NetworkTestModel(url: e),
        )
        .toList();

    List<NetworkTestModel> testModelList =
        await Future.wait(modelList.map((e) async {
      await e.testSpeed();
      return e;
    }).toList());

    List<NetworkTestModel> noNullModels =
        testModelList.where((element) => element.speed != null).toList();
    noNullModels.sort((a, b) => (a.speed ?? 0).compareTo(b.speed ?? 0));
    if (noNullModels.isNotEmpty) {
      updateBaseUrlAndSave(noNullModels.first);
    }
    logInfo(noNullModels.first.toJson());
    logInfo(noNullModels.last.toJson());
  }

  void updateBaseUrlAndSave(NetworkTestModel model) {
    if (configEnv.appBaseUrl != model.url &&
        model.url?.contains(configEnv.appBaseUrl) == false) {
      configEnv.appBaseUrl = model.url ?? configEnv.appBaseUrl;
      SpUtil().setString(currentDomainKey, configEnv.appBaseUrl);
      HttpUtil.init(baseUrl: configEnv.appBaseUrl);
    }
  }

  void fetchOSSDomainList() async {
    try {
      final response = await dio.get(
        configEnv.domainListPath,
        options: Options(responseType: ResponseType.plain),
      );
      if (response.statusCode == 200) {
        String? result = response.data as String?;
        //  String result =
        // "U2FsdGVkX18Z7zuF9ySf3GD47UW9knT5ctfEn3IaonknUvZL8aztm80Xzbalxtxd5eOUsqvSoKlosH31u2UkO0e/s0iFH1Dku15uhsLk3PVeX51WMEetQCZYX1sSShEo";
        try {
          Uint8List encryptedBytesWithSalt = base64.decode(result ?? "");

          Uint8List encryptedBytes =
              encryptedBytesWithSalt.sublist(16, encryptedBytesWithSalt.length);
          final salt = encryptedBytesWithSalt.sublist(8, 16);
          var keyndIV = deriveKeyAndIV(kDomainEncryptKey, salt);
          final key = encrypt.Key(keyndIV.item1);
          final iv = encrypt.IV(keyndIV.item2);

          final encrypter = encrypt.Encrypter(
              encrypt.AES(key, mode: encrypt.AESMode.cbc, padding: "PKCS7"));
          final decrypted =
              encrypter.decrypt64(base64.encode(encryptedBytes), iv: iv);
          Map<String, dynamic>? json =
              jsonDecode(decrypted) as Map<String, dynamic>?;
          if (json?["http"] != null) {
            List domains = json?["http"];
            domainList = domains.map((e) => e as String).toList();
            startTest();
          }
        } catch (error) {
          // rethrow;
        }
      }
    } catch (e) {
      logInfo(e);
      // The request was made and the server responded with a status code
      // that falls out of the range of 2xx and is also not 304.
    }
  }

  Uint8List createUint8ListFromString(String s) {
    var ret = Uint8List(s.length);
    for (var i = 0; i < s.length; i++) {
      ret[i] = s.codeUnitAt(i);
    }
    return ret;
  }

  Tuple2<Uint8List, Uint8List> deriveKeyAndIV(
      String passphrase, Uint8List salt) {
    var password = createUint8ListFromString(passphrase);
    Uint8List concatenatedHashes = Uint8List(0);
    Uint8List currentHash = Uint8List(0);
    bool enoughBytesForKey = false;
    Uint8List preHash = Uint8List(0);

    while (!enoughBytesForKey) {
      // int preHashLength = currentHash.length + password.length + salt.length;
      if (currentHash.isNotEmpty) {
        preHash = Uint8List.fromList(currentHash + password + salt);
      } else {
        preHash = Uint8List.fromList(password + salt);
      }

      currentHash = Uint8List.fromList(
          md5.convert(preHash).bytes); //convert(preHash).bytes;
      concatenatedHashes = Uint8List.fromList(concatenatedHashes + currentHash);
      if (concatenatedHashes.length >= 48) enoughBytesForKey = true;
    }

    var keyBtyes = concatenatedHashes.sublist(0, 32);
    var ivBtyes = concatenatedHashes.sublist(32, 48);
    return Tuple2(keyBtyes, ivBtyes);
  }
}
