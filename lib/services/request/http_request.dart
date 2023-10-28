import 'dart:io';

// import 'package:bib_flutter/src/modules/channel/native_channel.dart';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';

import 'interceptor/error.dart';
import 'interceptor/request.dart';
import 'interceptor/retry.dart';
// import 'package:connectivity_plus/connectivity_plus.dart';
// import 'package:dio/io.dart';

// import 'interceptor/error.dart';
// import 'interceptor/request.dart';
// import 'interceptor/retry.dart';

class Http {
  static final Http _instance = Http._internal();

  factory Http() => _instance;

  late final Dio dio;

  List<CancelToken?> pendingRequest = [];

  Http._internal() {
    // BaseOptions、Options、RequestOptions 都可以配置参数，优先级别依次递增，且可以根据优先级别覆盖参数
    BaseOptions options = BaseOptions();
    dio = Dio(options);

    // 添加request拦截器
    dio.interceptors.add(RequestInterceptor());

    // 添加error拦截器
    dio.interceptors.add(ErrorInterceptor());
    // // 添加cache拦截器

    dio.interceptors.add(ResponseInterceptor());
    // // 添加retry拦截器
    dio.interceptors.add(
      RetryOnConnectionChangeInterceptor(
        requestRetrier: DioConnectivityRequestRetrier(
          dio: dio,
          connectivity: Connectivity(),
        ),
      ),
    );
    // if (!kReleaseMode) {
    //   dio.interceptors
    //       .add(LogInterceptor(responseBody: true, requestBody: true));
    // }

  }

  // 初始化公共属性
  // [baseUrl] 地址前缀
  // [connectTimeout] 连接超时赶时间
  // [receiveTimeout] 接收超时赶时间
  // [interceptors] 基础拦截器
  // adapter mock 数据 需移除所有拦截器
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
    );
    if (interceptors != null && interceptors.isNotEmpty) {
      dio.interceptors.addAll(interceptors);
    }
  }

  // 关闭所有 pending dio
  void cancelRequests() {
    pendingRequest.map((token) => token!.cancel('dio cancel'));
  }

  Map<String, dynamic>? getAuthorizationHeader() {
    Map<String, dynamic>? headers;

    return headers;
  }

  // 获取cancelToken , 根据传入的参数查看使用者是否有动态传入cancel，没有就生成一个
  CancelToken createDioCancelToken(CancelToken? cancelToken) {
    CancelToken token = cancelToken ?? CancelToken();
    pendingRequest.add(token);
    return token;
  }

  Future get(
    String path, {
    Map<String, dynamic>? params,
    Options? options,
    CancelToken? cancelToken,
    bool refresh = false,
    String? cacheKey,
    bool cacheDisk = false,
    bool showSuccessToast = false,
  }) async {
    Options requestOptions = options ?? Options();
    // requestOptions = requestOptions.copyWith(
    //   extra: {
    //     "refresh": refresh,
    //     "cacheKey": cacheKey,
    //     "cacheDisk": cacheDisk,
    //   },
    // );
    // Map<String, dynamic>? authorization = getAuthorizationHeader();
    // if (authorization != null) {
    //   requestOptions = requestOptions.copyWith(headers: authorization);
    // }
    Response response;

    // CancelToken dioCancelToken = createDioCancelToken(cancelToken);
    response = await dio.get(
      path,
      queryParameters: params,
      options: requestOptions,
      // cancelToken: dioCancelToken,
    );
    // pendingRequest.remove(dioCancelToken);
    return response.data;
  }

  Future post(
    String path, {
    Map<String, dynamic>? params,
    data,
    Options? options,
    CancelToken? cancelToken,
    bool hideErrorToast = false,
    bool showSuccessToast = false,
  }) async {
    Options requestOptions = options ?? Options();
    requestOptions.extra = {
      "hideErrorToast": hideErrorToast,
      "showSuccessToast": showSuccessToast,
    };
    Map<String, dynamic>? authorization = getAuthorizationHeader();
    if (authorization != null) {
      requestOptions = requestOptions.copyWith(headers: authorization);
    }
    // CancelToken dioCancelToken = createDioCancelToken(cancelToken);
    var response = await dio.post(
      path,
      data: data,
      queryParameters: params,
      options: requestOptions,
      // cancelToken: dioCancelToken,
    );
    // pendingRequest.remove(dioCancelToken);
    return response.data;
  }

  Future put(
    String path, {
    data,
    Map<String, dynamic>? params,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    Options requestOptions = options ?? Options();

    Map<String, dynamic>? authorization = getAuthorizationHeader();
    if (authorization != null) {
      requestOptions = requestOptions.copyWith(headers: authorization);
    }
    // CancelToken dioCancelToken = createDioCancelToken(cancelToken);
    var response = await dio.put(
      path,
      data: data,
      queryParameters: params,
      options: requestOptions,
      // cancelToken: dioCancelToken,
    );
    // pendingRequest.remove(dioCancelToken);
    return response.data;
  }

  Future patch(
    String path, {
    data,
    Map<String, dynamic>? params,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    Options requestOptions = options ?? Options();
    Map<String, dynamic>? authorization = getAuthorizationHeader();
    if (authorization != null) {
      requestOptions = requestOptions.copyWith(headers: authorization);
    }
    // CancelToken dioCancelToken = createDioCancelToken(cancelToken);
    var response = await dio.patch(
      path,
      data: data,
      queryParameters: params,
      options: requestOptions,
      // cancelToken: dioCancelToken,
    );
    // pendingRequest.remove(dioCancelToken);
    return response.data;
  }

  Future delete(
    String path, {
    data,
    Map<String, dynamic>? params,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    Options requestOptions = options ?? Options();

    Map<String, dynamic>? authorization = getAuthorizationHeader();
    if (authorization != null) {
      requestOptions = requestOptions.copyWith(headers: authorization);
    }
    // CancelToken dioCancelToken = createDioCancelToken(cancelToken);
    var response = await dio.delete(
      path,
      data: data,
      queryParameters: params,
      options: requestOptions,
      // cancelToken: dioCancelToken,
    );
    // pendingRequest.remove(dioCancelToken);
    return response.data;
  }
}
