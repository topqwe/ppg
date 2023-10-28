import 'dart:async';

import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:get/get.dart';

import '../../../services/api/api_basic.dart';
import '../../../services/responseHandle/request.dart';
import '../../../store/AppCacheManager.dart';
import '../../../store/EventBus.dart';
import '../../../util/PagingMixin.dart';

class MallStateListLogic extends GetxController with GetSingleTickerProviderStateMixin,PagingMixin{
   late EasyRefreshController easyRefreshController;

   int type =0;
   MallStateListLogic(this.type);

   var banners = [].obs;
   var texts = [].obs;

   var tagsModel = [].obs;
   var tags = [].obs;
   var tagsCurrentIndex = 0;

   var sectags = [].obs;
   var sectagsCurrentIndex = 0;

   var listDataFirst = [].obs;
   @override
   List get data => listDataFirst;

   @override
   void onInit() {
     super.onInit();
     tags.value  = [//字符串different，or dont work
       '0',
       'SDK',
       'Android Studio developer',
       'welcome to the jungle',
       '篝火营地',
     ];

     sectags.value  = [//字符串different，or dont work
       '0',
       'SDK',
       'Android Studio developer',
       'welcome to the jungle',
       '篝火营地',
     ];

     texts.value = [
       ' Stay Tuned ',
     ]; //or no scr


     easyRefreshController = EasyRefreshController();
     listDataFirst.addAll(ApiBasic().initCus());
     tagsModel.addAll(ApiBasic().initCus());
     tagsCurrentIndex = int.parse(tagsModel[0]['id']);
     postCheckRequest();
     update();

   }
   pushNextPage(var listModel){
     Get.toNamed('/mallDetail',
         parameters:
         // {'url':''},
         {
           'url':
           """
  <img alt='Flutter' src='https://flutter.cn/assets/flutter-lockup-1caf6476beed76adec3c477586da54de6b552b2f42108ec5bc68dc63bae2df75.png' /><br />
  <img alt='Google' src='https://www.google.com/images/branding/googlelogo/2x/googlelogo_color_92x30dp.png' /><br />
  <img alt='Flutter' src='https://flutter.cn/assets/flutter-lockup-1caf6476beed76adec3c477586da54de6b552b2f42108ec5bc68dc63bae2df75.png' /><br />
  <img alt='Google' src='https://www.google.com/images/branding/googlelogo/2x/googlelogo_color_92x30dp.png' /><br />
  <img alt='Flutter' src='https://flutter.cn/assets/flutter-lockup-1caf6476beed76adec3c477586da54de6b552b2f42108ec5bc68dc63bae2df75.png' /><br />
  <img alt='Google' src='https://www.google.com/images/branding/googlelogo/2x/googlelogo_color_92x30dp.png' /><br />
  <img alt='Flutter' src='https://flutter.cn/assets/flutter-lockup-1caf6476beed76adec3c477586da54de6b552b2f42108ec5bc68dc63bae2df75.png' /><br />
  <img alt='Google' src='https://www.google.com/images/branding/googlelogo/2x/googlelogo_color_92x30dp.png' /><br />
  <img alt='Flutter' src='https://flutter.cn/assets/flutter-lockup-1caf6476beed76adec3c477586da54de6b552b2f42108ec5bc68dc63bae2df75.png' /><br />
  <img alt='Google' src='https://www.google.com/images/branding/googlelogo/2x/googlelogo_color_92x30dp.png' /><br />
  <img alt='Flutter' src='https://flutter.cn/assets/flutter-lockup-1caf6476beed76adec3c477586da54de6b552b2f42108ec5bc68dc63bae2df75.png' /><br />
  <img alt='Google' src='https://www.google.com/images/branding/googlelogo/2x/googlelogo_color_92x30dp.png' /><br />
  <img alt='Flutter' src='https://flutter.cn/assets/flutter-lockup-1caf6476beed76adec3c477586da54de6b552b2f42108ec5bc68dc63bae2df75.png' /><br />
  <img alt='Google' src='https://www.google.com/images/branding/googlelogo/2x/googlelogo_color_92x30dp.png' /><br />
  <img alt='Flutter' src='https://flutter.cn/assets/flutter-lockup-1caf6476beed76adec3c477586da54de6b552b2f42108ec5bc68dc63bae2df75.png' /><br />
  <img alt='Google' src='https://www.google.com/images/branding/googlelogo/2x/googlelogo_color_92x30dp.png' /><br />
  <img alt='Flutter' src='https://flutter.cn/assets/flutter-lockup-1caf6476beed76adec3c477586da54de6b552b2f42108ec5bc68dc63bae2df75.png' /><br />
  <img alt='Google' src='https://www.google.com/images/branding/googlelogo/2x/googlelogo_color_92x30dp.png' /><br />
  <img alt='Flutter' src='https://flutter.cn/assets/flutter-lockup-1caf6476beed76adec3c477586da54de6b552b2f42108ec5bc68dc63bae2df75.png' /><br />
  <img alt='Google' src='https://www.google.com/images/branding/googlelogo/2x/googlelogo_color_92x30dp.png' /><br />
  <img alt='Flutter' src='https://flutter.cn/assets/flutter-lockup-1caf6476beed76adec3c477586da54de6b552b2f42108ec5bc68dc63bae2df75.png' /><br />
  <img alt='Google' src='https://www.google.com/images/branding/googlelogo/2x/googlelogo_color_92x30dp.png' /><br />
  <img alt='Flutter' src='https://flutter.cn/assets/flutter-lockup-1caf6476beed76adec3c477586da54de6b552b2f42108ec5bc68dc63bae2df75.png' /><br />
  <img alt='Google' src='https://www.google.com/images/branding/googlelogo/2x/googlelogo_color_92x30dp.png' /><br />
  <img alt='Flutter' src='https://flutter.cn/assets/flutter-lockup-1caf6476beed76adec3c477586da54de6b552b2f42108ec5bc68dc63bae2df75.png' /><br />
  <img alt='Google' src='https://www.google.com/images/branding/googlelogo/2x/googlelogo_color_92x30dp.png' /><br />
  <img alt='Flutter' src='https://flutter.cn/assets/flutter-lockup-1caf6476beed76adec3c477586da54de6b552b2f42108ec5bc68dc63bae2df75.png' /><br />
  <img alt='Google' src='https://www.google.com/images/branding/googlelogo/2x/googlelogo_color_92x30dp.png' /><br />
  <img alt='Flutter' src='https://flutter.cn/assets/flutter-lockup-1caf6476beed76adec3c477586da54de6b552b2f42108ec5bc68dc63bae2df75.png' /><br />
  <img alt='Google' src='https://www.google.com/images/branding/googlelogo/2x/googlelogo_color_92x30dp.png' /><br />
  <img alt='Flutter' src='https://flutter.cn/assets/flutter-lockup-1caf6476beed76adec3c477586da54de6b552b2f42108ec5bc68dc63bae2df75.png' /><br />
  <img alt='Google' src='https://www.google.com/images/branding/googlelogo/2x/googlelogo_color_92x30dp.png' /><br />
  <img alt='Flutter' src='https://flutter.cn/assets/flutter-lockup-1caf6476beed76adec3c477586da54de6b552b2f42108ec5bc68dc63bae2df75.png' /><br />
  <img alt='Google' src='https://www.google.com/images/branding/googlelogo/2x/googlelogo_color_92x30dp.png' /><br />
  <img alt='Flutter' src='https://flutter.cn/assets/flutter-lockup-1caf6476beed76adec3c477586da54de6b552b2f42108ec5bc68dc63bae2df75.png' /><br />
  <img alt='Google' src='https://www.google.com/images/branding/googlelogo/2x/googlelogo_color_92x30dp.png' /><br />
  <img alt='Flutter' src='https://flutter.cn/assets/flutter-lockup-1caf6476beed76adec3c477586da54de6b552b2f42108ec5bc68dc63bae2df75.png' /><br />
  <img alt='Google' src='https://www.google.com/images/branding/googlelogo/2x/googlelogo_color_92x30dp.png' /><br />
  <img alt='Flutter' src='https://flutter.cn/assets/flutter-lockup-1caf6476beed76adec3c477586da54de6b552b2f42108ec5bc68dc63bae2df75.png' /><br />
  <img alt='Google' src='https://www.google.com/images/branding/googlelogo/2x/googlelogo_color_92x30dp.png' /><br />
  
  """,
           'id':listModel['id']
         },  );
   }

   Future<void> postCheckRequest() async {
       requestData();
   }

   void requestData() {
     // requestListData(true);
     dataRefresh();
   }

   @override
   Future dataRefresh() {
     page = 1;
     return requestListData(true);
   }

   @override
   Future loadMore() {
     page ++;
     return requestListData(false);
   }

   Future requestListData(bool isRefresh) => request(()async {
     var params = {
       'pageNum': page,
       'pageSize': pageSize,
       'status': type.toString(),
     };
     var data = await ApiBasic().dummy({});

     List lst = data['pageList'] ?? [];
     if(isRefresh){
       listDataFirst.value = lst;
     }else{
       listDataFirst.addAll(lst) ;
     }
     update();
   });

   @override
   void onClose() {
     easyRefreshController.dispose();
     super.onClose();
   }

}
