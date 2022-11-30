import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:get/get.dart';

import '../../../api/request/apis.dart';
import '../../../api/request/request.dart';
import '../../../api/request/request_client.dart';
import '../../../util/PagingMixin.dart';

class TopupRecordLogic extends GetxController with GetSingleTickerProviderStateMixin,PagingMixin{

  late EasyRefreshController easyRefreshController;

  var listDataFirst = [].obs;
  @override
  List get data => listDataFirst;

  @override
  void onInit() {
    easyRefreshController = EasyRefreshController();
    requestData();
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
      'page_no': '$page',
    };
    var data = await requestClient.post(APIS.home,
        data:params);

    List lst = data ?? [];
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
