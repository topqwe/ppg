
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:ftoast/ftoast.dart';
import 'package:get/get.dart';
import '../../../../util/MultiSelectTypeDialog.dart';
import '../../../../util/OnlySelectTypeDialog.dart';
import '../../../../util/TFInputDialog.dart';
import '../../../services/api/api_basic.dart';
import '../../../services/responseHandle/request.dart';
import '/util/SMSVerifyDialog.dart';
import '/util/SetPWSheet.dart';
import '/store/AppCacheManager.dart';
import 'package:pay_pwd/pay_pwd.dart';

import '../../../store/EventBus.dart';
import '../../../util/PagingMixin.dart';

class MallDetailLogic extends GetxController with GetSingleTickerProviderStateMixin,PagingMixin{

  late EasyRefreshController easyRefreshController;

  var listDataFirst = [].obs;
  @override
  List get data => listDataFirst;

  var listModel = {}.obs;

  var safeword = ''.obs;

  var boolSafeword = 0.obs;

  var addrList = [].obs;


  late Html html;
  String htmlUrl =
  // '';
  Get.parameters['url'] as String;

  @override
  void onInit() {
    // if(htmlUrl.isNotEmpty)
    html =  Html(data: htmlUrl);
    easyRefreshController = EasyRefreshController();
    listDataFirst.addAll(ApiBasic().initCus());
    listModel.value = listDataFirst.first;

    requestData();
    // eventBus.on<BindAddrRefreshTaskDetailEvent>().listen((event){
    //   requestData();
    // });
    super.onInit();
  }

  @override
  void onClose() {
    easyRefreshController.dispose();
    super.onClose();
  }

  void postZay() => request(()async {
//dummy
//     Get.back();
//     Get.toNamed('/mallSure',parameters:{"id": listModel['id']});

    //request
    var user = await ApiBasic().home({});//success to jump

   Get.toNamed('/mallSure', parameters: {"id": listModel['id']});

    //Get.offNamed('/mallSure',arguments: listModel['id'],parameters: {'url':Get.parameters['url'].toString()});
    // return;

  });

  void postCheckFund()=> request(() async {

    // if(AppCacheManager.instance.getValueForKey(kFSW)=='1'){
      // Get.toNamed("/setFPW");

      showSetPWSheet(Get.context!, (value) {
        print(value);

        showSMSVerifyDialog(Get.context!, (value2) {
          print(value2);

          showTFInputDialog(Get.context!, (value3) {
            print(value3);

            showOnlySelectTypeDialog(Get.context!, (value4) {
              print(value4);

              showMultiSelectTypeDialog(Get.context!, (value5) {
                print(value5.cast<int>());

                showPzyDialog();

                //default[0] List<int> _selectValue = [0];
                //_selectValue = value5.cast<int>();
              }, () { },[0]);


            }, () { });


          }, () { }, '请输入');


        }, () {});


      }, () {});


    // }else{
      // showPzyDialog();
    // }
    return;
  });

  showPzyDialog(){
    // Get.back();
    // Get.toNamed('/mallSure',parameters:{"id": listModel['id']});

    pay(
      context: Get.context!,
      hintText: '密码'.tr,
      onSubmit: (password) async {
        safeword.value = password;

        postZay();//must request
      },
    );
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
      'id': Get.parameters['id'],
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
    update();
  },showLoading: true);

}
