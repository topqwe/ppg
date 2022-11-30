import 'package:flutter/cupertino.dart';
import 'package:ftoast/ftoast.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../api/request/apis.dart';
import '../../../api/request/request.dart';
import '../../../api/request/request_client.dart';
import '../../../store/AppCacheManager.dart';
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
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    controller = TextEditingController();
    controller.addListener(() {cTxt.value = controller.text;
    update();});
    controller2 = TextEditingController();
    controller2.addListener(() {cTxt2.value = controller2.text;
    update();});
    controller3 = TextEditingController();
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

    var url = APIS.loginP;
    var data = {
      'phone':controller.text,
      'password':controller2.text,
    };
    var user = await requestClient.post(url,data: data);
    FToast.toast(context, msg: "登录成功".tr);
    AppCacheManager.instance.setUserToken('${user['token']}');
    postUserInfo();
    postCheckFundSW();
    Get.toNamed('/index');
    return;
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
    (showSafeValidPage(context, ()
    {
      accountLogin(context, true);
    }, () {}));
  }

  void accountLogin(context,showLoading) => request(() async {
        var url = APIS.login;
        var data = {
          'username': controller.text,
          'password': controller2.text,
        };
        var user = await requestClient.post(url, data: data);
        FToast.toast(context, msg: "登录成功".tr);
        AppCacheManager.instance.setUserToken('${user['token']}');
        postUserInfo();
        postCheckFundSW();
        Get.toNamed('/index');
        return;
        update();
      }, showLoading: showLoading);






}
