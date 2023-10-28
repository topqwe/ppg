import 'dart:core';
import 'api_basic.dart';
import 'api_error.dart';
import 'api_error_type.dart';

class AuthProvider  with ApiError {
  static const String urlhead = 'head';

  static const String urlauthcert = 'auth-cert';

  AuthProvider(this.apiBasic);
  // Cache get cache => _cache;
  // final Cache _cache;
  final ApiBasic apiBasic;

  // ResInfoUser? resInfoUser;
  String _imgCaptcha = "";

  String get imgCaptcha => _imgCaptcha;

  Future<bool> login(
      {required String name,
        required String password, }) async {
    Map data = {
      'name': name,
      'password': password,
    };
    await apiCallSafety(
          () => apiBasic.login(data),
      onStart: () async {
        // AppLoading.show(context);
      },
      onCompleted: (bool? status, dynamic result) async {
        // AppLoading.hide(context);
        if (status != null && status) {
          Map<String, dynamic> data = result;

          if (data['code'] == "200") {
            // resInfoUser = ResInfoUser.fromJson(result['data']);
            // FToast.toast("登录成功", context);


          } else {
            // FToast.toast((data['msg']), context);
          }
        }
      },
      onError: (dynamic error) async {
        // AppLoading.hide(context);
        final ApiErrorType errorType = await parseApiErrorType(error);
        // AppDialog.show(context, AppDialog.typeNotify, (errorType.message));

        // FToast.toast((errorType.message), context);
      },
      skipOnError: true,
    );
    return true;
  }


  @override
  void resetState() {
    _imgCaptcha = '';
  }

  @override
  Future<int> onApiError(error) {
    // TODO: implement onApiError
    throw UnimplementedError();
  }
}
