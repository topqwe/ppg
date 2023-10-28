

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:get/get.dart';

import '../../../services/api/api_basic.dart';
import '../../../services/responseHandle/request.dart';
import '../../../util/PagingMixin.dart';

class TopupRecordLogic extends GetxController with GetSingleTickerProviderStateMixin,PagingMixin{

  late EasyRefreshController easyRefreshController;

  var listDataFirst = [].obs;
  @override
  List get data => listDataFirst;

  @override
  void onInit() {
    easyRefreshController = EasyRefreshController();
    listDataFirst.addAll(ApiBasic().initCus());
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
    var data = await ApiBasic().dummy({});

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
