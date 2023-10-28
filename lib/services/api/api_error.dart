import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:ftoast/ftoast.dart';
import 'package:get/get.dart';

import 'api_error_type.dart';

mixin ApiError {
  /// This function was called when trigger safeCallApi
  /// and apiError = true as default
  Future<int> onApiError(dynamic error);

  /// Call api safety with error handling.
  /// Required:
  /// - dioApi: call async dio function
  /// Optional:
  /// - onStart: the function executed before api, can be null
  /// - onError: the function executed in case api crashed, can be null
  /// - onCompleted: the function executed after api or before crashing, can be null
  /// - onFinally: the function executed end of function, can be null
  /// - skipOnError: false as default if you want to forward the error to onApiError
  Future<T?> apiCallSafety<T>(
    Future<T?> Function() dioApi, {
    Future<void> Function()? onStart,
    Future<void> Function(dynamic error)? onError,
    Future<void> Function(bool status, T? res)? onCompleted,
    Future<void> Function()? onFinally,
    bool skipOnError = false,
  }) async {
    try {
      /// On start, use for show loading
      if (onStart != null) {
        await onStart();
      }

      /// Execute api
      final T? res = await dioApi();

      /// On completed, use for hide loading
      if (onCompleted != null) {
        await onCompleted(true, res);
      }

      /// Return api response
      return res;
    } on DioError catch (_, error) {
      String msg = "网络异常，请检查网络设置";
      FToast.toast(Get.context!, msg: msg);

      /// In case error:
      /// On completed, use for hide loading
      if (onCompleted != null) {
        await onCompleted(false, null);
      }

      /// On inline error
      if (onError != null) {
        await onError(error);
      }

      /// Call onApiError
      if (skipOnError == false) {
        onApiError(error);
      }

      return null;
    } finally {
      /// Call finally function
      if (onFinally != null) {
        await onFinally();
      }
    }
  }

  /// Parsing error to ErrorType
  Future<ApiErrorType> parseApiErrorType(dynamic error,
      {BuildContext? context}) async {
    if (error is DioError ) {
      ApiErrorCode errorCode = ApiErrorCode.unknown;
      return ApiErrorType(code: errorCode, message: "UnKnown");
    } else if (error is TimeoutException) {
      return ApiErrorType(
          code: ApiErrorCode.unknown, message: error.message ?? "UnKnown");
    }
    return ApiErrorType();
  }
}
