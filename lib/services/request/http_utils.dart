
import 'package:dio/dio.dart';

import 'http_request.dart';
import 'dart:convert';
class HttpUtil {
  static void init({
    required String baseUrl,
    int connectTimeout = 15000,
    int receiveTimeout = 15000,
    List<Interceptor>? interceptors,
    HttpClientAdapter? adapter,
  }) {
    Http().init(
      baseUrl: baseUrl,
      connectTimeout: connectTimeout,
      receiveTimeout: receiveTimeout,
      interceptors: interceptors,
      adapter: adapter,
    );
  }

  static Future get(
    String path, {
    Map<String, dynamic>? params,
    Options? options,
    CancelToken? cancelToken,
    bool refresh = false,
    String? cacheKey,
    bool cacheDisk = false,
    bool showSuccessToast = false,
  }) async {
    return await Http().get(
      path,
      params: params,
      options: options,
      cancelToken: cancelToken,
      refresh: refresh,
      cacheKey: cacheKey,
    );
  }



  // static postImage(url, image, imageName) async {
  //   Response resp;
  //   try {
  //     // String path = image.path;
  //     // var name = path.substring(path.lastIndexOf("/") + 1, path.length);
  //     // print(path);
  //     Map<String, dynamic> formMap = {};
  //     var value = await MultipartFile.fromBytes(image,
  //         filename:imageName);
  //     formMap['file'] = value;
  //     FormData formData = FormData.fromMap(formMap);
  //     resp = await Dio().post(url, data: formData,options: Options(contentType: 'multipart/form-data'));
  //     if (resp.statusCode == 200) {
  //       String val = resp.toString();
  //       return jsonDecode(val);
  //     } else {
  //
  //       String val = resp.toString();
  //       print(val);
  //       return jsonDecode(val);
  //     }
  //   } catch (error) {
  //     return error;
  //   }
  // }
  // static postImage2(path2, image) async {
  //   Response resp;
  //   try {
  //     String path = image.path;
  //     var name = path.substring(path.lastIndexOf("/") + 1, path.length);
  //     print(path);
  //     Map<String, dynamic> formMap = {};
  //     var fileass = await MultipartFile.fromFile(path,
  //         filename:'123.png' );
  //     formMap['file'] = fileass;
  //     FormData formData = FormData.fromMap(formMap);
  //     resp = await Dio().post(path2, data: formData);//Http()
  //     if (resp.statusCode == 200) {
  //       String val = resp.toString();
  //       return jsonDecode(val);
  //     } else {
  //
  //       String val = resp.toString();
  //       print(val);
  //       return jsonDecode(val);
  //     }
  //   } catch (error) {
  //     return error;
  //   }
  // }

  static Future post(
      String path, {
        data,
        Map<String, dynamic>? params,
        Options? options,
        CancelToken? cancelToken,
        bool hideErrorToast = false,
        bool showSuccessToast = false,
      }) async {
    return await Http().post(
      path,
      data: data,
      params: params,
      options: options,
      cancelToken: cancelToken,
      showSuccessToast: showSuccessToast,
      hideErrorToast: hideErrorToast,
    );
  }

  static Future put(
    String path, {
    data,
    Map<String, dynamic>? params,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    return await Http().put(
      path,
      data: data,
      params: params,
      options: options,
      cancelToken: cancelToken,
    );
  }

  static Future patch(
    String path, {
    data,
    Map<String, dynamic>? params,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    return await Http().patch(
      path,
      data: data,
      params: params,
      options: options,
      cancelToken: cancelToken,
    );
  }

  static Future delete(
    String path, {
    data,
    Map<String, dynamic>? params,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    return await Http().delete(
      path,
      data: data,
      params: params,
      options: options,
      cancelToken: cancelToken,
    );
  }
}
