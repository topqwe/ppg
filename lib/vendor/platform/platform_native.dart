import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:jpush_flutter/jpush_flutter.dart';
import 'package:liandan_flutter/router/RouteConfig.dart';
import 'package:liandan_flutter/widgets/helpTools.dart';
import 'package:loggy/loggy.dart';
import 'package:meiqia_sdk_flutter/meiqia_sdk_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../services/cache/storage.dart';
import '../../util/JCHub.dart';
import 'platform_universial.dart'
if (dart.library.io) 'platform_native.dart'
if (dart.library.html) 'platform_web.dart'
as platformutil;
String? mqErrorMsg;
int mqInitCount = 0;

class PlatformUtils {
  static copyText({String? text, bool showToast = false}) {
    if (text == null) {
      return;
    }

    final data = ClipboardData(text: text);
    Clipboard.setData(data);
    if (showToast) {
      JCHub.showmsg("复制成功", Get.context!);
    }
  }

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

  static void bindAlias(String? uid) {
    JPush().setTags([uid ?? ""]);
    JPush().setAlias(uid ?? "");
  }

  static void clearJPushBinding() {
    JPush().cleanTags();
    JPush().deleteAlias();
  }

  static String getChannel() {
    return GetPlatform.isAndroid ? "android" : "ios";
  }

  static String getPlatform() {
    return GetPlatform.isAndroid ? "android" : "ios";
  }

  static void toWebView({String? title, String? url}) {
    openCustomWebView(Get.context!, [
      title ?? "",
      url ?? "",
    ]);
  }

  static void toSupportPage({String? title, String? url}) async {
    if (mqErrorMsg != null) {
      if (mqInitCount < 3) {
        await configServiceAfterAppLaunch();//chat
        if (mqErrorMsg != null) {
          platformutil.PlatformUtils.toSupportPageForLogin(
            title: "查询".tr,
            url: publicAppConfig()?.serviceUrl,
          );
          return;
        }
      } else {
        platformutil.PlatformUtils.toSupportPageForLogin(
          title: "查询".tr,
          url: publicAppConfig()?.serviceUrl,
        );
        return;
      }
    }
    Style style = Style(
      navBarBackgroundColor: '#ffffff', // 设置导航栏的背景色
      navBarTitleTxtColor: '#000000', // 设置导航栏上的 title 的颜色
      enableShowClientAvatar: false, // 是否支持当前用户头像的显示
      enableSendVoiceMessage: true, // 是否支持发送语音消息
    );
    MQManager.instance.show(style: style);
    // final Uri url0 = Uri.parse(url ?? "");
    // launchUrl(url0, mode: LaunchMode.externalApplication);
  }

  static void toSupportPageForLogin({String? title, String? url}) {
    // toSupportPage(title: title, url: url);
    final Uri url0 = Uri.parse(url ?? "");
    launchUrl(url0, mode: LaunchMode.externalApplication);
  }

  static Future configServiceAfterAppLaunch() async {
    String? errorMsg =
        await MQManager.init(appKey: 'MQKey');
    mqErrorMsg = errorMsg;
    mqInitCount += 1;
    logInfo("MQManager ----- $errorMsg");
    return null;
  }
}
