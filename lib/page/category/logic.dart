import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:ftoast/ftoast.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../api/request/apis.dart';
import '../../../api/request/request.dart';
import '../../../api/request/request_client.dart';
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
  }



  Future<void> clickBottomIndex() async {

  }

  @override
  void onClose() {
    super.onClose();
  }
}
