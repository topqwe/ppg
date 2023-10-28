import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:ftoast/ftoast.dart';
import 'package:get/get.dart';

import '../../../services/api/api_basic.dart';
import '../../../services/responseHandle/request.dart';
import '../../../store/EventBus.dart';
import '../../../util/PagingMixin.dart';

class BankListLogic extends GetxController with GetSingleTickerProviderStateMixin,PagingMixin{

   late EasyRefreshController easyRefreshController;

   var listDataFirst = [].obs;
   @override
   List get data => listDataFirst;

   @override
   void onInit() {
     easyRefreshController = EasyRefreshController();

     requestData();
     mainEventBus.on(EventBusConstants.grabRefreshBkListEvent,
             (arg) {
           requestData();
         });
     super.onInit();
   }

   void requestData() {
     requestListData(true);
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
       // 'page_no': '$page',
       // 'pageSize':'$pageSize'
     };

     var data = await ApiBasic().home({});

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

   void selectRequest(context,listModel) => request(() async {

     Get.back(result: listModel);
     return;
     var params = {
       'contacts': listModel['contacts'],
       'address': listModel['address'],
       'phone': listModel['phone'],
       // 'use':status0.value
     };
     // var data = await requestClient.post(APIS.addAddress, data: params);
     // FToast.toast(context, msg: "添加成功");
     // Get.back();
     params['orderId']= Get.arguments;
     // var data2 = await requestClient.post(APIS.home, data: params);

     // FToast.toast(context, msg: "添加成功");
     // Get.offNamed('/taskDetail',arguments: orderId);
     Get.back();
   });

   void delRequest(context,listModel) => request(() async {
     var params = {
       'id': listModel['id'],
     };
     var data = await ApiBasic().home({});

     FToast.toast(context, msg: "删除成功".tr);
     requestData();
     // Get.toNamed('/taskDetail',arguments: Get.arguments);
     // update();
   });

}
