import 'dart:convert';
import 'dart:typed_data';

import 'package:http_parser/http_parser.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:liandan_flutter/util/JCHub.dart';
import '../../util/LoadingBarrierView.dart';
import '../../widgets/helpTools.dart';
import 'api.dart';
import 'package:get/get.dart' hide FormData, MultipartFile;

class ApiBasic extends Api {
  static const Api_login = "/web/users/login";
  static const Api_loginP = "/web/users/login";
  static const Api_register = "/web/users/register";
  static const Api_registerP = "/web/users/register";
  static const Api_dummy  = '/dummy/index';
  static const Api_config  = '/web/config';
  static const Api_me  = '/web/me';
  static const Api_home  = '/web/home/index';
  static const Api_cates  = '/web/cates/index';
  static const Api_boxes  = '/web/boxes/index';
  static const Api_boxDetail  = '/web/boxDetail/index';
  static const Api_boxBuy  = '/web/home/index';
  static const Api_topup  = '/web/home/index';
  static const Api_uploadImage  = '/web/home/index';
  static const Api_withdraw  = '/web/home/index';
  static const Api_getWallet  = '';
  static const Api_getConfig  = '';
  static const Api_RecordLists  = '';

  static const Api_userInfo = '/web/home/index';

  dynamic initCus(){
    return [];
  }
  Future<dynamic> dummy( Map data) async {
    final Options options =
    await getOptionsHeader(contentType: Headers.jsonContentType);
    var result = await wrapE(() => dio.post<Map<String, dynamic>>(
        apiBaseUrl() + Api_dummy,
        options: options,
        data: data)).timeout(const Duration(seconds: 30));
    var dataResult = result.data!;
    return dataResult;
  }

  postImage(image, imageName,{
    // bool isFromCamera = false,
    String folder = '',}) async {
    // Response resp;
    try {
      Uint8List sbyets = await image.readAsBytes();
      print("图片size：${sbyets.length}");

      String path = image.path;

      int lenLimit = 5 * 1024 * 1024;
      if (lenLimit < sbyets.length) {
        LoadingBarrierView.showLoading(Get.context!);
        await Future.delayed(const Duration(milliseconds: 100));
        Uint8List? bytes =
        await compressImage(sbyets, path: path, quality: kIsWeb ? 60 : 70);
        sbyets = bytes ?? sbyets;
        print("size：${sbyets.length}");
        if (lenLimit < sbyets.length) {
          LoadingBarrierView.hideLoading(Get.context!);
          JCHub.showmsg("要限制5M以内".tr, Get.context!);
          // FToast.toast(Get.context!,msg:"请上传5M以内的图片".tr, );
          return null;
        }
      }

      var name = path.substring(path.lastIndexOf("/") + 1, path.length);
      print(path);
      // Map<String, dynamic> formMap = {};
      // var fileass = await MultipartFile.fromFile(path,
      //     filename:name);
      // formMap['file'] = fileass;
      // FormData formData = FormData.fromMap(formMap);

      FormData formData = FormData.fromMap({
        "file": MultipartFile.fromBytes(sbyets,
            filename: name, contentType: MediaType('image', "jpg")),
        'folder': folder,
        'type': "image",
      });

      final Options options =
      await getOptionsHeader(contentType: Headers.jsonContentType);
      var result = await wrapE(() => dio.post<Map<String, dynamic>>(
          apiBaseUrl() + Api_uploadImage,
          options: options,
          data: formData)).timeout(const Duration(seconds: 30));
      var dataResult = result.data!;
      return dataResult;
      // resp = await dio.post(Api_uploadImage, data: formData,options: Options(contentType: 'multipart/form-data'));
      // //Dio().post  //Http().post
      // if (resp.statusCode == 200) {
      //   String val = resp.toString();
      //   return jsonDecode(val);
      // } else {
      //
      //   String val = resp.toString();
      //   print(val);
      //   return jsonDecode(val);
      // }
    } catch (error) {
      return error;
    }
  }
  postImage2(image,{
    // bool isFromCamera = false,
    String folder = '',}) async {
    // Response resp;

    try {
      Uint8List sbyets = await image.readAsBytes();
      print("图片size：${sbyets.length}");

      String path = image.path;

      int lenLimit =  1 * 1024 * 1024;//test 1024
      if (lenLimit < sbyets.length) {
        LoadingBarrierView.showLoading(Get.context!);
        await Future.delayed(const Duration(milliseconds: 100));
        Uint8List? bytes =
        await compressImage(sbyets, path: path, quality: kIsWeb ? 60 : 70);
        sbyets = bytes ?? sbyets;
        print("size：${sbyets.length}");
        if (lenLimit < sbyets.length) {
          LoadingBarrierView.hideLoading(Get.context!);
          JCHub.showmsg("要限制5M以内".tr, Get.context!);
          // FToast.toast(Get.context!,msg:"请上传5M以内的图片".tr, );
          return null;
        }
      }

      var name = path.substring(path.lastIndexOf("/") + 1, path.length);
      print(path);
      // Map<String, dynamic> formMap = {};
      // var fileass = await MultipartFile.fromFile(path,
      //     filename:name);
      // formMap['file'] = fileass;
      // FormData formData = FormData.fromMap(formMap);

      FormData formData = FormData.fromMap({
        "file": MultipartFile.fromBytes(sbyets,
            filename: name, contentType: MediaType('image', "jpg")),
        'folder': folder,
        'type': "image",
      });
      final Options options =
      await getOptionsHeader(contentType: Headers.jsonContentType);
      var result = await wrapE(() => dio.post<Map<String, dynamic>>(
          apiBaseUrl() + Api_uploadImage,
          options: options,
          data: formData)).timeout(const Duration(seconds: 30));
      var dataResult = result.data!;
      return dataResult;
      // resp = await dio.post(Api_uploadImage, data: formData);
      // if (resp.statusCode == 200) {
      //   String val = resp.toString();
      //   return jsonDecode(val);
      // } else {
      //
      //   String val = resp.toString();
      //   print(val);
      //   return jsonDecode(val);
      // }
    } catch (error) {
      return error;
    }
  }

  /// register
  Future<dynamic> register( Map data) async {
    final Options options =
    await getOptionsHeader(contentType: Headers.jsonContentType);
    var result = await wrapE(() => dio.post<Map<String, dynamic>>(
        apiBaseUrl() + Api_registerP,
        options: options,
        data: data)).timeout(const Duration(seconds: 30));
    var dataResult = result.data!;
    return dataResult;
  }

  Future<dynamic> login( Map data) async {
    print(apiBaseUrl());
    final Options options =
        await getOptionsHeader(contentType: Headers.jsonContentType);
    var result = await wrapE(() => dio.post<Map<String, dynamic>>(
        apiBaseUrl() + Api_loginP,
        options: options,
        data: data)).timeout(const Duration(seconds: 30));
    var dataResult = result.data!;
    return dataResult;
  }

  Future<dynamic> config( Map data) async {
    final Options options =
    await getOptionsHeader(contentType: Headers.jsonContentType);
    var result = await wrapE(() => dio.post<Map<String, dynamic>>(
        apiBaseUrl() + Api_config,
        options: options,
        data: data)).timeout(const Duration(seconds: 30));
    var dataResult = result.data!;
    return dataResult;
  }

  Future<dynamic> home( Map data) async {
    final Options options =
    await getOptionsHeader(contentType: Headers.jsonContentType);
    var result = await wrapE(() => dio.post<Map<String, dynamic>>(
        apiBaseUrl() + Api_home,
        options: options,
        data: data)).timeout(const Duration(seconds: 30));
    var dataResult = result.data!;
    return dataResult;
  }

  Future<dynamic> me( Map data) async {
    final Options options =
    await getOptionsHeader(contentType: Headers.jsonContentType);
    var result = await wrapE(() => dio.post<Map<String, dynamic>>(
        apiBaseUrl() + Api_me,
        options: options,
        data: data)).timeout(const Duration(seconds: 30));
    var dataResult = result.data!;
    return dataResult;
  }

  Future<dynamic> cates( Map data) async {
    final Options options =
    await getOptionsHeader(contentType: Headers.jsonContentType);
    var result = await wrapE(() => dio.post<Map<String, dynamic>>(
        apiBaseUrl() + Api_cates,
        options: options,
        data: data)).timeout(const Duration(seconds: 30));
    var dataResult = result.data!;
    return dataResult;
  }

  Future<dynamic> boxes( Map data) async {
    final Options options =
    await getOptionsHeader(contentType: Headers.jsonContentType);
    var result = await wrapE(() => dio.post<Map<String, dynamic>>(
        apiBaseUrl() + Api_boxes,
        options: options,
        data: data)).timeout(const Duration(seconds: 30));
    var dataResult = result.data!;
    return dataResult;
  }
  Future<dynamic> boxDetail( Map data) async {
    final Options options =
    await getOptionsHeader(contentType: Headers.jsonContentType);
    var result = await wrapE(() => dio.post<Map<String, dynamic>>(
        apiBaseUrl() + Api_boxDetail,
        options: options,
        data: data)).timeout(const Duration(seconds: 30));
    var dataResult = result.data!;
    return dataResult;
  }
  Future<dynamic> boxBuy( Map data) async {
    final Options options =
    await getOptionsHeader(contentType: Headers.jsonContentType);
    var result = await wrapE(() => dio.post<Map<String, dynamic>>(
        apiBaseUrl() + Api_boxBuy,
        options: options,
        data: data)).timeout(const Duration(seconds: 30));
    var dataResult = result.data!;
    return dataResult;
  }
  Future<dynamic> topup( Map data) async {
    final Options options =
    await getOptionsHeader(contentType: Headers.jsonContentType);
    var result = await wrapE(() => dio.post<Map<String, dynamic>>(
        apiBaseUrl() + Api_topup,
        options: options,
        data: data)).timeout(const Duration(seconds: 30));
    var dataResult = result.data!;
    return dataResult;
  }
  Future<dynamic> withdraw( Map data) async {
    final Options options =
    await getOptionsHeader(contentType: Headers.jsonContentType);
    var result = await wrapE(() => dio.post<Map<String, dynamic>>(
        apiBaseUrl() + Api_withdraw,
        options: options,
        data: data)).timeout(const Duration(seconds: 30));
    var dataResult = result.data!;
    return dataResult;
  }

  // var list = [];
  // for (int i = 0; i < 11; i++) {
  // var vv = {'status':3,'name': '$i'+'name',
  // 'iconBig': '$i','prize':i+1500.9,'progress':0.82,'id': '$i',};
  // list.add(vv);
  // }
  // var listP = [];
  // for (int i = 0; i < 11; i++) {
  // var vv = {'status':3,'name': '$i'+'dfhdf',
  // 'iconBig': '$i','prize':i+500.9,'progress':0.82,'id': '$i','children':list};
  // listP.add(vv);
  // }
  //
  // return listP;
}
