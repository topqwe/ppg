import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:ftoast/ftoast.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../../../services/api/api_basic.dart';
import '../../../services/responseHandle/request.dart';
import '../../../store/EventBus.dart';
import '../../../util/LoadingBarrierView.dart';

import '../../../util/FrequencyClick.dart';

class SetAddAddrLogic extends GetxController {
  var timer_fun;
  var area = [].obs;
  var controller0;
  var controller;
  var controller1;
  var controller2;
  var controller3;

  var status0 = 1.obs;

  var cTxt = ''.obs;
  var cTxt1 = ''.obs;
  var cTxt2 = ''.obs;
  var cTxt3 = ''.obs;

  void onInit() {
    // TODO: implement onInit
    super.onInit();
    controller0 = TextEditingController();
    controller0.addListener(() {});


    controller1 = TextEditingController();
    controller1.text =
        Get.arguments == '0' ? '' : Get.arguments['contacts'].toString();
    cTxt1.value = controller1.text;
    controller1.addListener(() {
      cTxt1.value = controller1.text;
      update();
    });


    controller = TextEditingController();
    controller.text =
    Get.arguments == '0' ? '河北省 廊坊市 三河市' : Get.arguments['area'].toString();
    cTxt.value = controller.text;
    controller.addListener(() {
      cTxt.value = controller.text;
      update();
    });
    area.value =cTxt.value.contains(' ')? cTxt.value.split(" "):[];


    controller2 = TextEditingController();
    controller2.text =
        Get.arguments == '0' ? '' : Get.arguments['address'].toString();
    cTxt2.value = controller2.text;
    controller2.addListener(() {
      cTxt2.value = controller2.text;
      update();
    });

    controller3 = TextEditingController();
    controller3.text =
        Get.arguments == '0' ? '138' :
        // Get.arguments == '0' ? '' :
        Get.arguments['phone'].toString();
    cTxt3.value = controller3.text;
    controller3.addListener(() {
      cTxt3.value = controller3.text;
      update();
    });

    status0 = Get.arguments == '0'
        ? 1.obs
        : int.parse(Get.arguments['use'].toString()).obs;
  }

  void textFieldChanged(String str) {
    print(str);
    // print(controller);
  }

  void txtForm(context) {
    if (controller1.text == '') {
      FToast.toast(context, msg: "请输入姓名".tr);
      return;
    }
    if (controller2.text == '') {
      FToast.toast(context, msg: "请输入地址".tr);
      return;
    }
    if (controller3.text == '') {
      FToast.toast(context, msg: "请输入手机号".tr);
      return;
    }

    postRequest(context);
  }

  void postRequest(context) => request(() async {
        if (timer_fun != null) {
          return;
        }
        timer_fun = Timer(
          Duration(milliseconds: Frequency.frequencyCount),
          () {
            timer_fun = null;
          },
        );
        // LoadingBarrierView.showLoading(Get.context!);
        var data = {};
        String tostr = '';
        var params = {
          'contacts': controller1.text,
          'address': controller2.text,
          'phone': controller3.text,
          'use': status0.value
        };
        if (Get.arguments != '0') {
          params['id'] = Get.arguments['id'].toString();
          data = await ApiBasic().home({});
          tostr = "修改成功".tr;
        } else {
          data = await ApiBasic().home({});
          tostr = "添加成功".tr;
        }
        // LoadingBarrierView.hideLoading(Get.context!);
        FToast.toast(context, msg: tostr);
        mainEventBus.emit(
          EventBusConstants.grabRefreshAddrListEvent,
          data,
        );
        // Get.arguments == '0'?Get.back():Get.offNamed('/setAddrList',arguments: Get.arguments);
        // Get.offNamed('/setAddrList',arguments: '0');
        Get.back();
        // Get.offNamed('/index');
        // params['orderId']= Get.arguments;
        // var data2 = await requestClient.post(APIS.bindAddress, data: params);
        //
        // FToast.toast(context, msg: "添加成功");
        // Get.offNamed('/taskDetail',arguments: Get.arguments);
        update();
      },showLoading: true);
}
