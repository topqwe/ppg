
import 'package:flutter/cupertino.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:get/get.dart';

import '../../../api/request/apis.dart';
import '../../../api/request/request.dart';
import '../../../api/request/request_client.dart';
import '../../../util/PagingMixin.dart';

class StatRecordLogic extends GetxController with GetSingleTickerProviderStateMixin,PagingMixin{
  late ScrollController scrollController;
  late EasyRefreshController easyRefreshController;
  var headDatas = {}.obs;
  var listDataFirst = [].obs;
  @override
  List get data => listDataFirst;

  var initData = '全部'.obs;
  var choseType = ''.obs;
  var showTypes = [
    '全部'.tr, 'A'.tr, 'B'.tr].obs;
  var choseTypes = ['','A','B'].obs;

  @override
  void onInit() {
    headDatas.value = {
      'A':'0.0',
      'B':'0.0',
    }.obs;
    scrollController= ScrollController(initialScrollOffset: 0);
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
      'page_no': '$page',
      'content_type':'${choseType.value}',
    };
    var data = await requestClient.post(APIS.recordLists,
        data:params);

    List lst = data ?? [];
    if(isRefresh){
      listDataFirst.value = lst;
    }else{
      listDataFirst.addAll(lst) ;
    }
    update();
  });


}
