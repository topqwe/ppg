import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import '../request/token_interceptor.dart';

Dio dio = Dio();

class HttpUtils {
  HttpUtils() {
    dio.interceptors.add(TokenInterceptor());
    dio.interceptors.add(PrettyDioLogger(
        requestHeader: true, requestBody: true, responseHeader: true));
  }
  Future get(path, query) async {
    Response resp;
    try {
      resp = await dio.get(path, queryParameters: query);

      if (resp.statusCode == 200) {
        String val = resp.toString();
        return jsonDecode(val);
      } else {
        String val = resp.toString();
        return jsonDecode(val);
      }
    } catch (error) {
      return error;
    }
  }
  postImage(url, image, imageName) async {
    Response resp;
    try {
      // String path = image.path;
      // var name = path.substring(path.lastIndexOf("/") + 1, path.length);
      // print(path);
      Map<String, dynamic> formMap = {};
      var value = await MultipartFile.fromBytes(image,
          filename:imageName);
      formMap['file'] = value;
      FormData formData = FormData.fromMap(formMap);
      resp = await dio.post(url, data: formData,options: Options(contentType: 'multipart/form-data'));
      if (resp.statusCode == 200) {
        String val = resp.toString();
        return jsonDecode(val);
      } else {

        String val = resp.toString();
        print(val);
        return jsonDecode(val);
      }
    } catch (error) {
      return error;
    }
  }
   post(path2, image) async {
    Response resp;
    try {
      String path = image.path;
      var name = path.substring(path.lastIndexOf("/") + 1, path.length);
      print(path);
      Map<String, dynamic> formMap = {};
      var fileass = await MultipartFile.fromFile(path,
          filename:'123.png' );
      formMap['file'] = fileass;
      FormData formData = FormData.fromMap(formMap);
      resp = await dio.post(path2, data: formData);
      if (resp.statusCode == 200) {
        String val = resp.toString();
        return jsonDecode(val);
      } else {

        String val = resp.toString();
        print(val);
        return jsonDecode(val);
      }
    } catch (error) {
      return error;
    }
  }

  Future put(path, data) async {
    Response resp;
    try {
      resp = await dio.put(path, data: data);
      if (resp.statusCode == 200) {
        String val = resp.toString();
        return jsonDecode(val);
      } else {
        String val = resp.toString();
        return jsonDecode(val);
      }
    } catch (error) {
      return error;
    }
  }
}

