
class ResponseModel<T> {
   int code;
   String msg;
   T? data;

  ResponseModel.fromJson(Map<String, dynamic> m)
      : code = m['code']??-1,
        msg = m['msg']??"",
        data = m['data'];


  Map<String, dynamic> toJson() => {
    'code': code,
    'msg': msg,
    'data': data,
  };
}
