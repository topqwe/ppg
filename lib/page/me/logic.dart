import 'dart:async';
import 'dart:convert';
import 'package:flutter/animation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../services/api/api_basic.dart';
import '../../services/responseHandle/request.dart';
import '/store/AppCacheManager.dart';
import '/widgets/helpTools.dart';

class MeLogic extends GetxController with GetSingleTickerProviderStateMixin {
  var listModels = [].obs;
  late ScrollController scrollController;
  var boolSafeword = 0.obs;
  var boolId = 0.obs;
  var boolCanEdit = 0.obs;

  var ma = '0.0'.obs;
  var mb = '0.0'.obs;
  var userInfo = {}.obs;
  late AnimationController animationController;
  late Animation<double> turns;
  var playing = false.obs;

  void onInit() {
    super.onInit();
    scrollController = ScrollController();
    listModels.value = [
      {'name': '语言', 'index': 0,'icon':Icon(Icons.language)},
      {'name': '下载', 'index': 1,'icon':Icon(Icons.downloading)},
      {'name': '设置', 'index': 2,'icon':Icon(Icons.settings)},

    ];

    animationInit();
    // Future.delayed(const Duration(seconds: 1)).then((value) {//once load
    //   if(AppCacheManager.instance.getValueForKey(kUserInfo)!='null') {
    //     Map<String, dynamic> jsonMap = json.decode(AppCacheManager.instance.getValueForKey(kUserInfo));
    //     userInfo.value = jsonMap;
    //     update();
    //   }
    // });
    requestMoney(false);
  }

  void clickBottomIndex() {
    if (AppCacheManager.instance.getValueForKey(kUserInfo) != 'null') {
      Map<String, dynamic> jsonMap =
          json.decode(AppCacheManager.instance.getValueForKey(kUserInfo));
      userInfo.value = jsonMap;
      update();
    }
    postCheckInfosStatus();
  }

  void postCheckInfosStatus() => request(() async {
        var user = await ApiBasic().me({});
        if (user['code'] == 0) {
          boolId.value = user['safeword'];
          boolSafeword.value = user['safeword'];
          boolCanEdit.value =
              // 1;
              (boolId.value != 2 || boolSafeword != 1) ? 1 : 0;
        }

        // (boolId.value == 0||
        //     boolId.value == 3)?
        // 1
        //     :
        // 0
        //    ;
        if (boolId.value == 0) {
        } else {}

        if (boolSafeword.value == 0) {
        } else {}
        update();
      });

  void animationInit() {
    animationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 60),
    );

    /// 设置动画取值范围和时间曲线
    turns = Tween(begin: 100.0, end: 200.0).animate(animationController);
  }

  void requestMoney(isRefresh) => request(() async {
        if (isRefresh) {
          animationController.forward()
            ..whenComplete(() => animationController.reverse());
          playing.value = true;
          animationController.repeat(reverse: true);
        }

        var user = await ApiBasic().me({});
        if (user['code'] == 0) {
          if (isRefresh) {
            Timer.periodic(Duration(milliseconds: 2000), (t) async {
              t.cancel(); // 定时器内部触发销毁
              ma.value = '${user['money']}';
              mb.value = '${user['rebate']}';

              if (playing.value) {
                playing.value = false;
                animationController.stop();
              }
            });
          } else {
            ma.value = '${user['money']}';
            mb.value = '${user['rebate']}';
          }
          return;
        }
      });
}
