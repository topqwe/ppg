import 'dart:core';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

import '../../main.dart';
import '../../store/AppCacheManager.dart';

class Api {
  Api() {
    // if (!kReleaseMode) {
    //   dio.interceptors
    //       .add(LogInterceptor(responseBody: true, requestBody: true));
    // }
  }


  /// Get base url by env
  String apiBaseUrl() {
    // return Singleton.getInstance().host;
    return AppCacheManager.instance.getCurrentDomainKey();
    // return payEnv.appBaseUrl;
  }

  final Dio dio = Dio();

  /// Get request header options
  Future<Options> getOptions(
      {String contentType = Headers.formUrlEncodedContentType,
      String? prefer}) async {
    // (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
    //     (client) {
    //   client.findProxy = (url) {
    //     return 'PROXY 192.188.1.4:8888'; //localhost
    //   };
    //   //
    //   client.badCertificateCallback =
    //       (X509Certificate cert, String host, int port) => true;
    // };
    // String platform = platformutil.PlatformUtils.getPlatform();

    // final MInfoDevice infoDevice = await getDeviceInfo();
    final Map<String, String> header = <String, String>{
      "X-APP-VERSION": configEnv.localversion,
      "LANG": "",
      // "X-CHANNEL": platform,
      // "X-DEVICE-ID": platform,
      // "X-DEVICE-BRAND": platform,
      // "X-DEVICE-BRAND-TYPE": platform,
      // "X-DEVICE-SYS-VERSION": platform,
    };
    return Options(headers: header, contentType: contentType);
  }

  Future<Options> getOptionsHeader(
      {String contentType = Headers.formUrlEncodedContentType,
      String? prefer}) async {
    // (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
    //     (client) {
    //   client.findProxy = (Uri) {
    //     return 'PROXY 192.168.1.4:8888'; //这里将localhost设置为自己电脑的IP，其他不变，注意上线的时候一定记得把代理去掉
    //   };
    //   //代理工具会提供一个抓包的自签名证书，会通不过证书校验，所以我们禁用证书校验
    //   client.badCertificateCallback =
    //       (X509Certificate cert, String host, int port) => true;
    // };
    // ResInfoUser? dataUser = publicUserInfo();

    final String xAuthToken = AppCacheManager.instance.getUserToken().isNotEmpty?
    AppCacheManager.instance.getUserToken():"";//publicToken() ??
    final int xUserId = AppCacheManager.instance.getUserId();
    String? lang = AppCacheManager.instance.getAppLanguage();


    // String platform = platformutil.PlatformUtils.getPlatform();
    // String channel = platformutil.PlatformUtils.getChannel();

    final Map<String, dynamic> header = <String, dynamic>{
      "X-APP-VERSION": configEnv.localversion,
      "lang": lang,//en-US
      // "X-CHANNEL": channel,
      "x-token": xAuthToken,
      "x-uid": xUserId.toString(),
      // "X-MEMBER-NAME": xMemberName,
      // "X-MEMBER-TYPE": xMemberType,
      // "X-MEMBER-CATEGORY": xMemberCategory,
      // "X-MEMBER-NICKNAME": xMemberNickname,
      // "X-PAY-ADDRESS": xPayAddress,
      // "X-DEVICE-ID": platform,
      // "X-DEVICE-BRAND": platform,
      // "X-DEVICE-BRAND-TYPE": platform,
      // "X-DEVICE-SYS-VERSION": channel,
    };
    return Options(headers: header, contentType: contentType);
  }

  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue, String reg) {
    if (newValue.text.isNotEmpty) {
      if (RegExp(reg).firstMatch(newValue.text) != null) {
        return newValue;
      }
      return oldValue;
    }
    return newValue;
  }

  static bool isChinaPhoneLegal(String str, RegExp reg) {
    return reg.hasMatch(str);
  }

  /// Wrap Dio Exception
  Future<Response<T>> wrapE<T>(Future<Response<T>> Function() dioApi,
      {BuildContext? context}) async {
    try {
      return await dioApi();
    } catch (error) {
      if (error is DioError  ) {
        final Response<dynamic>? response = error.response;
        if (response != null) {
          if (response.statusCode == 401) {
            try {
              // var a = await Provider.of<AuthProvider>(context!, listen: false).login(context);
              // if(a){
              //   RequestOptions requestOptions=response.requestOptions;
              //   // ignore: use_build_context_synchronously
              //   final Token? token = context.read<Credential>().token;
              //   if (token != null) {
              //     final Options options = await getOptions(contentType:  Headers.jsonContentType);
              //     options.headers!.addAll(<String, String>{'Authorization': 'Bearer ${token.accessToken}'});
              //     return dio.request(requestOptions.path,options: options);
              //   }
              // }
            } catch (error) {
              if (error is DioError  ) {
                final Response<dynamic>? response = error.response;
                final String errorMessage =
                    'Code ${response?.statusCode} - ${response?.statusMessage} ${response?.data != null ? '\n' : ''} ${response?.data}';
                throw DioError(
                    requestOptions: error.requestOptions,
                    response: error.response,
                    type: error.type,
                    error: errorMessage);
              } else if (error is DioError  ) {
                throw DioError(
                    requestOptions: error.requestOptions,
                    response: error.response,
                    type: error.type,
                    error: "");
              } else {
                rethrow;
              }
            }
          }
          try {
            /// By pass dio header error code to get response content
            /// Try to return response
            final Response<T> res = Response<T>(
              data: response.data as T,
              headers: response.headers,
              requestOptions: response.requestOptions,
              isRedirect: response.isRedirect,
              statusCode: response.statusCode,
              statusMessage: response.statusMessage,
              redirects: response.redirects,
              extra: response.extra,
            );
            return res;
          } catch (e) {
            if (kDebugMode) {
              print(e);
            }
          }
        }
        final String errorMessage =
            'Code ${response?.statusCode} - ${response?.statusMessage} ${response?.data != null ? '\n' : ''} ${response?.data}';
        throw DioError(
            requestOptions: error.requestOptions,
            response: error.response,
            type: error.type,
            error: errorMessage);
      } else if (error is DioError  ) {
        throw DioError(
            requestOptions: error.requestOptions,
            response: error.response,
            type: error.type,
            error: "");
      } else {
        rethrow;
      }
    }
  }

}
