import 'dart:async';

import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:ftoast/ftoast.dart';
import 'package:get/get.dart';

import '../../../services/api/api_basic.dart';
import '../../../services/responseHandle/request.dart';
import '../../../store/AppCacheManager.dart';
import '../../../store/EventBus.dart';
import '../../../util/PagingMixin.dart';

class CatStateListLogic extends GetxController with GetSingleTickerProviderStateMixin,PagingMixin{
   late EasyRefreshController easyRefreshController;

   String type ='0';
   CatStateListLogic(this.type);

   var listDataFirst = [].obs;
   @override
   List get data => listDataFirst;

   @override
   void onInit() {
     super.onInit();
     easyRefreshController = EasyRefreshController();
     listDataFirst.value.addAll(ApiBasic().initCus());
     update();
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
   },showLoading: true);

   @override
   void onClose() {
     easyRefreshController.dispose();
     super.onClose();
   }

   void postUnlock(context,listModel) => request(()async {
     var params = {
       'orderId': listModel['orderId'],
     };
     var data = await ApiBasic().home({});
     FToast.toast(context, msg: '成功！'.tr);
     // eventBus.fire(GrabRefreshTaskEvent(listModel));
     requestData();
   });

}
