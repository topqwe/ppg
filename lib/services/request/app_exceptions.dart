import 'package:dio/dio.dart';


class AppException implements Exception {
  final String _message;
  final int _code;

  AppException(
    this._code,
    this._message,
  );

  @override
  String toString() {
    return "$_code$_message";
  }

  String getMessage() {
    return _message;
  }

  factory AppException.create(DioError error) {
    switch (error.type) {
      case DioErrorType.other:
        {
          try {
            int? errCode = error.response!.statusCode;
            return AppException(errCode!, error.response!.statusMessage!);
          } on Exception catch (_) {
            return AppException(-1, "UnKnown");
          }
        }
      default:
        {
          return AppException(-1, "UnKnown");
        }
    }
  }
}


class BadRequestException extends AppException {
  BadRequestException(int code, String message) : super(code, message);
}


class UnauthorisedException extends AppException {
  UnauthorisedException(int code, String message) : super(code, message);
}
