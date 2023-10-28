import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../../vendor/socket/web_socket_utility.dart';
import '../response/basic_info_entity.dart';
import '../response/response_info_user.dart';


const String userInfoKey = "userInfoKey";
const String uidKey = "uidKey";
const String tokenKey = "tokenKey";
const String currentDomainKey = "currentDomainKey";


ResInfoUser? publicUserInfo() => SpUtil().getUserInfo();
BasicInfoEntity? publicAppConfig() => SpUtil().appConfig;
String? publicToken() => SpUtil().getToken();

bool publicCheckLogin() {
  return (publicToken() ?? "").isNotEmpty;
}

class SpUtil {
  ResInfoUser? userInfo;
  BasicInfoEntity? appConfig;
  String? token;
  int? uid;


  void getLocalStorage() {
    getUserInfo();
    getToken();
  }

  void clearUserData({bool closeWs = true}) {
    saveUserInfo(null);
    saveToken(null);
    remove(userInfoKey);
    remove(tokenKey);
    if (closeWs) {
      WebSocketUtility.getInstance().closeSocket();
    }
  }

  void saveUserInfo(ResInfoUser? data) {

    userInfo = data;
    setJSON(userInfoKey, data?.toJson());
  }

  ResInfoUser? getUserInfo() {
    if (userInfo != null) {
      return userInfo;
    }
    Map<String, dynamic>? infoJson = getJSON(userInfoKey);
    if (infoJson != null) {
      userInfo = ResInfoUser.fromJson(infoJson);
    }
    return userInfo;
  }
  void saveUid(int? data) {
    uid = data;
    setInt(uidKey, data ?? -1);
  }

  int? getUid() {
    if (uid != -1) {
      return uid;
    }
    int? infoJson = getInt(uidKey);
    uid = infoJson;
    return uid;
  }


  void saveToken(String? data) {
    token = data;
    setString(tokenKey, data ?? "");
  }

  String? getToken() {
    if ((token ?? "").isNotEmpty) {
      return token;
    }
    String? infoJson = getString(tokenKey);
    token = infoJson;
    return token;
  }

  SpUtil._internal();

  static final SpUtil _instance = SpUtil._internal();

  factory SpUtil() {
    return _instance;
  }

  SharedPreferences? prefs;

  Future<void> init() async {
    prefs = await SharedPreferences.getInstance();
  }

  Future<bool> setJSON(String key, dynamic jsonVal) {
    String jsonString = jsonEncode(jsonVal);
    return prefs!.setString(key, jsonString);
  }

  dynamic getJSON(String key) {
    String? jsonString = prefs?.getString(key);
    return jsonString == null ? null : jsonDecode(jsonString);
  }

  Future<bool> setBool(String key, bool val) {
    return prefs!.setBool(key, val);
  }

  bool? getBool(String key) {
    return prefs!.getBool(key);
  }

  Future<bool> setInt(String key, int val) {
    return prefs!.setInt(key, val);
  }

  int? getInt(String key) {
    return prefs!.getInt(key);
  }

  String? getString(String key) {
    return prefs!.getString(key);
  }

  Future<bool> setString(String key, String val) {
    return prefs!.setString(key, val);
  }

  Future<bool> remove(String key) {
    return prefs!.remove(key);
  }
}
