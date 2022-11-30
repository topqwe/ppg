import 'package:flutter/cupertino.dart';
import 'package:ftoast/ftoast.dart';
import 'package:get/get.dart';
import '../../../api/request/apis.dart';
import '../../../api/request/request.dart';
import '../../../api/request/request_client.dart';
class ResetFPWLogic extends GetxController {
  var controller;
  var controller2;
  var controller3;
  var cTxt = ''.obs;
  var cTxt2 = ''.obs;
  var cTxt3 = ''.obs;
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
  void textFieldChanged (src){
    print(src);
  }
  void shezhimima_post (context)=>request(() async{
    var url = APIS.home;
    var data = {
      'old_safeword':controller.text,
      'safeword':controller2.text,
      're_safeword':controller3.text
    };
    var user = await requestClient.post(url,data: data);
    print(user);
    FToast.toast(context, msg: '修改成功'.tr);
    Get.back();
    return;
  });
}
