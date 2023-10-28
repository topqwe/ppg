class ResponseBase {
  ResponseBase({this.code, this.msg, this.data});

  String? code;
  String? msg;
  String? data;
}

class APIResponse<T> {
  T? data;
  bool? success;
  String? code;
  String? msg;
  APIResponse({this.data, this.msg, this.code, this.success});
}
