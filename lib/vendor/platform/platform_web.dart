import 'dart:async';
import 'dart:convert';

import 'package:get/get.dart';
import "package:universal_html/html.dart" as html;
import 'dart:html' as html1;

import '../../router/RouteConfig.dart';
import '../../services/cache/storage.dart';
import '../../util/JCHub.dart';
import '../bridge/bridge_call.dart';

class PlatformUtils {
  static copyText({String? text, bool showToast = false}) {
    if (text == null) {
      return;
    }
    try {
      copyToClipboard(text);
    } catch (_) {}

    try {
      final textArea = html.TextAreaElement();
      textArea.value = text;
      html.document.body?.append(textArea);
      textArea.focus();
      textArea.select();
      html.document.execCommand("copy");
      textArea.remove();
    } catch (_) {
      html.window.navigator.clipboard?.writeText(text);
    }

    if (showToast) {
      JCHub.showmsg("复制成功", Get.context!);
    }
  }

  static Future<bool> canSelectImage() async {
    // 查询相册权限状态
    var permission =
        await html.window.navigator.permissions?.query({'name': 'camera'});

    // 如果已授权，获取相册数据
    if (permission?.state == 'granted') {
      try {
        var stream = await html.window.navigator.mediaDevices
            ?.getUserMedia({'audio': false, 'video': true});
      } catch (e) {
        print('获取相册数据失败: $e');
      }
    }
    // 如果未授权，提示用户需要授权访问相册
    else if (permission?.state == 'prompt') {
      try {
        var result = await html.window.navigator.permissions
            ?.request({'name': 'camera'});
        if (result?.state == 'granted') {
          var stream = await html.window.navigator.mediaDevices
              ?.getUserMedia({'audio': false, 'video': true});
          // TODO: 处理相册数据
        } else {
          return false;
        }
      } catch (e) {}
    }
    // 如果被拒绝，提示用户需要授权访问相册
    else {
      return false;
    }

    return true;
  }

  static void appendingRoute({
    String page = RouteConfig.topup,
    Map<String, dynamic>? args,
  }) {
    var uri = Uri.parse(html1.window.location.href);
    Map<String, dynamic> ujson = publicUserInfo()?.toJson() ?? {};
    ujson["isOutChromeBrowser"] = "1";
    ujson.removeWhere((key, value) => value == null || value == "");
    String encodedString = base64.encode(utf8.encode(json.encode(ujson)));
    String baseUrl = uri.origin;
    if (baseUrl.endsWith("/")) {
      baseUrl = baseUrl.substring(0, baseUrl.length - 1);
    }

    String path =
        "$baseUrl/$page?token=${publicToken()}&userInfo=$encodedString";
    if (args != null) {
      String tail = "";
      args.forEach((key, value) {
        tail += "&$key=$value";
      });
      path = "$path$tail";
    }
    copyText(text: path, showToast: true);
  }

  static String getUserAgent() {
    return html.window.navigator.userAgent;
  }

  static void bindAlias(String? uid) {}

  static void clearJPushBinding() {}

  static String getChannel() {
    return "h5";
  }

  static String getPlatform() {
    return "Chrome";
  }

  static void toWebView({String? title, String? url}) {
    html.window.location.href = url ?? "";
  }

  static void toSupportPage({String? title, String? url}) async {
    html.window.location.href = url ?? "";
  }

  static void toSupportPageForLogin({String? title, String? url}) {
    html.window.location.href = url ?? "";
  }

  static Future configServiceAfterAppLaunch() async {
    return null;
  }
}
