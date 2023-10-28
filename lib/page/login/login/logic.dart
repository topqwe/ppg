import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:ftoast/ftoast.dart';
import 'package:get/get.dart';
import 'package:liandan_flutter/services/newReq/ApiService.dart';
import '../../../services/api/api_basic.dart';
import '../../../services/responseHandle/request.dart';
import '../../../store/AppCacheManager.dart';
import '../../../store/EventBus.dart';
import '../../../widgets/helpTools.dart';
import '../../../util/SafeValidWidget.dart';

class LoginLogic extends GetxController {
  late TextEditingController controller;
  var controller2;
  var controller3;

  var cTxt = ''.obs;
  var cTxt2 = ''.obs;
  var cTxt3 = ''.obs;
  var tab_show = 1.obs;

  var isObscureText = true.obs;
  void onInit() {
    // TODO: implement onInit
    super.onInit();

    controller = TextEditingController(text: '');
    cTxt.value = controller.text;
    controller.addListener(() {cTxt.value = controller.text;
    update();});
    controller2 = TextEditingController(text: '',);
    cTxt2.value = controller2.text;
    controller2.addListener(() {
      cTxt2.value = controller2.text;
    // update();
    });
    controller3 = TextEditingController();
    cTxt3.value = controller3.text;
    controller3.addListener(() {cTxt3.value = controller3.text;
    update();});
  }

  void textFieldChanged(String str) {
    // print(str);
  }
  postSubmit(){
    if (tab_show.value == 1) {
      accountLoginForm(Get.context);
    } else {
      phoneLoginForm(Get.context);
    }
  }
  void phoneLoginForm (context){
    if(controller.text==''){
      FToast.toast(context, msg: "请输入手机号".tr);
      return;
    }
    if(controller2.text==''){
      FToast.toast(context, msg: "请输入密码".tr);
      return;
    }
    (showSafeValidPage(context, ()
    {
      phoneLogin(context, true);
    }, () {}));
  }



  void phoneLogin(context,showLoading)=> request(() async {

    var data = {
      'phone':controller.text,
      'password':controller2.text,
    };
  var response = await ApiBasic().login(data);
  if (response['code'] == 0) {
    FToast.toast(context, msg: "登录成功".tr);
    AppCacheManager.instance.setUserToken('${response['data']['token']}');
    AppCacheManager.instance.setUserId(response['data']['uid']);
    postUserInfo();
    postCheckFundSW();
    Get.toNamed('/index');
    return;
  }else{
    FToast.toast(Get.context!, msg: '${response['msg']}');
  }
  }, showLoading: showLoading);

  void accountLoginForm(context) {
    if (controller.text == '') {
      FToast.toast(context, msg: "请输入账号".tr);
      return;
    }
    if (controller2.text == '') {
      FToast.toast(context, msg: "请输入密码".tr);
      return;
    }
    // (showSafeValidPage(context, ()
    // {
      accountLogin(context, true);
    // }, () {}));
  }

  void accountLogin(context,showLoading) => request(() async {

        var data = {
          'username': controller.text,
          'password': controller2.text,
        };
        var data0 = await ApiService.login(data);
        // var response = await ApiBasic().login(data);
        if (0 == 0) {
          var data = data0;
          //response['data'];
          FToast.toast(context, msg: "登录成功".tr);
          AppCacheManager.instance.setUserToken('${data['token']}');
          AppCacheManager.instance.setUserId(data['uid']);
          postUserInfo();
          postCheckFundSW();
          mainEventBus.emit(
            EventBusConstants.loginSuccessEvent,
            '1',
          );
          Get.toNamed('/index');
          return;
        }else{
          // FToast.toast(Get.context!, msg: '${response['msg']}');
        }
      }, showLoading: showLoading);
}
