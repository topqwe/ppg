
import 'package:flutter/cupertino.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:get/get.dart';
import 'package:liandan_flutter/services/api/api_basic.dart';

import '../../../services/responseHandle/request.dart';
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
    for (int i = 0; i < 11; i++) {
      var vv = {'name': '$i'+'dfhdf',
        'iconBig': '$i','prize':i+900.9,'progress':0.82};
      listDataFirst.add(vv);
    }
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
    var data = await ApiBasic().home({});

    List lst = data ?? [];
    if(isRefresh){
      listDataFirst.value = lst;
    }else{
      listDataFirst.addAll(lst) ;
    }
    update();
  });


}
