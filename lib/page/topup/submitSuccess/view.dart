import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../util/CustomBackButton.dart';
import '../../../util/DefaultAppBar.dart';
import '../../../style/theme.dart';
import '../../../widgets/button_widget.dart';
import '../../../widgets/sizebox_widget.dart';
import '../../bottom/logic.dart';
import 'logic.dart';

class SubmitSuccessPage extends StatelessWidget {
  final logic = Get.put(SubmitSuccessLogic());

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
          Get.offNamed('/${Get.parameters['path']}');
          return true;
        },
        child: Scaffold(
          // resizeToAvoidBottomInset: false, //解决键盘导致溢出页面
            backgroundColor: const Color(0xffffffff),
            appBar:
            DefaultAppBar(titleStr: '提交'.tr,leading: CustomBackButton(onPressed: (){
              Get.offNamed('/${Get.parameters['path']}');
            },),),
            body: SafeArea(
                child: SingleChildScrollView(
                            child:
                            Column(children: [
                              divideLine(),
                              SizedBox(height: 5,),

                              Container(
                                  margin: const EdgeInsets.only(
                                      top: 15, left: 15, right: 15),
                                  child: Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.center,
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: <Widget>[

                                        buttonImage(w: 50, h: 50,
                                            imageName: 'assets/images/successIcon.png',
                                            text: '', onPressed: (){

                                            }),
                                        SizedBox(height: 15,),

                                        Container(
                                          alignment: Alignment.center,
                                          child: RichText(
                                            textAlign: TextAlign.center,
                                            text: TextSpan(
                                              text: '提交成功'.tr,
                                              style: TextStyle(
                                                //  color: ColorPlate.btnColor,
                                                //   decoration: TextDecoration.underline
                                                  fontSize: 16,
                                                  color:Colors.black),
                                              children: <TextSpan>[
                                                TextSpan(
                                                  text: '\n'+'提交成功，如有疑问联系客服'.tr,
                                                  style: TextStyle(height: 2,
                                                      fontSize: 14,
                                                      color: AppTheme.themeGreyColor),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),



                                      ]
                                  )
                              ),

                              Column(children: [
                                SizedBox(height: 15,),
                                customFootFuncBtn('返回首页'.tr, (){
                                  Get.offNamed('/index');
                                  final logic = Get.put(BottomLogic());
                                  logic.changePage(0);
                                }),
                                SizedBox(height: 15,),
                                customFootFuncBtn('查看记录'.tr, (){
                                  Get.offNamed('/${Get.parameters['path2']}');
                                  // Get.offNamed('/submitted_successfully');
                                  // final logic = Get.put(BottomLogic());
                                  // logic.changePage(3);
                                },borderColor: AppTheme.themeHightColor,
                                    textColor: AppTheme.themeHightColor,
                                    backgroundColor: Colors.white),
                              ] ),

                            ],)
                        )
                    )
            )
    );
  }
}
