import 'package:flutter/cupertino.dart';
import 'package:ftoast/ftoast.dart';
import 'package:get/get.dart';
import '../../../services/api/api_basic.dart';
import '../../../services/responseHandle/request.dart';
import '../../../store/AppCacheManager.dart';
import '../../../store/EventBus.dart';

class SetFPWLogic extends GetxController {
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
    controller.addListener(() {
      cTxt.value = controller.text;
      update();
    });
    controller2 = TextEditingController();
    controller2.addListener(() {
      cTxt2.value = controller2.text;
      update();
    });
    controller3 = TextEditingController();
    controller3.addListener(() {
      cTxt3.value = controller3.text;
      update();
    });
  }

  void textFieldChanged(src) {
    print(src);
  }

  postSetFPW(context) => request(() async {
        var data = {
          'safeword': controller.text,
          're_safeword': controller2.text
        };
        var user = await ApiBasic().home({});
        FToast.toast(context, msg: '设置成功'.tr);
        AppCacheManager.instance.setValueForKey('FSW', '1');
        Get.back();
        return;
      });
}
