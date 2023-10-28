import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:dio/dio.dart';
// import 'package:new_live_flutter/common/utils/toast_utils.dart';

class MyDioSocketException implements SocketException {
  @override
  String message;

  @override
  final InternetAddress? address;

  @override
  final OSError? osError;

  @override
  final int? port;

  MyDioSocketException(
    this.message, {
    this.osError,
    this.address,
    this.port,
  });
}

// 错误处理拦截器
class ErrorInterceptor extends Interceptor {
  // 是否有网
  Future<bool> isConnected() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    return connectivityResult != ConnectivityResult.none;
  }

  @override
  Future<void> onError(DioError err, ErrorInterceptorHandler handler) async {
    // 错误提示
    debugPrint(
      'DioError===: ${err.message}}',
    );
    debugPrint(
      'DioError===: ${err.requestOptions.baseUrl} - ${err.requestOptions.path} - ${err.requestOptions.data}',
    );
    // 是否已经连接了网络，不判断是否没网
    // if (err.type == DioErrorType.other) {
    String msg = "Request timed out,please check your network status.";
    // err.error = msg;
    // }
    // error统一处理
    // publicInfoMsg("参数错误");
    // AppException appException = AppException.create(err);
    // publicErrorMsg(appException.getMessage());
    // err.error = appException;
    return super.onError(err, handler);
  }
}
