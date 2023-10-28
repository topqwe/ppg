import 'dart:async';
import 'dart:ui';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_update_dialog/update_dialog.dart';
import 'package:ftoast/ftoast.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:liandan_flutter/services/api/api_basic.dart';
import '../services/responseHandle/request.dart';
import '../style/theme.dart';
// import 'package:native_updater/native_updater.dart';
import 'package:package_info/package_info.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:throttling/throttling.dart';
import 'package:url_launcher/url_launcher.dart';

import '../lang/LanguageManager.dart';
import '../store/AppCacheManager.dart';
import '../widgets/helpTools.dart';
import 'UpdateView.dart';

class UpdateVersion {
  updateFun(context, bool isFromHome) async {
    final thr = Throttling(duration: const Duration(seconds: 1)); //total
    thr.throttle(() {
      getConfigData();
    });
    await Future<void>.delayed(const Duration(seconds: 1));
    thr.throttle(() {
      checkVersion(context, isFromHome);
    });
    await thr.close();
  }

  void getConfigData() => request(() async {
        String pl = '1';
        if (Platform.isAndroid) {
          pl = '2';
        } else {
          pl = '1';
        }
        var res = await ApiBasic().config({'plantform': pl});
        var data = res['data'];
        String downloadlink = data['downloadlink'].toString();
        String version = data['latestVersion'].toString();
        String latestContent = data['content'].toString();
        String latestTitle = data['title'].toString();
        int latestStatus = data['status'];
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('downloadlink', downloadlink);
        await prefs.setString('latestVersion', version);
        await prefs.setString('latestContent', latestContent);
        await prefs.setString('latestTitle', latestTitle);
        await prefs.setInt('latestStatus', latestStatus);
        // update();
      });

  checkVersion(context, bool isFromHome) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String downloadlink = prefs.getString('downloadlink')!;
    String latestVersion = prefs.getString('latestVersion')!;
    String latestContent = prefs.getString('latestContent')!;
    String latestTitle = prefs.getString('latestTitle')!;
    int latestStatus = prefs.getInt('latestStatus')!;
    if (latestStatus != 0) {
      PackageInfo.fromPlatform().then((PackageInfo packageInfo) {
        String appName = packageInfo.appName;
        String packageName = packageInfo.packageName;
        String localVersion =
            // '1.0.0';
            packageInfo.version;
        AppCacheManager.instance.setVersionNo(latestVersion);

        prefs.setString('localVersion', localVersion);
        String localBuildNumber = packageInfo.buildNumber;

        Future.delayed(const Duration(seconds: 0), () {
          if (haveNewVersion(latestVersion, localVersion)) {
            if (latestStatus == 1) {
              Get.dialog(
                  UpdateView(downloadlink, latestVersion, latestContent,
                      latestTitle, false, isFromHome),
                  barrierDismissible: false);

            } else {
              Get.dialog(
                  UpdateView(downloadlink, latestVersion, latestContent,
                      latestTitle, true, isFromHome),
                  barrierDismissible: false);

            }
          } else {
            if (!isFromHome) FToast.toast(context, msg: '当前已是最新版本，无需更新~'.tr);
          }
        });
      });
    } else {
      if (!isFromHome) FToast.toast(context, msg: '当前已是最新版本，无需更新~'.tr);
      // Get.dialog(UpdateView(
      //     downloadlink, latestVersion,
      //     latestContent,latestTitle,
      //     true,isFromHome),barrierDismissible:false);
    }
  }

  forceAlertView(context, String appStoreUrl, String latestVersion,
      String latestContent, String latestTitle) {
    Get.defaultDialog(
      title: latestTitle,
      //'发现新版本'.tr+'V'+latestVersion,
      middleText: "",
      backgroundColor: Colors.white,
      titleStyle: TextStyle(color: Colors.black, fontSize: 18),
      middleTextStyle: TextStyle(color: Colors.black, fontSize: 18),
      textConfirm: '立即更新'.tr,
      onConfirm: () {
        Navigator.of(context).pop();
        Get.offNamed('/index');
        launchWebURL(appStoreUrl);
      },
      // textCancel: '暂不更新'.tr,
      // onCancel: (){
      //   Get.offNamed('/index');
      // },
      cancelTextColor: Colors.black,
      confirmTextColor: Colors.white,
      buttonColor: AppTheme.themeHightColor,
      barrierDismissible: false,
      radius: 4,
      content: Text(
        latestContent,
        style: TextStyle(color: Colors.black, fontSize: 14),
      ),

    );


  }

  alertView(context, String appStoreUrl, String latestVersion,
      String latestContent, String latestTitle) {
    Get.defaultDialog(
      title: latestTitle,
      //'发现新版本'.tr+'V'+latestVersion,
      middleText: "",
      backgroundColor: Colors.white,
      titleStyle: TextStyle(color: Colors.black, fontSize: 18),
      middleTextStyle: TextStyle(color: Colors.black, fontSize: 18),
      textConfirm: '立即更新'.tr,
      onConfirm: () {
        Navigator.of(context).pop();
        Get.offNamed('/index');
        launchWebURL(appStoreUrl);
      },
      textCancel: '暂不更新'.tr,
      onCancel: () {
        Get.offNamed('/index');
      },
      cancelTextColor: Colors.black,
      confirmTextColor: Colors.white,
      buttonColor: AppTheme.themeHightColor,
      barrierDismissible: false,
      radius: 4,
      content: Text(
        latestContent,
        style: TextStyle(color: Colors.black, fontSize: 14),
      ),

    );
  }



  bool haveNewVersion(String newVersion, String old) {
    if (newVersion == null || newVersion.isEmpty || old == null || old.isEmpty)
      return false;
    int newVersionInt, oldVersion;
    var newList = newVersion.split('.');
    var oldList = old.split('.');
    if (newList.length == 0 || oldList.length == 0) {
      return false;
    }
    for (int i = 0; i < newList.length; i++) {
      newVersionInt = int.parse(newList[i]);
      oldVersion = int.parse(oldList[i]);
      if (newVersionInt > oldVersion) {
        return true;
      } else if (newVersionInt < oldVersion) {
        return false;
      }
    }

    return false;
  }
}
