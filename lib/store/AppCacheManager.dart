
import 'dart:async';
import 'dart:io';
import 'package:httpplugin/httpplugin.dart';
import 'package:get_storage/get_storage.dart';
import 'package:path_provider/path_provider.dart';

 const kFSW = 'kFSW';
 const kUserInfo = 'kUserInfo';



class AppCacheManager with CacheBase{
  static AppCacheManager? _instance;
  static AppCacheManager get instance => _instance ?? _getInstance();
  AppCacheManager._();

  GetStorage _storage = GetStorage();

  static AppCacheManager _getInstance(){
    _instance = AppCacheManager._();
    return _instance!;
  }

  // 用户token
  final String _userToken = "user_token";

  final String _isLogin = "false";

  // 用户token
  final String _versionNo = "versionNo";

  // app 语言
  final String _appLanguage = "app_language";

  void setUserToken(String token) async {
    _storage.write(_userToken, token);
  }

  String getUserToken() {
    var value = '';
    try{
      value =  _storage.read(_userToken);
      // value ??= '';
      if(value.toString()=='null'||value.toString()=='')value='';

    }catch(e){
      value = '';
    }
    return value;
  }

  // void setIsLogin(bool isLogin) async {
  //   _storage.write(_isLogin, isLogin);
  // }
  //
  // bool getIsLogin() {
  //   bool value = false;
  //   try{
  //     value =   _storage.read(_isLogin);
  //   }catch(e){
  //     value = false;
  //   }
  //   return value;
  // }



  void setVersionNo(String versionNo) async {
    _storage.write(_versionNo, versionNo);
  }

  String getVersionNo() {
    String value = '1.0.0';
    try{
      value =  _storage.read(_versionNo);
    }catch(e){
      value = '1.0.0';
    }
    return value;
  }


  void setAppLanguage(String language) async{
    _storage.write(_appLanguage, language);
  }

  String? getAppLanguage(){
    String? value;
    try{
      value =  _storage.read(_appLanguage);
      print(""+value.toString());
    }catch(e){
      print(""+e.toString());
    }
    return value;
  }

  @override
  String getValueForKey(String key) {
    return _storage.read(key);
  }

  @override
  void setValueForKey(String key, dynamic value) {
    _storage.write(key, value);
  }

  /// 加载缓存大小
  Future<_CacheEntity> loadCacheSize() async{
    /// 获取临时文件路径
    Directory tempDir = await getTemporaryDirectory();
    print("tempDir.path:"+tempDir.path);
    /// 获取临时文件的大小
    double size = await _getSize(tempDir);
    print(size);
    /// 返回临时文件大小格式转换
    return renderSize(size);
  }

  /// 递归获取所有文件
  Future<double> _getSize(FileSystemEntity file) async{
    if (file is File) {
      int length = await file.length();
      return length.toDouble();
    } else if (file is Directory) {
      if (file.path.endsWith("libCachedImageData")) {
        return 0;
      }
      /// 文件路径下面的所有文件
      final Iterator<FileSystemEntity> children = file.listSync().iterator;
      double total = 0;
      while(children.moveNext()) {
        FileSystemEntity entity = children.current;
        /// 递归获取
        total += await _getSize(entity);
      }
      return total;
    }
    return 0;
  }

  /// 计算文件大小
  _CacheEntity renderSize(double? size) {
    List<String> unit = ["B", "K", "M", "G"];
    if (size == null) {
      return _CacheEntity(cacheSize: 0, unit: unit[0]);
    } else {
      int index = 0;
      while (size! > 1024) {
        index ++;
        size = size / 1024;
      }
      /// 保留两位小数
      double value = (size * 100).ceil() / 100;
      /// 返回模型
      return _CacheEntity(unit: unit[index], cacheSize: value);
    }
  }

  Future<Null> clearCache() async{
    Directory tempDir = await getTemporaryDirectory();
    await _delDir(tempDir);
  }

  Future<Null> _delDir(FileSystemEntity file) async{
    if (file is Directory) {
      if (file.path.endsWith("libCachedImageData")) {
        return;
      }
      /// 获取文件路径下所有文件
      Iterator<FileSystemEntity> iterator = file.listSync().iterator;
      while (iterator.moveNext()) {
        FileSystemEntity entity = iterator.current;
        /// 递归删除
        await _delDir(entity);
      }
    }
    try {
      /// 删除文件夹
      await file.delete();
    }catch(e){
      print("delete error $e");
    }
  }
}

class _CacheEntity {
  _CacheEntity({this.cacheSize: 0, this.unit: "B"});
  final double cacheSize;
  final String unit;
}