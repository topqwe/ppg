import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:ftoast/ftoast.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../util/PagingMixin.dart';

class MallSureLogic extends GetxController
    with GetTickerProviderStateMixin, PagingMixin {

  late EasyRefreshController easyRefreshController;

  var tabNames = [].obs;

  ///动画
  late AnimationController animationController;
  late Animation<double> turns;
  var playing = false.obs;

  @override
  void onInit() {
    easyRefreshController = EasyRefreshController();

    update();

    super.onInit();
  }





  @override
  void onClose() {
    // scrollController.dispose();
    super.onClose();
  }
}
