import 'dart:convert';
import '../response/response_info_user.dart';
import 'http.dart';

class ApiService {
  static const Api_loginP = "/web/users/login";
  static final _http = HttpV1();
  ///用户名
  static Future<ResInfoUser?> getUserInfo() async {
    final result = await _http.post(path: "getUserInfo",);
    if(result.code == 0 && result.data != null){
      return ResInfoUser.fromJson(result.data);
    }
    return null;
  }

  static Future<dynamic> login(var data) async {
    var result = await _http.post(path: Api_loginP,data: data);
    if(result.code == 0 && result.data != null){
      return result.data;
    }
    return null;
  }

  ///改码
  static Future<bool> setLoginPwd(String oldPayPwd,String newPayPwd,String opt) async {
    final result = await _http.post(path: "/setLoginPw", data: {'oldPwd':oldPayPwd,'newPwd':newPayPwd,'smsCode':opt},showLoading: true);
    return result.code == 0;
  }

}
