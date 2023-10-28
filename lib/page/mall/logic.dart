import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../services/api/api_basic.dart';
import '../../store/AppCacheManager.dart';
import '../../../util/PagingMixin.dart';

class MallLogic extends GetxController
    with GetTickerProviderStateMixin, PagingMixin {


  var headDatas = {}.obs;

  var tabNames = [].obs;

  ///动画
  late AnimationController animationController;
  late Animation<double> turns;
  var playing = false.obs;

  @override
  void onInit() {
    animationInit();


    headDatas.value = {
      'points': '88888',
    };

    clickBottomIndex();

    update();

    super.onInit();
  }

  void animationInit() {
    /// 初始化动画控制器，设置动画时间
    animationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 60),
    );

    /// 设置动画取值范围和时间曲线
    turns = Tween(begin: 100.0, end: 200.0).animate(animationController);
  }

  void toggle() {
    // if (playing.value) {
    //   playing.value = false;
    //   animationController.stop();
    // } else {

    animationController.forward()
      ..whenComplete(() => animationController.reverse());
    playing.value = true;
    animationController.repeat(reverse: true);
    requestHeaderData(true);
    // }
  }

  void clickBottomIndex() {
    requestHeaderData(false);
  }


  Future<void> requestHeaderData(bool isAnimationDelay) async {

    var data = await ApiBasic().dummy({});
    if (isAnimationDelay) {
      Timer.periodic(Duration(milliseconds: 2000), (t) {
        headDatas.value = data;
        t.cancel(); // 定时器内部触发销毁
        if (playing.value) {
          playing.value = false;
          animationController.stop();
        }
      });
    } else {
      headDatas.value = data;
    }
    update();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
