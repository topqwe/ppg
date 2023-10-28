import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:ftoast/ftoast.dart';
import 'package:get/get.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../services/api/api_basic.dart';
import '../../../services/responseHandle/request.dart';
import '../../../store/EventBus.dart';
import '../../../util/PagingMixin.dart';

class TopupDetailLogic extends GetxController with GetSingleTickerProviderStateMixin,PagingMixin{
   GlobalKey repaintKey = GlobalKey();
   late EasyRefreshController easyRefreshController;

   var listDataFirst = [].obs;
   @override
   List get data => listDataFirst;

   var listModel = {}.obs;


   @override
   void onInit() {
     easyRefreshController = EasyRefreshController();
     requestData();
     super.onInit();
   }

   @override
   void onClose() {
     easyRefreshController.dispose();
     super.onClose();
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
       'order_no': Get.arguments,
     };

     var data = await ApiBasic().home({});

     // List lst = data['pageList'] ?? [];
   if (data != null) {
     listModel.value = data;
     if (isRefresh) {
       listDataFirst.value = [data];
     } else {
       listDataFirst.addAll([data]);
     }
   }
     update();
   },showLoading: true);

   getPerm(context) async {
     var status = await Permission.storage.status;
     if (!status.isGranted) {
       status = await Permission.storage.request();
       print(status);
       return;
     }

     RenderRepaintBoundary? boundary = repaintKey.currentContext?.findRenderObject()! as RenderRepaintBoundary;
     ui.Image image = await boundary.toImage();
     ByteData? byteData = await image.toByteData(format: ui.ImageByteFormat.png);
     final result = await ImageGallerySaver.saveImage(byteData!.buffer.asUint8List(),quality:100,name: 'boss_Image'+DateTime.now().toString() );
     if (result['isSuccess'].toString()=='true') {
       FToast.toast(context, msg: "保存成功");
     }else{
       // print('保存失败');
       FToast.toast(context, msg: "保存失败");
     }
   }






}
