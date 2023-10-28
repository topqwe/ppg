import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../util/PagingMixin.dart';
import '../../services/api/api_basic.dart';
import '../../services/responseHandle/request.dart';
import 'SellView.dart';

class SellLogic extends GetxController with GetSingleTickerProviderStateMixin,PagingMixin{
  late ScrollController scrollController;
  late EasyRefreshController easyRefreshController;
  String userWallet = '0';
  var listDataFirst = [].obs;
  var timer_fun2;
  @override
  List get data => listDataFirst;


  @override
  void onInit() {

    scrollController= ScrollController(initialScrollOffset: 0);
    easyRefreshController = EasyRefreshController();
    requestData();
    getUserWallet();
    super.onInit();
  }

  void getUserWallet() => request(() async {
    var data = await ApiBasic().home({});
    userWallet = double.parse(data['money'].toString()).toString();
  });

  void handleAlert(context,listModel)  {
      Get.dialog(SellView(
          userWallet, listModel),barrierDismissible:true);
  }

  @override
  void onClose() {
    scrollController.dispose();
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
      'status':3.toString(),
      'pageNum': '$page',
      'pageSize': '$pageSize',
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
}
