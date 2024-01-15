library utils;
import 'dart:convert';
import 'dart:math';
import 'dart:typed_data';
import 'package:crypto/crypto.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:ftoast/ftoast.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:image_compression_flutter/image_compression_flutter.dart';
import 'package:liandan_flutter/services/api/api_basic.dart';
import 'package:liandan_flutter/services/newReq/http.dart';

import '../main.dart';
import '../services/request/http_utils.dart';
import '../services/responseHandle/request.dart';
import '../store/AppCacheManager.dart';
import '../style/theme.dart';
import 'package:url_launcher/url_launcher.dart';

import '../lang/LanguageManager.dart';
import '../util/InAppWV.dart';
import '../util/JCHub.dart';
import '../util/UpdatePage.dart';
import '../../../vendor/platform/platform_universial.dart'
if (dart.library.io) '../../../vendor/platform/platform_native.dart'
if (dart.library.html) '../../../vendor/platform/platform_web.dart'
as platformutil;
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

void fetchOSSDomainList() async {
  try {
    final response = await Dio().get(
      configEnv.domainListPath,
      options: Options(responseType: ResponseType.plain),
    );
    print('resquest1');
    print(response);
    // if (response.statusCode == 200) {
    String val = response.toString();
    var result = jsonDecode(val);
    print('before'+configEnv.appBaseUrl);
    print('result'+result['mainDomain']);
    configEnv.appBaseUrl = result['mainDomain'] ?? configEnv.appBaseUrl;
    AppCacheManager.instance.setCurrentDomainKey('${result['mainDomain']}');
    print('after'+AppCacheManager.instance.getCurrentDomainKey());
    // HttpUtil.init(baseUrl: configEnv.appBaseUrl);
    HttpV1().init(baseUrl: configEnv.appBaseUrl);
    if (!kIsWeb)checkAppUpdate(result);
    try {

      // if (json?["http"] != null) {
      // List domains = json?["http"];
      // domainList = domains.map((e) => e as String).toList();
      // startTest();
      // }
    } catch (error) {
      // rethrow;
    }
    // }
  } catch (e) {

  }
}

Future<bool> testLinkCorrect(String link) async {
  String url =

      link
  ;
  bool isCorrect = false;



  try {
    final response = await Dio().get(
      url,
      options: Options(responseType: ResponseType.plain),
    );
    // String? result = response.data as String?;

    print('test link''${response.realUri}');
    // if (response['code'] == 200){
    if (response.statusCode == 200){
      isCorrect = true;
      // String? result = response.data as String?;

      try {

      } catch (error) {
        // print('er');
        // rethrow;
      }
    }
  } catch (e) {
    print('eeee');
    isCorrect = false;
    // The request was made and the server responded with a status code
    // that falls out of the range of 2xx and is also not 304.
  }
  return isCorrect;
}

void checkAppUpdate(var res) async {
  if (res != null) {
    var v = res['version'];
    if (( v['release'] ?? "").isEmpty) {
      return;
    }
    bool showAlert = needUpdate(configEnv.localversion, v['release']);
    if (showAlert ) {
      showAppUpdatePopup(res);
    }
  }
}

bool needUpdate(String currentVersion, String newVersion) {
  List<String> current = currentVersion.split('.');
  List<String> latest = newVersion.split('.');

  for (int i = 0; i < 3; i++) {
    int a = int.parse(current[i]);
    int b = int.parse(latest[i]);

    if (a < b) {
      return true;
    } else if (a > b) {
      return false;
    }
  }

  return false;
}

Future<Uint8List?> compressImage(Uint8List imgBytes,
{required String path, int quality = 70}) async {
final input = ImageFile(
rawBytes: imgBytes,
filePath: path,
);
Configuration config = Configuration(
outputType: ImageOutputType.jpg,
// can only be true for Android and iOS while using ImageOutputType.jpg or ImageOutputType.pngÏ
useJpgPngNativeCompressor: !kIsWeb,
// set quality between 0-100
quality: quality,
);
final param = ImageFileConfiguration(input: input, config: config);
final output = await compressor.compress(param);
return output.rawBytes;
}


postUserInfo()=> request(() async {
  var user = await ApiBasic().home({});
  AppCacheManager.instance.setValueForKey(kUserInfo, json.encode(user));
});

postCheckFundSW()=> request(() async {
  var user = await ApiBasic().home({});
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

String toMD5(String data) {
Uint8List content = const Utf8Encoder().convert(data);
Digest digest = md5.convert(content);
return digest.toString();
}

void copyText({String? text, bool showToast = false}) {
  platformutil.PlatformUtils.copyText(text: text, showToast: showToast);
}

bool noUppercaseLetter(String pwd,) {
  if (!pwd.contains(RegExp("[A-Z]+"))) {
    JCHub.showmsg("登陆密码必须包含1个大写字母", Get.context!);
    return false;
  }
  return true;
}

bool noContinuouslyTheSame(String pwd,) {
bool judgeContinuouslyTheSameDigits(String str) {
RegExp sameDigits = RegExp(r'^(\d)\1{5}$');
var string = '0123456789_9876543210';

return sameDigits.hasMatch(str) || string.contains(str);
}

bool result = judgeContinuouslyTheSameDigits(pwd);
if (result) {
JCHub.showmsg("不可使用连续数字或6位相同的数字", Get.context!);
}
return !result;
}

bool validateMobile(String value) {

  RegExp regExp = RegExp(
      r"^1([38][0-9]|4[579]|5[0-3,5-9]|6[6]|7[0135678]|9[89])\d{8}$");
  if (value.isNotEmpty) {
    if (!regExp.hasMatch(value)) {
      return false;
    }
  }

  return true;
}
// https://cloud.tencent.com/developer/article/1456584
bool validateEmail(String value) {
  return RegExp(
      r"^\w+([-+.]\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*$")
      .hasMatch(value);
}


String anonymizeString(String? input) {

  if ((input ?? "").length <= 7) {
    return input ?? "";
  }
  int len = input!.length;
  String result = input.replaceRange(3, len-4, '*' * (len - 7));
  return result;
}

List<String> trimPicsDomain(List<String> pics) {
List<String> newPics = [];

if (pics.isNotEmpty) {
for (var i = 0; i < pics.length; i++) {

if(pics[i].isNotEmpty) {
var arr = pics[i].split('.com');
String str2 = arr.last;
String str3 = '';
str3 = configEnv.appBaseUrl + str2;
newPics.add(str3);
}

}
}
return newPics;
}

String trimPicDomain(String pic) {
  String newPic = '';
      if(pic.isNotEmpty) {
        var arr = pic.split('.com');
        String str2 = arr.last;
        String str3 = '';
        str3 = configEnv.appBaseUrl + str2;
        newPic = str3;
      }

  return newPic;
}

Color enumTypeColor({required int type}) {
  if (type>0&&type<100) {
    return Colors.green;
  } else if (type>101&&type<600) {
    return Colors.yellow;
  } else if (type>600&&type!=1000000) {
    return Colors.red;
  }
  return Colors.grey;
}

String enumType({required String type}) {
  if (type == "1") {
    return '1';
  } else if (type == "2") {
    return '2';
  } else if (type == "3") {
    return '3';
  }
  return '0';
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

String visibleString(String str) {
  if (str.length < 2) {
    return str;
  }
  if (str.length == 2) {
    String first = str.substring(0, 1);
    return "$first*";
  } else {
    String first = str.substring(0, 1);
    String last = str.substring(str.length - 1, str.length);
    return "$first*$last";
  }
}


showAlertDialog(BuildContext context, VoidCallback okcb, VoidCallback canclecb,
    String title, String content) {
  //设置按钮

  Widget cancelButton = TextButton(
    child: Text(("取消")),
    onPressed: () {
      Get.back();
      canclecb();

    },
    // color: AppTheme.themeGreyColor,
        style: TextButton.styleFrom(foregroundColor:AppTheme.themeGreyColor, // foreground
            // minimumSize: Size(50, 50),
            // padding: EdgeInsets.only(left: 25, right: 25),
            // shape: const RoundedRectangleBorder(
            //   borderRadius: BorderRadius.all(Radius.circular(2)),
            ),
  );
  Widget continueButton = TextButton(
    child: Text(("确定")),
    onPressed: () {
      // popPage(context);
      Get.back();
      okcb();
    },
    // color: AppTheme.themeGreyColor,
    style: TextButton.styleFrom(foregroundColor:AppTheme.themeGreyColor, // foreground
      // minimumSize: Size(50, 50),
      // padding: EdgeInsets.only(left: 25, right: 25),
      // shape: const RoundedRectangleBorder(
      //   borderRadius: BorderRadius.all(Radius.circular(2)),
    ),
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

openCustomWebView(BuildContext context, var settings) {
  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) {
      List<dynamic> args = settings as List;
      bool showAppbar = false;
      if (args.length == 3) {
        showAppbar = args[2] as bool;
      }
      return InAppWV(
        title: args[0],
        url: args[1],
        showAppBar: showAppbar,
      );
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
