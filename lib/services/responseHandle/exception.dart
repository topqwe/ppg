import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:liandan_flutter/util/LoadingBarrierView.dart';

class ApiException implements Exception {
  static const unknownException = "未知错误";
  final String? msg;
  final int? code;
  String? stackInfo;

  ApiException([this.code, this.msg]);

  factory ApiException.fromDioError(DioError error) {
    switch (error.type) {
      case DioErrorType.cancel:
        return BadRequestException(-1, "请求取消".tr);
      case DioErrorType.connectTimeout:
        return BadRequestException(-1, "连接超时".tr);
      case DioErrorType.sendTimeout:
        return BadRequestException(-1, "请求超时".tr);
      case DioErrorType.receiveTimeout:
        return BadRequestException(-1, "响应超时".tr);
      case DioErrorType.response:
        try {
          /// http错误码带业务错误信息
          var apiResponse = error.response?.data;
          if (apiResponse.code != null) {
            return ApiException(apiResponse['code'], apiResponse['msg'] );
          }

          int? errCode = error.response?.statusCode;
          switch (errCode) {
            case 400:
              return BadRequestException(errCode, "请求语法错误");
            case 401:
              return UnauthorisedException(errCode!, "没有权限");
            case 403:
              return UnauthorisedException(errCode!, "token过期请重新登录");
            case 404:
              return UnauthorisedException(errCode!, "无法连接服务器");
            case 405:
              return UnauthorisedException(errCode!, "请求方法被禁止");
            case 500:
              return UnauthorisedException(errCode!, "服务器内部错误");
            case 502:
              return UnauthorisedException(errCode!, "无效的请求");
            case 503:
              return UnauthorisedException(errCode!, "服务器异常");
            case 505:
              return UnauthorisedException(errCode!, "不支持HTTP协议请求");
            default:
              return ApiException(errCode, '未知错误，请联系客服'.tr);
          }
        } on Exception catch (e) {
          return ApiException(-1, unknownException);
        }
      default:
        return ApiException(-1, error.message);
    }
  }

  factory ApiException.from(dynamic exception) {

    if (exception is DioError) {
      return ApiException.fromDioError(exception);
    }
    if (exception is ApiException) {
      return exception;
    } else {
      var apiException = ApiException(-1, unknownException);
      apiException.stackInfo = exception?.toString().tr;
      return exception;
    }

  }
}

/// 请求错误
class BadRequestException extends ApiException {
  BadRequestException([int? code, String? msg])
      : super(code, msg.toString().tr);
}

/// 未认证异常
class UnauthorisedException extends ApiException {
  UnauthorisedException([int code = -1, String msg = '']) : super(code, msg);
}
