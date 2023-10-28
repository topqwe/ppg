import 'package:flutter/cupertino.dart';
import 'package:ftoast/ftoast.dart';
import 'package:get/get.dart';
import '../../../services/api/api_basic.dart';
import '../../../services/responseHandle/request.dart';
class LoginPWModifyLogic extends GetxController {
  late TextEditingController controller;
  late TextEditingController controller2;
  late TextEditingController controller3;
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
  void resetLPW (context)=>request(() async{
    var data = {
      'old_password':controller.text,
      'password':controller2.text,
      'confirm_password':controller3.text
    };

    var user = await ApiBasic().home({});
    FToast.toast(context, msg: '修改成功'.tr);
    Get.back();
    return;
  });
}
