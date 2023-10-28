import 'package:flutter/cupertino.dart';
import 'package:liandan_flutter/router/RouteConfig.dart';

class PlatformUtils {
  static copyText({String? text, bool showToast = false}) {}

  static Future<bool> canSelectImage() async {
    return Future.value(true);
  }

  static void appendingRoute({
    String page = RouteConfig.topup,
    Map<String, dynamic>? args,
  }) {}

  static String getUserAgent() {
    return "";
  }

  static void bindAlias(String? uid) {}

  static void clearJPushBinding() {}

  static String getChannel() {
    return "";
  }

  static String getPlatform() {
    return "";
  }

  static void toWebView({String? title, String? url}) {}

  static void toSupportPage({String? title, String? url}) async {}

  static void toSupportPageForLogin({String? title, String? url}) {}

  static Future configServiceAfterAppLaunch() async {}
}
