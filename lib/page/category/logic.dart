import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:ftoast/ftoast.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../util/PagingMixin.dart';

class CategoryLogic extends GetxController
    with GetTickerProviderStateMixin, PagingMixin {

  var headDatas = {}.obs;

  var tabNames = [].obs;

  ///动画
  late AnimationController animationController;

  @override
  void onInit() {

    super.onInit();
    headDatas.value = {'a':90000000};

  }



  Future<void> clickBottomIndex() async {

  }

  @override
  void onClose() {
    super.onClose();
  }
}
