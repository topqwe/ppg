
import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../store/AppCacheManager.dart';
import '../../page/category/view.dart';
import '../../util/DropSelectMenu/drop_select_demo_page.dart';
import '../../util/FrequencyClick.dart';
import '../category/logic.dart';

import '../home/view.dart';
import '../mall/view.dart';
import '../me/logic.dart';
import '../me/view.dart';

class BottomLogic extends GetxController
    with GetSingleTickerProviderStateMixin {
  final categoryLogic = Get.put(CategoryLogic());
  final meLogic = Get.put(MeLogic());
  final currentIndex = 0.obs;
  final pages = [
    HomePage(),
    DropSelectDemoPage(),
  ].obs;

  late AnimationController animationController;
  late Animation<double> turns;
  var playing = false.obs;

  var freTimer;
  void onInit() {
    super.onInit();
    currentIndex.value = 0;
    animationInit();
    statusToken();
  }
  void animationInit() {
    animationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 60),
    );

    turns = Tween(begin: 100.0, end: 200.0).animate(animationController);
  }

  void toggle() {
    animationController.forward().whenComplete(() => animationController.reverse());
    playing.value = true;
    animationController.repeat(reverse: true);
  }

  Future<void> statusToken() async {
    if(AppCacheManager.instance.getUserToken().isEmpty){
      Get.offAll('/login');
    }

  }


  changePage(int index) {
    if (freTimer != null) {
      return;
    }
    freTimer = Timer(
      Duration(milliseconds: Frequency.frequencyCount),
      () {
        freTimer = null;
      },
    );
    if (index == 2) {
      //   return;
    }

    if (index == 4) {
      meLogic.clickBottomIndex();
    }

    if (index != currentIndex.value) {
      currentIndex.value = index;
      update();
    }
  }


  @override
  void dispose() {
    super.dispose();
    animationController.dispose();
  }
}
