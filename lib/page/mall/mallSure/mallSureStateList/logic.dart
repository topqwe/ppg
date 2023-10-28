import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:ftoast/ftoast.dart';
import 'package:get/get.dart';
import '../../../../services/api/api_basic.dart';
import '../../../../services/responseHandle/request.dart';
import '../../../../util/BaseDialog.dart';
import '/widgets/helpTools.dart';
import '../../../../store/EventBus.dart';
import '../../../../util/PagingMixin.dart';

class MallSureStateListLogic extends GetxController
    with GetSingleTickerProviderStateMixin, PagingMixin {
  late EasyRefreshController easyRefreshController;

  int type = 0;
  MallSureStateListLogic(this.type);

  var result = {}.obs;
  var listModel = {}.obs;

  var listDataFirst = [].obs;
  @override
  List get data => listDataFirst;

  var cTxt = 0.0.obs;
  var depositFee = 0.0.obs;
  late TextEditingController controller;

  @override
  void onInit() {
    super.onInit();
    controller = TextEditingController();
    controller.addListener(() {
      // cTxt.value = controller.text;
      cTxt.value = double.parse(controller.text);
      update();
    });

    easyRefreshController = EasyRefreshController();
    listDataFirst.addAll(ApiBasic().initCus());
    listModel.value = listDataFirst.first;
    requestData();
    mainEventBus.on(EventBusConstants.bindAddrRefreshDetailEvent,
            (arg) {
          requestData();
        });

  }

  void textFieldChanged(String str) {
    print(str);
    // print(controller);
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
    page++;
    return requestListData(false);
  }

  // Future requestListData(bool isRefresh) => request(()async {
  //   var params = {
  //     'pageNum': page,
  //     'pageSize': pageSize,
  //     'status': type.toString(),
  //   };
  //   var data = await requestClient.post(APIS.orderList,
  //       data:params);
  //
  //   List lst = data['pageList'] ?? [];
  //   if(isRefresh){
  //     listDataFirst.value = lst;
  //   }else{
  //     listDataFirst.addAll(lst) ;
  //   }
  //   update();
  // });

  Future requestListData(bool isRefresh) => request(() async {
        var params = {
          'id': listModel['id'],
        };
        var data = await ApiBasic().dummy({});

        // List lst = data['pageList'] ?? [];
        if (data != null) {
          // htmlUrl = '<style>img {width: 100%}</style><p><img src="https://img10.360buyimg.com/cms/jfs/t1/182872/6/133/795112/607f3495Ea178190e/01c683a879c788c5.jpg"></p>';
          // if(htmlUrl.isNotEmpty)html =  Html(data: htmlUrl);
          listModel.value = data;
          if (isRefresh) {
            listDataFirst.value = [data];
          } else {
            listDataFirst.addAll([data]);
          }
        }
        if (listModel.isNotEmpty) update();
      }, showLoading: true);

  @override
  void onClose() {
    easyRefreshController.dispose();
    super.onClose();
  }

  showExitDialog() {
    showDialog<void>(
        context: Get.context!,
        builder: (_) {
          return BaseDialog(
            title: '提示',
            child: const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: Text('您确定要吗？', style: TextStyle(fontWeight: FontWeight.normal,fontSize: 16,
                  color: Colors.black)),
            ),
            onPressed: () async {
              sureRequest();
            },
          );
        }
    );
  }

  void postUnlock() => request(()async {

    if(controller.text==''){
      FToast.toast(Get.context!, msg: '请输入'.tr);
      return;
    }
    showExitDialog();

    // showAlertDialog(Get.context!, () { sureRequest();},
    //         () { }, '提示'.tr, '确认吗？'.tr);


    // showCupertinoDialog(
    //   barrierDismissible: false,
    //   context: Get.context!,
    //   builder: (BuildContext context) {
    //     return AlertDialog(
    //       title: Text('提示'.tr),
    //       content:  Text('确认吗？'.tr),
    //       actions: <Widget>[
    //         TextButton(
    //           onPressed: () => Navigator.of(Get.context!).pop(false),
    //           child:  Text('取消'.tr),
    //         ),
    //         TextButton(
    //           onPressed: () async {
    //             Navigator.of(Get.context!).pop(true);
    //             sureRequest();
    //
    //           },
    //           child:  Text('确认'.tr),
    //         ),
    //       ],
    //     );
    //   },
    // );


  });

  void sureRequest() => request(() async {
        var params = {
          'id': listModel['id'],
        };
        Get.offNamed('/succ?path=1');//Get.offNamed('/succ?path=0');
        // Get.offUntil(GetPageRoute(page: ()=>SuccPage(),parameter: {'path':'1'}), (route) => (route as GetPageRoute).routeName == '/index');
        return;
      });
}
