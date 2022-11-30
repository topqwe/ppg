
import 'package:flutter/material.dart';
import 'package:ftoast/ftoast.dart';
import 'package:get/get.dart';
import '../../../../util/CellArrowWidget.dart';
import '../../../../util/InputTextPage.dart';
import '../../../widgets/helpTools.dart';
import '../../store/AppCacheManager.dart';
import '../../util/BaseDialog.dart';
import '../../util/DefaultAppBar.dart';
import '../../util/UpdateVersion.dart';
import '../../widgets/button_widget.dart';
import 'logic.dart';

class SettingPage extends StatelessWidget {
  final logic = Get.put(SettingLogic());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: DefaultAppBar(
          titleStr: '设置'.tr,
        ),
        body: SafeArea(
            child: SingleChildScrollView(
                child: Container(
                    margin: const EdgeInsets.only(top: 1, bottom: 15),
                    child: Column(children: [
                      Obx(() =>
                      CellArrowWidget(title: '电话'.tr,
                        content: logic.phoneNum.value,onTap: (){

                          openPage(
                              InputTextPage(okcb: (value){
                                print(value);
                                logic.phoneNum.value = value;
                                logic.update();
                              }, canclecb: (){}, title: '电话'.tr,hintText: '请填写',
                                  content: logic.phoneNum.value,keyboardType:TextInputType.phone),
                              context);

                        // pushInputTextPage(Get.context!, (value) {
                        //   print(value);
                        //   logic.phoneNum.value = value;
                        //   logic.update();
                        //
                        //
                        // }, () { }, '电话'.tr);


                        },),

                      ),
                      Obx(() =>
                          CellArrowWidget(title: '介绍'.tr,
                            content: logic.introduce.value,onTap: (){

                              pushInputTextPage(Get.context!, (value) {
                                logic.introduce.value = value;
                                logic.update();

                              }, () { }, '介绍'.tr);


                            },),

                      ),

                      CellArrowWidget(title: '登录密码'.tr,
                        content: '',onTap: (){
                          Get.toNamed("/loginPWModify");
                        },),
                      CellArrowWidget(title: '密码'.tr,
                        content: '',onTap: (){
                          logic.checkFPW();
                        },),




                      Container(
                        width: double.infinity,
                        height: 10,
                        color: Color(0xffF3F5F9),
                      ),
                      Obx(() =>  CellArrowWidget(title: '身份验证'.tr,
                        content: logic.boolId.value == 1
                            ? '已认证'.tr
                            : '未认证'.tr,onTap: (){
                          Get.toNamed('/idVerify');
                        },)
                      ),
                      CellArrowWidget(title: '收货地址'.tr,
                        content: '',onTap: (){
                          Get.toNamed('/setAddrList', arguments: '0');
                        },),
                      Obx(() =>  CellArrowWidget(title: '账户'.tr,
                        content: logic.boolBank.value == 1
                            ? '已绑定'.tr
                            : '未绑定'.tr,onTap: (){
                          Get.toNamed('/bankList', arguments: '0');
                        },)
                      ),

                      ///space
                      Container(
                        width: double.infinity,
                        height: 10,
                        color: Color(0xffF3F5F9),
                      ),

                      Obx(() =>  CellArrowWidget(title: '清除缓存'.tr,
                        content: logic.cacheSize.value,onTap: (){
                          logic.handleClearCache();
                      },)
                      ),
                      Obx(() =>  CellArrowWidget(title: '检测更新'.tr,
                        content: logic.version.value,onTap: (){
                          !UpdateVersion().haveNewVersion(
                              AppCacheManager.instance.getVersionNo(),
                              logic.version.value)
                              ? FToast.toast(context,
                              msg: '当前已是最新版本，无需更新~'.tr)
                              : UpdateVersion()
                              .checkVersion(context, false);

                          // Get.dialog(UpdateView('http://baidu.com', '1.0.2',
                          //     "1.\n2.",
                          //     'V2.0.0',true,false),barrierDismissible:false);

                          // showDialog(
                          //     context: Get.context! ,
                          //     barrierDismissible: false,
                          //     builder: (BuildContext context) {
                          //       return UpdateView('http://baidu.com', '1.0.2',
                          //           "1.\n2.",
                          //           'V2.0.0',true,false);
                          //     });
                        },)
                      ),

                      Container(
                        width: double.infinity,
                        height: 8,
                        color: Colors.transparent,
                      ),
                      customFootFuncBtn(backgroundColor: Colors.red, '退出'.tr,
                          ()  {
                            showExitDialog();
                      }),
                    ])))));
  }

  showExitDialog() {
    showDialog<void>(
        context: Get.context!,
        builder: (_) {
          return BaseDialog(
            title: '提示',
            child: const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: Text('您确定要退出登录吗？', style: TextStyle(fontWeight: FontWeight.normal,fontSize: 16,
                  color: Colors.black)),
            ),
            onPressed: () async {
              logic.logout();
            },
          );
        }
    );
  }

}


