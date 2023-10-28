
import 'dart:convert';
import 'dart:io';

import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';

import 'package:flutter/foundation.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:liandan_flutter/services/newReq/request_model.dart';

import '../../main.dart';
import '../../store/AppCacheManager.dart';
import '../cache/storage.dart';


class HttpV1 {
  // 单例模式使用Http类，
  static final HttpV1 _instance = HttpV1._internal();
  factory HttpV1() => _instance;
  static late final Dio dio;
  String? token;
  /// 内部构造方法
  HttpV1._internal() {
    /// 初始化dio
    BaseOptions options = BaseOptions(
        connectTimeout:10000,
        receiveTimeout: 10000,
        contentType: ContentType.json.value,
        responseType: ResponseType.plain,
        baseUrl: '');

    dio = Dio(options);
    dio.httpClientAdapter = DefaultHttpClientAdapter()..onHttpClientCreate = (client){
        client.badCertificateCallback = (cert, host, port) => true;
      return client;
      };
  }

  void init({
    String? baseUrl,
    int connectTimeout = 15000,
    int receiveTimeout = 15000,
    List<Interceptor>? interceptors,
    HttpClientAdapter? adapter,
  }) {
    if (adapter != null) {
      dio.interceptors.clear();
      dio.httpClientAdapter = adapter;
    }
    dio.options = dio.options.copyWith(
      baseUrl: baseUrl,
      connectTimeout:  connectTimeout,
      receiveTimeout:  receiveTimeout,
      contentType: ContentType.json.value,
      responseType: ResponseType.plain,
    );
    if (interceptors != null && interceptors.isNotEmpty) {
      dio.interceptors.addAll(interceptors);
    }
  }

  /// 封装request方法
  Future<String?> request({required String path, //接口地址
    required HttpMethod method, //请求方式
    dynamic data, //数据
    Map<String, dynamic>? queryParameters,
    bool showLoading = false, //加载过程
    bool showErrorMessage = true, //返回数据
  }) async {
    //动态添加header头
    final String xAuthToken = AppCacheManager.instance.getUserToken().isNotEmpty?
    AppCacheManager.instance.getUserToken():"";//publicToken() ??
    final int xUserId = AppCacheManager.instance.getUserId();
    String? lang = AppCacheManager.instance.getAppLanguage();
    final Map<String, dynamic> header = <String, dynamic>{
      "X-APP-VERSION": configEnv.localversion,
      "lang": lang,
      "x-token": xAuthToken,
      "x-uid": xUserId,
    };
    dio.options.method =method.name;
    dio.options.baseUrl = AppCacheManager.instance.getCurrentDomainKey();
    dio.options.headers = header;
    // Options options = Options(method: method.name, headers: headers,
    //   sendTimeout: const Duration(seconds: 10),
    //   receiveTimeout: const Duration(seconds: 10),);
    Options options = Options(headers: header, contentType: ContentType.json.value);
    try {
      if (showLoading) {
        EasyLoading.show(maskType: EasyLoadingMaskType.black);
      }
      final response = await dio.request(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
      );
      if (kDebugMode) {
        print('method:${method.name}'
            '\n \t\t url:${dio.options.baseUrl}$path '
            '\n \t\t statusCode:${response.statusCode} '
            '\n \t\t header:\n\t\t\t\t${jsonEncode(dio.options.headers)} '
            '\n \t\t requestBody:${jsonEncode(method != HttpMethod.get ? data:queryParameters)}'
            '\n \t\t response:\n\t\t\t\t$response \n');

      }
      return response.data;
    } on DioError catch (error) {
      print('error==url:${dio.options.baseUrl}$path \n${error.response?.statusCode}');

      // final String? data = error.response?.data;
      // if(data != null){
      //   return data;
      // }
    } finally {
      if (showLoading) {
        EasyLoading.dismiss();
      }
    }
    return null;
  }
  /// get
   Future<ResponseModel> get<T>({required String path, Map<String, dynamic>? queryParameters, bool showLoading = false, bool showErrorMessage = false,}) async {
    String? response =  await request(
      path: path,
      method: HttpMethod.get,
      queryParameters: queryParameters,
      showLoading: showLoading,
      showErrorMessage: showErrorMessage,
    );
    Map<String, dynamic> res = jsonDecode(response??"{}");
    ResponseModel<T> result = ResponseModel.fromJson(res);
    if(result.code != 0){
      handlerError(path,queryParameters,result);
    }
    return result;
  }

  /// post
   Future<ResponseModel> post<T>({required String path, dynamic data, bool showLoading = false, bool showErrorMessage = false,}) async {
    String? response =  await request(
      path: path,
      method: HttpMethod.post,
      data: data,
      showLoading: showLoading,
      showErrorMessage: showErrorMessage,
    );
    Map<String, dynamic> res = jsonDecode(response ?? "{}");
    ResponseModel<T> result = ResponseModel.fromJson(res);
    if(result.code != 0){
      handlerError(path,data,result);
    }
    return result;
  }

  void handlerError(String path, Map<String, dynamic>? queryParameters, ResponseModel<dynamic> result) async{
    print('http==url:${dio.options.baseUrl}$path \n param:${queryParameters.toString()},response :${result.toJson()}');
    if(result.code == -1){
      return;
    }
    if (result.code == "401") {
      SpUtil().clearUserData();
      AppCacheManager.instance.setUserToken('');
      Get.offAllNamed('/login');
    }
    EasyLoading.showError(result.msg,duration: const Duration(milliseconds: 1200));
  }

}

enum HttpMethod {
  get,
  post,
  delete,
  put,
  patch,
  head,
}