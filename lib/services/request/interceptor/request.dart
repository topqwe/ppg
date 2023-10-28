import 'dart:convert';
// import 'package:device_info_plus/device_info_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:ftoast/ftoast.dart';
import 'package:get/get.dart' as g_t;
import 'package:get/get_core/src/get_main.dart';
import 'package:liandan_flutter/main.dart';
import 'package:loggy/loggy.dart';
import 'package:throttling/throttling.dart';

import '../../../store/AppCacheManager.dart';
import '../../cache/storage.dart';

Throttling _loginThrottling = Throttling(duration: const Duration(seconds: 5));

// 错误处理拦截器
class RequestInterceptor extends Interceptor {
  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final String xAuthToken = AppCacheManager.instance.getUserToken().isNotEmpty?
    AppCacheManager.instance.getUserToken():"";//publicToken() ??
    final int xUserId = AppCacheManager.instance.getUserId();
    final String? lang = AppCacheManager.instance.getAppLanguage();
    // ResInfoUser? dataUser = publicUserInfo();
    // final String? xAuthToken = publicToken();

    // final String xMemberId = dataUser?.memberId ?? "";
    // final String xMemberNickname = Uri.encodeFull(dataUser?.nickname ?? "");
    // String platform = platformutil.PlatformUtils.getPlatform();
    // String channel = platformutil.PlatformUtils.getChannel();
    final Map<String, dynamic> header = <String, dynamic>{
      "X-APP-VERSION": configEnv.localversion,
      "lang": lang,
      // "X-CHANNEL": channel,
      "x-token": xAuthToken,
      "x-uid": xUserId.toString(),

      // "X-DEVICE-ID": platform,
      // "X-DEVICE-BRAND": platform,
      // "X-DEVICE-BRAND-TYPE": platform,
      // "X-DEVICE-SYS-VERSION": channel,
    };
    String? contentType = options.contentType;
    options.headers = header;
    options.contentType = contentType;

    return super.onRequest(options, handler);
  }
}

class ResponseInterceptor extends Interceptor {
  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) async {
    logInfo(
      "请求地址 -- ${response.requestOptions.baseUrl}${response.requestOptions.path}",
    );
    logInfo(
      "请求参数 -- ${response.requestOptions.data} -- ${response.requestOptions.queryParameters}",
    );
    logInfo("返回内容 -- ${response.data}");
    // 如果启用缓存，将返回结果保存到缓存
    Map<String, dynamic> repData;
    if (response.requestOptions.responseType == ResponseType.plain) {
      repData = jsonDecode(response.data);
    } else {
      repData = response.data;
    }

    dynamic res = repData["data"];
    String? time = repData["time"] == null ? null : "${repData["time"]}";
    if (time != null) {
      latestServerTime = time;
    }
    if (res != null) {
      response.data = res;
    } else {
      dynamic code = repData["code"];
      dynamic message = repData["msg"];

      if (code == "200") {
        Map<String, dynamic>? requestExtra = response.requestOptions.extra;
        if (requestExtra["showSuccessToast"] == true) {
          FToast.toast(g_t.Get.context!, msg: message);

        }
        response.data = repData;
        // dataUser = ResInfoUser.fromJSON(result['data']);
        // String saveTemp = JSON.jsonEncode(result['data']);
        // await AppCache.saveData(Credential.userinfo, saveTemp);

        // Singleton.getInstance().dataUser = dataUser;
        // onCompleted!(status);
      } else if (code == "401" || code == "5999") {
        _loginThrottling.throttle(() {
          Future.delayed(const Duration(milliseconds: 400), () {
            if (code == "401") {
              SpUtil().clearUserData();
              AppCacheManager.instance.setUserToken('');
              Get.offAllNamed('/login');
            } else {
              // String? message0 = message;
              // g_t.Get.find<AppController>()
              //     .popMaintainPageIfNeeded(msg: message0);
              // if (g_t.Get.currentRoute != AppRoute.maintainRoute) {
              //   Navigator.pushReplacementNamed(
              //       g_t.Get.context!, AppRoute.maintainRoute,
              //       arguments: message0);
              // }
            }
          });
        });
        DioError e = DioError(
            requestOptions: response.requestOptions, response: response);
        handler.reject(e);
        return;
      }
      bool? success = repData["success"] as bool?;
      if (success == false) {
        FToast.toast(g_t.Get.context!, msg: message);
        DioError e = DioError(
            requestOptions: response.requestOptions, response: response);
        handler.reject(e);
        return;
      }
    }

    return super.onResponse(response, handler);
  }
}
