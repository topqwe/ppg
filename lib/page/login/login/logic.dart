import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:ftoast/ftoast.dart';
import 'package:get/get.dart';
import 'package:liandan_flutter/main.dart';
import 'package:liandan_flutter/services/newReq/ApiService.dart';
import 'package:liandan_flutter/services/request/http_utils.dart';
import 'package:loggy/loggy.dart';
import '../../../services/api/api_basic.dart';
import '../../../services/cache/storage.dart';
import '../../../services/network_service.dart';
import '../../../services/newReq/http.dart';
import '../../../services/responseHandle/request.dart';
import '../../../store/AppCacheManager.dart';
import '../../../store/EventBus.dart';
import '../../../store/EventBusNew.dart';
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
  var isSaveTFName = true.obs;

  var curR = ''.obs;
  var curRIn = ''.obs;
  var curRate =  0.obs;

  int selIndex = 0;
  var selArr = configEnv.env==1?<String>[
    '线路A', '线路B', '线路C','线路D', '线路E','线路F', '线路G',
  ].obs
      :
  <String>[
    '线路A', '线路B' ,
  ].obs;
  var selRoutes = configEnv.env==1? <String>[
    'https://aaa.com',
    'https://bbb.com',
    'https://ccc.com',
    'https://ddd.com',
    'https://eee.com',
    'https://fff.com',
    'https://ggg.com',
  ].obs
      :
  <String>[
    'https://aaa.com',
    'https://bbb.com',
  ].obs
  ;

  var selRates = configEnv.env==1?
  <String>[
    '1000000','1000000','1000000','1000000','1000000','1000000','1000000'
  ].obs:
  <String>[
    '1000000','1000000'
  ].obs;

  void startTest() async {

    List<NetworkTestModel> modelList = selRoutes
        .map(
          (e) => NetworkTestModel(url: e),
    )
        .toList();

    List<NetworkTestModel> testModelList =
    await Future.wait(modelList.map((e) async {
      await e.testSpeed();
      return e;
    }).toList());
    List<String> temselRates = [];
    List<NetworkTestModel> assembleNoNullModels = [];
    List<NetworkTestModel> noNullModels = testModelList;
    testModelList.where((element) => element.speed != null).toList();

    for(var i = 0; i < noNullModels.length; i++) {
      NetworkTestModel mod = noNullModels[i];
      String bs = '1000000';
      var sm = mod.toJson();
      if(sm.isNotEmpty){
        int ss = sm['speed'] ?? 1000000;
        if(ss==1000000){
          bs = '1000000';
        }
        if(ss>9&&ss!=1000000){
          bs = '$ss';
          bs = bs.substring(0,bs.length-1);
        }
        mod.speed = ss;
      }

      assembleNoNullModels.add(mod);
      temselRates.add(bs);
    }

    // setState(() {
    if(temselRates.isNotEmpty){
      selRates.value = [];
      selRates.value = temselRates.obs;
      update();
    }
    // });

    // if(selRates.isNotEmpty&&
    // selIndex<selRates.length){
    //   setState(() {
    //     curR = '${selArr[selIndex]}';
    //     curRate = int.parse(selRates[selIndex]);
    //     if(curRate==1000000){
    //       curRIn = '(测速中)';
    //     }else{
    //       curRIn = '(${selRates[selIndex]} ms)';
    //     }
    //
    //
    //   });
    //
    // }

    assembleNoNullModels.sort((a, b) => (a.speed ?? 0).compareTo(b.speed ?? 0));
    if (assembleNoNullModels.isNotEmpty) {
      updateBaseUrlAndSave(assembleNoNullModels.first);
      for(var i = 0; i < selRoutes.length; i++) {
        var sm = assembleNoNullModels.first.toJson();
        String ss = sm['url'];

        if(selRoutes[i]==ss){
          selIndex = i;
          // print('dfdfdfdf');
          // print(ss+'$i');
          SpUtil().setInt(currentDomainIndex, selIndex);
          EventBusNew.eventBus.fire(RouteChangedEvent(
              arr: selRates,index: selIndex));


          // setState(() {
            curR.value = '${selArr[selIndex]}';
            curRate.value = int.parse(selRates[selIndex]);
            if(curRate.value==1000000){
              curRIn.value = '(测速中)';
            }else{
              curRIn.value = '(${selRates[selIndex]} ms)';
            }
          // });
          update();
        }
      }
    }
    logInfo(assembleNoNullModels.first.toJson());
    logInfo(assembleNoNullModels.last.toJson());
  }

  void updateBaseUrlAndSave(NetworkTestModel model) {
    if (configEnv.appBaseUrl != model.url &&
        model.url?.contains(configEnv.appBaseUrl) == false) {
      configEnv.appBaseUrl = model.url ?? configEnv.appBaseUrl;
      SpUtil().setString(currentDomainKey, configEnv.appBaseUrl);
        HttpV1().init(baseUrl: configEnv.appBaseUrl);

    }
  }


  void onInit() {
    // TODO: implement onInit
    super.onInit();
   String oriStr =
    (SpUtil().getString(saveTFNameKey).toString().isEmpty||
        SpUtil().getString(saveTFNameKey).toString()=='null')?
    "":
    SpUtil().getString(saveTFNameKey).toString();

    controller = TextEditingController(text: oriStr);
    cTxt.value = controller.text;
    controller.addListener(() {cTxt.value = controller.text;
    update();});
    FocusScope.of(Get.context!).requestFocus(FocusNode());
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

    selIndex = SpUtil().getInt(currentDomainIndex) ?? 0 ;
    curR = selArr[selIndex].obs;
    curRIn = '(测速中)'.obs;
    Future.delayed(Duration(seconds: 2), () {

      startTest();

    });
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
