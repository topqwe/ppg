import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../util/CustomBackButton.dart';

import '../../../util/DefaultAppBar.dart';
import '../../style/theme.dart';
import '../../../widgets/button_widget.dart';
import '../../../widgets/sizebox_widget.dart';
import '../bottom/logic.dart';
import 'logic.dart';

class SuccPage extends StatelessWidget {
  final logic = Get.put(SuccLogic());

  @override
  Widget build(BuildContext context) {
    var path = Get.parameters['path'].toString();

    return WillPopScope(
        onWillPop: () async {
          // Get.offNamed('/${Get.parameters['path']}');
          Get.offNamed('/index');
          final logic = Get.put(BottomLogic());
          logic.changePage(0);
          return true;
        },
        child: Scaffold(
            // resizeToAvoidBottomInset: false, //解决键盘导致溢出页面
            backgroundColor: const Color(0xffffffff),
            appBar: DefaultAppBar(
              titleStr: '成功'.tr,
              leading: CustomBackButton(
                onPressed: () {
                  Get.offNamed('/index');
                  final logic = Get.put(BottomLogic());
                  // logic.changePage(path == '0'?1:3);
                  logic.changePage(0);
                },
              ),
            ),
            body: SafeArea(
                child: SingleChildScrollView(
                    child: Column(
              children: [
                divideLine(),
                SizedBox(
                  height: 5,
                ),
                Container(
                    margin: const EdgeInsets.only(top: 15, left: 15, right: 15),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          buttonImage(
                              w: 50,
                              h: 50,
                              imageName: 'assets/images/successIcon.png',
                              text: '',
                              onPressed: () {}),
                          SizedBox(
                            height: 15,
                          ),
                          Container(
                            alignment: Alignment.center,
                            child: RichText(
                              textAlign: TextAlign.center,
                              text: TextSpan(
                                text: '操作成功'.tr,
                                style: TextStyle(
                                    //  color: ColorPlate.btnColor,
                                    //   decoration: TextDecoration.underline
                                    fontSize: 16,
                                    color: Colors.black),
                                children: <TextSpan>[
                                  TextSpan(
                                    text: '\n' + '请注意查收信息，如有疑问联系客服'.tr,
                                    style: TextStyle(
                                        height: 2,
                                        fontSize: 14,
                                        color: AppTheme.themeGreyColor),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ])),
                Column(children: [
                  // SizedBox(height: 15,),
                  customFootFuncBtn('返回首页'.tr, () {
                    Get.offNamed('/index');
                    // Get.offAndToNamed('/index');
                    // Get.offUntil(GetPageRoute(page: ()=>BottomPage()), (route) => (route as GetPageRoute).routeName == null);
                    final logic = Get.put(BottomLogic());
                    logic.changePage(0);
                  }),

                  Visibility(
                    child: Column(
                      children: [
                        // SizedBox(height: 15,),
                        customFootFuncBtn(margintb: 0, '查看记录'.tr, () {
                          path == '0'
                              ? Get.toNamed('/catRecord')
                              : path == '1'
                                  ? Get.toNamed('/mallRecord')
                                  : Get.toNamed('/sellRecord');
                          // Get.offNamed('/index');
                          // final logic = Get.put(BottomLogic());
                          // logic.changePage(4);
                        },
                            borderColor: AppTheme.themeHightColor,
                            textColor: AppTheme.themeHightColor,
                            backgroundColor: Colors.white),
                      ],
                    ),
                    visible: path != '3',
                  ),
                ]),
              ],
            )))));
  }
}
