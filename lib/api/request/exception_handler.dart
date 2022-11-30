import '../../../api/request/config.dart';
import '../../../api/request/exception.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import '../../../util/LoadingBarrierView.dart';

import '../../page/bottom/logic.dart';

bool handleException(ApiException exception,
    {bool Function(ApiException)? onError}) {
  if (onError?.call(exception) == true) {
    return true;
  }

  if (exception.code == 0) {
    ///todo to login
    return false;
  }

  if (exception.code == 800 || exception.code == 801) {
    Get.toNamed('/idVerify');

    return false;
  }


  // if(exception.code == 999 ){
  //   ///todo to home
  //   // Get.offNamed('/index');
  //   // final logic = Get.put(BottomLogic());
  //   // logic.changePage(0);
  //   return false;
  // }
  print(exception.msg);
  // EasyLoading.showError(exception.msg ?? ApiException.unknownException);
  EasyLoading.showError(exception.msg.toString().tr);

  if (exception.code == 1) {
    //first msg

    LoadingBarrierView.hideLoading(Get.context!);

    ///todo to login
    return false;
  }

  return false;
}
