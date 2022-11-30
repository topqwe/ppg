

import 'package:flutter/cupertino.dart';
import 'package:ftoast/ftoast.dart';
import 'package:get/get.dart';
import '../../../../store/AppCacheManager.dart';
import '../../../api/request/apis.dart';
import '../../../api/request/request.dart';
import '../../../api/request/request_client.dart';
import '../../../widgets/helpTools.dart';
import '../../../util/SafeValidWidget.dart';

class RegisterLogic extends GetxController {
  var controller;
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
    print(str);
    print(controller);
  }
  void post_tijiao(){
    if(tab_show.value==1){
      register_form(Get.context);
    }else{
      register_phone_form(Get.context);
    }
  }
  void register_form (context){

    if(controller.text==''){
      FToast.toast(context, msg: "请输入账号".tr);
      return;
    }
    if(controller2.text==''){
      FToast.toast(context, msg: "请输入密码".tr);
      return;
    }
    if(controller3.text==''){
      FToast.toast(context, msg: "请输入邀请码".tr);
      return;
    }
    (showSafeValidPage(context, ()
    {
      register(context, true);
    }, () {}));
  }
  void register_phone_form (context){
    if(controller.text==''){
      FToast.toast(context, msg: "请输入手机号".tr);
      return;
    }
    if(controller2.text==''){
      FToast.toast(context, msg: "请输入密码".tr);
      return;
    }
    if(controller3.text==''){
      FToast.toast(context, msg: "请输入邀请码".tr);
      return;
    }
    (showSafeValidPage(context, ()
    {
      register_phone(context, true);
    }, () {}));
  }
  void register_phone(context,showLoading)=> request(() async {
    var url = APIS.registerP;
    var data = {
      'phone':controller.text,
      'password':controller2.text,
      'usercode':controller3.text,
    };
    var user = await requestClient.post(url,data: data);
    FToast.toast(context, msg: "注册成功".tr);
    AppCacheManager.instance.setUserToken('${user['token']}');
    postUserInfo();
    postCheckFundSW();
    Get.toNamed('/index');
    return;
  },showLoading: showLoading);

  void register(context,showLoading) => request(() async {
    var url = APIS.register;
    var data = {
      'username':'${controller.text}',
      'password':controller2.text,
      'usercode':controller3.text,
    };
    var user = await requestClient.post(url,data: data);
    FToast.toast(context, msg: "注册成功".tr);
    AppCacheManager.instance.setUserToken('${user['token']}');
    postUserInfo();
    postCheckFundSW();
    Get.toNamed('/index');
    return;
  },showLoading: showLoading);

}
