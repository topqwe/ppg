library utils;
import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:ftoast/ftoast.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import '../api/request/apis.dart';
import '../api/request/request.dart';
import '../api/request/request_client.dart';
import '../store/AppCacheManager.dart';
import '../style/theme.dart';
import 'package:url_launcher/url_launcher.dart';

import '../lang/LanguageManager.dart';
class SliverSectionHeaderDelegate extends SliverPersistentHeaderDelegate {
  SliverSectionHeaderDelegate(this.widget, this.height);
  final Widget widget;
  final double height;
  // minHeight 和 maxHeight 的值设置为相同时，header就不会收缩了
  @override
  double get minExtent => height;

  @override
  double get maxExtent => height;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return widget;
  }

  @override
  bool shouldRebuild(SliverSectionHeaderDelegate oldDelegate) {
    return true;
  }
}

class SliverTabBarDelegate extends SliverPersistentHeaderDelegate {
  final TabBar widget;
  final Color color;
  const SliverTabBarDelegate(this.widget, {required this.color})
      : assert(widget != null);
  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Align(
        alignment: Alignment.center, // default value
        child:
        //   AnimatedCrossFade(
        // crossFadeState: CrossFadeState.showFirst,

        Container(
          child: widget,
          color: color,
          // )
        ));
  }

  @override
  bool shouldRebuild(SliverTabBarDelegate oldDelegate) {
    return false; //// 如果内容需要更新，设置为true
  }

  @override
  double get maxExtent => widget.preferredSize.height; //200.0;
  @override
  double get minExtent => widget.preferredSize.height; //100.0
}

postUserInfo()=> request(() async {
  var user = await requestClient.post(APIS.userInfo,data: {
  });
  AppCacheManager.instance.setValueForKey(kUserInfo, json.encode(user));
});

postCheckFundSW()=> request(() async {
  var user = await requestClient.post(APIS.home,data: {});
  AppCacheManager.instance.setValueForKey(kFSW, '${user['safeword']}');
});

/// 调起拨号页
 Future<void> launchTelURL(String phone) async {
final Uri uri = Uri.parse('tel:$phone');
if (await canLaunchUrl(uri)) {
await launchUrl(uri);
} else {
  FToast.toast(Get.context!, msg:'拨号失败！');
}
}

Future<void> launchWebURL(appStoreUrl) async {
  String? lang = 'en';
  lang = LanguageManager.instance.currentLanguageRequestParam;

  String? token = AppCacheManager.instance.getUserToken();
  String url = appStoreUrl + '?lang=${lang}&token=${token}';
  Uri onlineUrl = Uri.parse(url);
  // if (!await launchUrl(onlineUrl)) throw 'Could not launch $onlineUrl';
  if (!await launch(url)) throw 'Could not launch $url';
}
/**
 * 字符串转为double
 */
double toDouble(dynamic? str, {double defaultValue = 0, int? scale}) {
  if (str == null) {
    return defaultValue;
  }
  try {
    if (scale == null) {
      return double.parse(str.toString());
    } else {
      return double.parse(double.parse(str.toString()).toStringAsFixed(scale));
    }
  } catch (e) {
    print(e);
    return defaultValue;
  }
}

List<List<T>> splitList<T>(List<T> list, int len) {
  if (len <= 1) {
    return [list];
  }
  List<List<T>> result = [];
  int index = 1;
  while (true) {
    if (index * len < list.length) {
      List<T> temp = list.skip((index - 1) * len).take(len).toList();
      result.add(temp);
      index++;
      continue;
    }
    List<T> temp = list.skip((index - 1) * len).toList();
    result.add(temp);
    break;
  }
  return result;
}

String getRandomAvator() {
  /// 生成的字符串固定长度

  List list = [];
  for (var i = 1; i < 7; i++) {
    String s = 'assets/images/home/avators/ava_${(i.toString())}.jpg';
    list.add(s);
  }
  var element = list[Random().nextInt(list.length)];

  return element;
}

String getRandomStr(bool isPureNum, int strlenght) {
  /// 生成的字符串固定长度
  String alphabet = isPureNum
      ? '0123456789'
      : '0123456789qwertyuiopasdfghjklzxcvbnmQWERTYUIOPASDFGHJKLZXCVBNM';

  String left = '';
  for (var i = 0; i < strlenght; i++) {
//    right = right + (min + (Random().nextInt(max - min))).toString();
    left = left + alphabet[Random().nextInt(alphabet.length)];
  }
  return left;
}


showAlertDialog(BuildContext context, VoidCallback okcb, VoidCallback canclecb,
    String title, String content) {
  //设置按钮

  Widget cancelButton = FlatButton(
    child: Text(("取消")),
    onPressed: () {
      Get.back();
      canclecb();

    },
    color: AppTheme.themeGreyColor,
  );
  Widget continueButton = FlatButton(
    child: Text(("确定")),
    onPressed: () {
      // popPage(context);
      Get.back();
      okcb();
    },
    color: AppTheme.themeHightColor,
  );

  //设置对话框
  AlertDialog alert = AlertDialog(
    title: Container(
        alignment: Alignment.center,
        child:Text((title) )),
    content: Container(
      alignment: Alignment.center,
      child: Text((content)),
      height: 30,
    ),
    actions: [
      Container(
        padding: EdgeInsets.only(left: 30, right: 30, bottom: 15),
        // color: Colors.blue,
        alignment: Alignment.center,
        child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          cancelButton,
          SizedBox(
            width: 50,
          ),
          continueButton
        ]),
      ),
    ],
  );

  //显示对话框
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}


bool isEmail(String input) {
  String regexEmail =
      "^([a-z0-9A-Z]+[-|\\.]?)+[a-z0-9A-Z]@([a-z0-9A-Z]+(-[a-z0-9A-Z]+)?\\.)+[a-zA-Z]{2,}\$";
  if (input == null || input.isEmpty) return false;
  return new RegExp(regexEmail).hasMatch(input);
}

openPage(Widget widget, BuildContext context) {
  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) {
      return widget;
    }),
  );
}

int lastclickTime = 0;
popPage(BuildContext context) {
  if (DateTime.now().millisecondsSinceEpoch - lastclickTime < 1000) {
    return;
  }
  lastclickTime = DateTime.now().millisecondsSinceEpoch;
  if (Navigator.canPop(context)) {
    Get.back();
  } else {
    Navigator.of(context).pushReplacementNamed("/index");
  }
}
