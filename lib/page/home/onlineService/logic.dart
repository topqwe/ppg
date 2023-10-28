import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:webviewx/webviewx.dart';
import '../../../lang/LanguageManager.dart';
import '../../../services/responseHandle/request.dart';
import '../../../store/AppCacheManager.dart';

class OnlineServiceLogic extends GetxController {
   late ScrollController scrollController;
   late WebViewXController webViewController;
   var urlStr = Get.arguments;

   @override
   void onInit() {
     scrollController= ScrollController();
     postRequest();

     super.onInit();
   }

   void postRequest() => request(() async {

     String? token = AppCacheManager.instance.getUserToken();

     String? lang = 'en';
     // if('${Get.locale}'.contains('en_')){
     //   lang = 'en';
     // }else{
     //   lang = 'zh-CN';
     // }
     lang = LanguageManager.instance.currentLanguageRequestParam;
     if(urlStr != null) {
       urlStr = urlStr
           // RequestConfig.noWapBaseUrl + RequestConfig.onlineHome
               +
               '?token=${token}&&lang=${lang}';
     }
     update();

   });




   @override
   void onClose() {
     scrollController.dispose();
     super.onClose();
   }
}
