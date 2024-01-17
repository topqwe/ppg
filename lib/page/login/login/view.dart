import 'package:container_tab_indicator/container_tab_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ftoast/ftoast.dart';
import 'package:get/get.dart';
import 'package:liandan_flutter/main.dart';
import 'package:liandan_flutter/services/request/http_utils.dart';
import '../../../services/cache/storage.dart';
import '../../../services/newReq/http.dart';
import '../../../style/theme.dart';
import '../../../util/FunTextButton.dart';
import '../../../util/RouteSelectDialog.dart';
import '../../../util/SMSTFDialog.dart';
import '../../../util/TextFieldView.dart';
import '../../../widgets/helpTools.dart';
import 'logic.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';
import '../../../vendor/platform/platform_universial.dart'
if (dart.library.io) '../../../vendor/platform/platform_native.dart'
if (dart.library.html) '../../../vendor/platform/platform_web.dart'
as platformutil;
class LoginPage extends StatelessWidget {
  final logic = Get.put(LoginLogic());

  @override
  Widget build(BuildContext context) {
    return KeyboardDismisser(
        gestures: [
          GestureType.onTap,
          GestureType.onPanUpdateDownDirection,
        ],
        child: WillPopScope(
            onWillPop: () async {
              Get.offNamed("/");
              return true;
            },
            child: Scaffold(
                backgroundColor: Colors.white,

                body: Stack(children: <Widget>[
                  Scrollbar(
                      child: SafeArea(
                          child: SizedBox(
                              width: double.infinity,
                              child: SingleChildScrollView(
                                  child: Container(
                                      margin: const EdgeInsets.only(
                                          top: 54,
                                          left: 15,
                                          right: 15,
                                          bottom: 15),
                                      child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: <Widget>[
                                            Container(
                                              margin: EdgeInsets.only(top: 20),
                                              child: Text(
                                                '登录'.tr,
                                                style: TextStyle(
                                                    fontSize: 30,
                                                    fontWeight:
                                                        FontWeight.w700),
                                              ),
                                            ),
                                            Obx(() => Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  children: [
                                                    Container(
                                                      height: 34,
                                                      margin: EdgeInsets.only(
                                                          top: 30),
                                                      child: TextButton(//FlatButton
                                                        style: TextButton.styleFrom(backgroundColor:logic.tab_show.value==1?AppTheme.themeHightColor:Color(0xffEEEEEE), // foreground
                                                            minimumSize: Size(50, 50),
                                                            padding: EdgeInsets.only(left: 25, right: 25),
                                                            shape: const RoundedRectangleBorder(
                                                              borderRadius: BorderRadius.all(Radius.circular(2)),
                                                            )),
                                                        child: Text(
                                                          '账号'.tr,
                                                          style: logic.tab_show
                                                                      .value ==
                                                                  1
                                                              ? TextStyle(
                                                                  color: Colors
                                                                      .white)
                                                              : TextStyle(
                                                                  color: Colors
                                                                      .black),
                                                        ),
                                                        onPressed: () async {
                                                          logic.controller
                                                              .text = "";
                                                          logic.controller2
                                                              .text = "";
                                                          logic.controller3
                                                              .text = "";
                                                          logic.tab_show.value =
                                                              1;
                                                        },
                                                      ),
                                                    ),
                                                    Container(
                                                      height: 34,
                                                      margin: EdgeInsets.only(
                                                          left: 10, top: 30),
                                                      child: TextButton(//FlatButton
                                                        style: TextButton.styleFrom(backgroundColor:logic.tab_show.value==2?AppTheme.themeHightColor:Color(0xffEEEEEE), // foreground
                                                            minimumSize: Size(50, 50),
                                                            padding: EdgeInsets.only(left: 25, right: 25),
                                                            shape: const RoundedRectangleBorder(
                                                              borderRadius: BorderRadius.all(Radius.circular(2)),
                                                            )),
                                                        child: Text(
                                                          '手机号'.tr,
                                                          style: logic.tab_show
                                                                      .value ==
                                                                  2
                                                              ? TextStyle(
                                                                  color: Colors
                                                                      .white)
                                                              : TextStyle(
                                                                  color: Colors
                                                                      .black),
                                                        ),
                                                        onPressed: () async {
                                                          logic.controller
                                                              .text = "";
                                                          logic.controller2
                                                              .text = "";
                                                          logic.controller3
                                                              .text = "";
                                                          logic.tab_show.value =
                                                              2;
                                                        },
                                                      ),
                                                    )
                                                  ],
                                                )),
                                            // Obx(() => Container(
                                            //       margin: EdgeInsets.only(
                                            //           top: 20, bottom: 10),
                                            //       child: Text(
                                            //         logic.tab_show.value == 1
                                            //             ? '账号'.tr
                                            //             : '手机号'.tr,
                                            //       ),
                                            //     )),
                                            // Obx(() => Container(
                                            //     height: 44,
                                            //     child: TextField(
                                            //       inputFormatters: [
                                            //         if (logic.tab_show.value !=
                                            //             1)
                                            //           FilteringTextInputFormatter
                                            //               .allow(
                                            //                   RegExp('[0-9]')),
                                            //       ],
                                            //       controller: logic.controller,
                                            //       keyboardType:
                                            //           logic.tab_show.value == 1
                                            //               ? TextInputType.text
                                            //               : TextInputType.phone,
                                            //       decoration: InputDecoration(
                                            //         contentPadding:
                                            //             EdgeInsets.symmetric(
                                            //                 horizontal: 8,
                                            //                 vertical: 10),
                                            //         hintText:
                                            //             logic.tab_show.value ==
                                            //                     1
                                            //                 ? '请输入账号'.tr
                                            //                 : '请输入手机号'.tr,
                                            //         hintStyle: TextStyle(
                                            //             color:
                                            //                 Color(0xff999999)),
                                            //         counterText: '',
                                            //         suffixIcon: IconButton(
                                            //             icon: Icon(Icons.cancel,
                                            //                 size: 18,
                                            //                 color: logic
                                            //                         .cTxt
                                            //                         .value
                                            //                         .isNotEmpty
                                            //                     ? Color(
                                            //                         0xffCCCCCC)
                                            //                     : Colors
                                            //                         .transparent),
                                            //             onPressed: () {
                                            //               logic.controller
                                            //                   .text = '';
                                            //             }),
                                            //         border: OutlineInputBorder(
                                            //           borderRadius:
                                            //               BorderRadius.all(
                                            //                   Radius.circular(
                                            //                       5)),
                                            //         ),
                                            //
                                            //         ///设置输入框可编辑时的边框样式
                                            //         enabledBorder:
                                            //             OutlineInputBorder(
                                            //           ///设置边框四个角的弧度
                                            //           borderRadius:
                                            //               BorderRadius.all(
                                            //                   Radius.circular(
                                            //                       5)),
                                            //
                                            //           ///用来配置边框的样式
                                            //           borderSide: BorderSide(
                                            //             ///设置边框的颜色
                                            //             color:
                                            //                 Color(0xffDDDDDD),
                                            //
                                            //             ///设置边框的粗细
                                            //             width: 1.0,
                                            //           ),
                                            //         ),
                                            //
                                            //         ///用来配置输入框获取焦点时的颜色
                                            //         focusedBorder:
                                            //             OutlineInputBorder(
                                            //           ///设置边框四个角的弧度
                                            //           borderRadius:
                                            //               BorderRadius.all(
                                            //                   Radius.circular(
                                            //                       5)),
                                            //
                                            //           ///用来配置边框的样式
                                            //           borderSide: BorderSide(
                                            //             ///设置边框的颜色
                                            //             color: AppTheme
                                            //                 .themeHightColor,
                                            //
                                            //             ///设置边框的粗细
                                            //             width: 1.0,
                                            //           ),
                                            //         ),
                                            //       ),
                                            //       style: const TextStyle(
                                            //           color: Colors.black,
                                            //           fontSize: 14),
                                            //       maxLength: 20,
                                            //       onChanged:
                                            //           logic.textFieldChanged,
                                            //       autofocus: false,
                                            //     ))),

                                            Obx(() => TextFieldView(
                                              key: const ValueKey('acc'),
                                              title:  logic.tab_show.value == 1
                                                  ? '账号'.tr
                                                  : '手机号'.tr,
                                              hintText: logic.tab_show.value ==
                                                  1
                                                  ? '请输入账号'.tr
                                                  : '请输入手机号'.tr,
                                              isSaveType: true,
                                              // isRTextField: false,
                                              // isObscureText: logic.isObscureText.value,
                                              // isRTextField: true,
                                              keyboardType: logic.tab_show.value == 1
                                                  ? TextInputType.text
                                                  : TextInputType.phone,
                                              initValue:logic.cTxt.value,
                                              inputFormatters: [

                                                LengthLimitingTextInputFormatter(
                                                    logic.tab_show.value !=
                                                        1?11:30),
                                                // FilteringTextInputFormatter
                                                //       .allow(
                                                //       RegExp('[0-9]')),

                                              ],
                                              onSave: (bool isSave){
                                                logic.isSaveTFName.value = isSave;
                                                SpUtil().setString(saveTFNameKey,logic.isSaveTFName.value==true? logic.cTxt.value:'');

                                                },
                                              handleUnFocus: () {
                                                //request
                                              },
                                              onChanged: (value){
                                                logic.textFieldChanged;
                                                logic.cTxt.value = value;
                                                logic.controller.text = value;
                                                  if (logic.isSaveTFName.value) {
                                                  SpUtil().setString(saveTFNameKey, logic.cTxt.value);
                                                  }

                                                // setState(() {
                                                // });
                                              },),),


                                            // Container(
                                            //   margin: EdgeInsets.only(
                                            //       top: 25, bottom: 10),
                                            //   child: Text(
                                            //     '密码'.tr,
                                            //   ),
                                            // ),
                                            // Obx(
                                            //   () => Container(
                                            //       height: 44,
                                            //       child: TextField(
                                            //         controller:
                                            //             logic.controller2,
                                            //         keyboardType:
                                            //             TextInputType.text,
                                            //         obscureText: logic.isObscureText.value,
                                            //         decoration: InputDecoration(
                                            //             // fillColor: Color(0xff2F375B),
                                            //             contentPadding:
                                            //                 EdgeInsets
                                            //                     .symmetric(
                                            //                         horizontal:
                                            //                             8,
                                            //                         vertical:
                                            //                             10),
                                            //             hintText: '请输入密码'.tr,
                                            //             hintStyle: TextStyle(
                                            //                 color: Color(
                                            //                     0xff999999)),
                                            //             border:
                                            //                 OutlineInputBorder(
                                            //               borderRadius:
                                            //                   BorderRadius.all(
                                            //                       Radius
                                            //                           .circular(
                                            //                               5)),
                                            //             ),
                                            //
                                            //             ///设置输入框可编辑时的边框样式
                                            //             enabledBorder:
                                            //                 OutlineInputBorder(
                                            //               ///设置边框四个角的弧度
                                            //               borderRadius:
                                            //                   BorderRadius.all(
                                            //                       Radius
                                            //                           .circular(
                                            //                               5)),
                                            //
                                            //               ///用来配置边框的样式
                                            //               borderSide:
                                            //                   BorderSide(
                                            //                 ///设置边框的颜色
                                            //                 color: Color(
                                            //                     0xffDDDDDD),
                                            //
                                            //                 ///设置边框的粗细
                                            //                 width: 1.0,
                                            //               ),
                                            //             ),
                                            //
                                            //             ///用来配置输入框获取焦点时的颜色
                                            //             focusedBorder:
                                            //                 OutlineInputBorder(
                                            //               ///设置边框四个角的弧度
                                            //               borderRadius:
                                            //                   BorderRadius.all(
                                            //                       Radius
                                            //                           .circular(
                                            //                               5)),
                                            //
                                            //               ///用来配置边框的样式
                                            //               borderSide:
                                            //                   BorderSide(
                                            //                 ///设置边框的颜色
                                            //                 color: AppTheme
                                            //                     .themeHightColor,
                                            //
                                            //                 ///设置边框的粗细
                                            //                 width: 1.0,
                                            //               ),
                                            //             ),
                                            //             counterText: '',
                                            //             suffixIcon: IconButton(
                                            //                 icon: Icon(!logic.isObscureText.value?Icons.visibility
                                            //                     :Icons.visibility_off,
                                            //                   size: 18,
                                            //                   // color: widget.initValue.isNotEmpty
                                            //                   //     ? Color(0xffCCCCCC)
                                            //                   //     : Colors.transparent
                                            //                 ),
                                            //                 onPressed: () {
                                            //                   logic.isObscureText.value = ! logic.isObscureText.value;
                                            //
                                            //                   // widget.obscureTap!();
                                            //                   // widget.initValue = '';
                                            //                   // _inputController.text = '';
                                            //                 })
                                            //             // suffixIcon: IconButton(
                                            //             //     icon: Icon(
                                            //             //         Icons.cancel,
                                            //             //         size: 18,
                                            //             //         color: logic
                                            //             //                 .cTxt2
                                            //             //                 .value
                                            //             //                 .isNotEmpty
                                            //             //             ? Color(
                                            //             //                 0xffCCCCCC)
                                            //             //             : Colors
                                            //             //                 .transparent),
                                            //             //     onPressed: () {
                                            //             //       logic.controller2
                                            //             //           .text = '';
                                            //             //     })
                                            //         ),
                                            //         style: const TextStyle(
                                            //             color: Colors.black,
                                            //             fontSize: 14),
                                            //         maxLength: 20,
                                            //         onChanged:
                                            //             logic.textFieldChanged,
                                            //         autofocus: false,
                                            //       )),
                                            // ),


                                            Obx(() => TextFieldView(
                                              key: const ValueKey('code'),
                                              title: '密码'.tr,
                                              hintText:'请输入密码'.tr,
                                              isObscureType: true,
                                              isObscureText: logic.isObscureText.value,
                                              // isRTextField: true,
                                              // keyboardType: TextInputType.phone,
                                              initValue:logic.cTxt2.value,
                                              inputFormatters: [
                                                LengthLimitingTextInputFormatter(30),//11
                                                // FilteringTextInputFormatter.allow(RegExp("[0-9]")),//数字
                                              ],
                                              onObscured: (){
                                                logic.isObscureText.value = ! logic.isObscureText.value;
                                              },
                                              onChanged: (value){
                                                logic.textFieldChanged;
                                                logic.cTxt2.value = value;
                                                logic.controller2.text = value;
                                                // setState(() {
                                                // });
                                              },),),




                                            GestureDetector(
                                              onTap: () {
                                                Get.toNamed('/chatService');
                                              },
                                              child: Container(
                                                margin:
                                                    EdgeInsets.only(top: 10),
                                                child: Text(
                                                  '忘记密码？'.tr,
                                                  style: TextStyle(
                                                      color: AppTheme.themeHightColor,
                                                      fontSize: 14),
                                                ),
                                              ),
                                            ),



                                            // Container(
                                            //   margin:
                                            //   EdgeInsets.only(top: 20),
                                            // // SizedBox(
                                            //   width: MediaQuery.of(Get.context!).size.width-20,
                                            //   height: 50,
                                            //   child:
                                            //   FunTextButton(
                                            //     type: FunTextButtonType.primary,
                                            //     title: "登录",
                                            //     borderRadius: 6,
                                            //     onPressed: (){
                                            //       // if(!isNot)return;
                                            //
                                            //       if (logic.tab_show.value ==
                                            //           1) {
                                            //         if (logic.controller
                                            //             .text ==
                                            //             '') {
                                            //           FToast.toast(context,
                                            //               msg: "请输入账号".tr);
                                            //           return;
                                            //         }
                                            //         if (logic.controller2
                                            //             .text ==
                                            //             '') {
                                            //           FToast.toast(context,
                                            //               msg: "请输入密码".tr);
                                            //           return;
                                            //         }
                                            //       } else {
                                            //         showmsDialog();
                                            //         if (logic.controller
                                            //             .text ==
                                            //             '') {
                                            //           FToast.toast(context,
                                            //               msg: "请输入手机号".tr);
                                            //           return;
                                            //         }
                                            //         if (logic.controller2
                                            //             .text ==
                                            //             '') {
                                            //           FToast.toast(context,
                                            //               msg: "请输入密码".tr);
                                            //           return;
                                            //         }
                                            //       }
                                            //       // CaptchaPage().show(context);
                                            //       logic.postSubmit();
                                            //     },
                                            //   ),
                                            // ),
                                            //
                                            // Container(
                                            //     margin:
                                            //         EdgeInsets.only(top: 20),
                                            //     child: GestureDetector(
                                            //       onTap: () async {
                                            //         if (logic.tab_show.value ==
                                            //             1) {
                                            //           if (logic.controller
                                            //                   .text ==
                                            //               '') {
                                            //             FToast.toast(context,
                                            //                 msg: "请输入账号".tr);
                                            //             return;
                                            //           }
                                            //           if (logic.controller2
                                            //                   .text ==
                                            //               '') {
                                            //             FToast.toast(context,
                                            //                 msg: "请输入密码".tr);
                                            //             return;
                                            //           }
                                            //         } else {
                                            //           if (logic.controller
                                            //                   .text ==
                                            //               '') {
                                            //             FToast.toast(context,
                                            //                 msg: "请输入手机号".tr);
                                            //             return;
                                            //           }
                                            //           if (logic.controller2
                                            //                   .text ==
                                            //               '') {
                                            //             FToast.toast(context,
                                            //                 msg: "请输入密码".tr);
                                            //             return;
                                            //           }
                                            //         }
                                            //         // CaptchaPage().show(context);
                                            //         logic.postSubmit();
                                            //       },
                                            //       child: Container(
                                            //         decoration: BoxDecoration(
                                            //             borderRadius:
                                            //                 BorderRadius
                                            //                     .circular(4),
                                            //             color: AppTheme
                                            //                 .themeHightColor),
                                            //         padding: EdgeInsets.only(
                                            //             top: 14, bottom: 14),
                                            //         child: Center(
                                            //             child: Text(
                                            //           '登录'.tr,
                                            //           style: TextStyle(
                                            //               color: Colors.white,
                                            //               fontSize: 16),
                                            //         )),
                                            //       ),
                                            //     )),


                                            Container(
                                              margin: EdgeInsets.only(top: 25),
                                              child: Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Container(
                                                    child: Text(
                                                      '还没有账号？'.tr,
                                                      style: TextStyle(),
                                                    ),
                                                  ),
                                                  GestureDetector(
                                                    onTap: () {
                                                      Navigator.of(context)
                                                          .pushReplacementNamed(
                                                              "/register");
                                                    },
                                                    child: Text(
                                                      '去注册'.tr,
                                                      style: TextStyle(
                                                          color: AppTheme.themeHightColor),
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                            Container(
                                              width: double.infinity,
                                              height:
                                                  ScreenUtil().setHeight(100),
                                            )
                                          ])))))),
                  // Stack(children: [
                  //   Obx(() =>
                  //   Container(
                  //     // width: double.infinity,
                  //     // width: 130,
                  //     // height: 56.0,
                  //     alignment: Alignment.topCenter,
                  //     padding: const EdgeInsets.only(top: 50.0,left: 20),
                  //     child:
                  //
                  //     GestureDetector(
                  //       onTap: () async {
                  //         // if(logic.selRates.value.isNotEmpty) {
                  //         showRouteSelectDialog(context, (index, type) {
                  //
                  //           // setState(() {
                  //           logic.selIndex = index;
                  //           SpUtil().setInt(currentDomainIndex, logic.selIndex);
                  //
                  //           String localUrl = logic.selRoutes.value[logic.selIndex];
                  //           SpUtil().setString(currentDomainKey, localUrl);
                  //           if ((localUrl ?? "").isNotEmpty) {
                  //             configEnv.appBaseUrl =
                  //                 localUrl  ;
                  //           }
                  //
                  //           // HttpUtil.init(baseUrl: configEnv.appBaseUrl);
                  //           HttpV1().init(baseUrl: configEnv.appBaseUrl);
                  //
                  //           logic.curR.value = '${logic.selArr.value[logic.selIndex]}';
                  //           logic.curRate.value = int.parse(logic.selRates.value[logic.selIndex]);
                  //           if(logic.curRate.value==1000000){
                  //             logic.curRIn.value = '(测速中)';
                  //           }else{
                  //             logic.curRIn.value = '(${logic.selRates.value[logic.selIndex]} ms)';
                  //           }
                  //
                  //           // });
                  //
                  //         }, () {}, logic.selIndex, logic.selArr.value, logic.selRates.value); //selRoutes
                  //         // }
                  //       },
                  //       child:  Padding(
                  //           padding: EdgeInsets.only(left:0,top: 0.0, right: 0.0),
                  //           child:
                  //
                  //           Row(children: [
                  //
                  //             const SizedBox(
                  //               width: 3,
                  //             ),
                  //             Text(
                  //               logic.curR.value,
                  //               style: TextStyle(
                  //                 color: Color(0xFF666666),
                  //                 fontWeight: FontWeight.normal,
                  //                 fontSize: 14,
                  //                 // inherit: true,
                  //               ),
                  //
                  //             ),
                  //
                  //             Text(
                  //               logic.curRIn.value,
                  //               style: TextStyle(
                  //                 color:enumTypeColor(type: logic.curRate.value)
                  //                 ,
                  //                 fontWeight: FontWeight.normal,
                  //                 fontSize: 14,
                  //                 // decoration: TextDecoration.underline,
                  //               ),
                  //               textAlign: TextAlign.center,
                  //             ),
                  //
                  //           ],)
                  //       ),
                  //     ),
                  //
                  //
                  //   ),
                  //   ),
                  // ],),

                  Positioned(
                        top: 30,
                        right: 8,
                        child:
                        Column(children: [
                          IconButton(
                            icon: const Icon(
                              Icons.language,
                              color: Color(0xff333333),
                              size: 25,
                            ),
                            onPressed: () {
                              Get.offNamed('/langSetting',
                                  parameters: {'path': '0'});
                            },
                          ),





                        ],)
                        ),

                  // Positioned(
                  //     top: 90,
                  //     right: 20,
                  //     child:
                  //     Obx(() =>
                  //         Container(
                  //           // color: Colors.red,
                  //           // width: double.infinity,
                  //           // width: 130,
                  //           // height: 26.0,
                  //           alignment: Alignment.centerRight,
                  //           padding: const EdgeInsets.only(top: 0.0,right: 0),
                  //           child:
                  //
                  //           GestureDetector(
                  //             onTap: () async {
                  //               // if(logic.selRates.value.isNotEmpty) {
                  //                 showRouteSelectDialog(context, (index, type) {
                  //
                  //                   // setState(() {
                  //                   logic.selIndex = index;
                  //                   SpUtil().setInt(currentDomainIndex, logic.selIndex);
                  //
                  //                   String localUrl = logic.selRoutes.value[logic.selIndex];
                  //                   SpUtil().setString(currentDomainKey, localUrl);
                  //                   if ((localUrl ?? "").isNotEmpty) {
                  //                     configEnv.appBaseUrl =
                  //                         localUrl  ;
                  //                   }
                  //
                  //                   // HttpUtil.init(baseUrl: configEnv.appBaseUrl);
                  //                   HttpV1().init(baseUrl: configEnv.appBaseUrl);
                  //
                  //                   logic.curR.value = '${logic.selArr.value[logic.selIndex]}';
                  //                   logic.curRate.value = int.parse(logic.selRates.value[logic.selIndex]);
                  //                   if(logic.curRate.value==1000000){
                  //                     logic.curRIn.value = '(测速中)';
                  //                   }else{
                  //                     logic.curRIn.value = '(${logic.selRates.value[logic.selIndex]} ms)';
                  //                   }
                  //
                  //                   // });
                  //
                  //                 }, () {}, logic.selIndex, logic.selArr.value, logic.selRates.value); //selRoutes
                  //               // }
                  //
                  //             },
                  //             child:  Padding(
                  //                 padding: EdgeInsets.only(left:0,top: 0.0, right: 0.0),
                  //                 child:
                  //
                  //                 Row(children: [
                  //
                  //                   const SizedBox(
                  //                     width: 3,
                  //                   ),
                  //                   Text(
                  //                     logic.curR.value,
                  //                     style: TextStyle(
                  //                       color: Color(0xFF666666),
                  //                       fontWeight: FontWeight.normal,
                  //                       fontSize: 14,
                  //                       // inherit: true,
                  //                     ),
                  //
                  //                   ),
                  //
                  //                   Text(
                  //                     logic.curRIn.value,
                  //                     style: TextStyle(
                  //                       color:enumTypeColor(type: logic.curRate.value)
                  //                       ,
                  //                       fontWeight: FontWeight.normal,
                  //                       fontSize: 14,
                  //                       // decoration: TextDecoration.underline,
                  //                     ),
                  //                     textAlign: TextAlign.center,
                  //                   ),
                  //
                  //                 ],)
                  //             ),
                  //           ),
                  //
                  //
                  //         ),
                  //     ),
                  // ),

                  Positioned(
                      bottom: 0,
                      right: 20,
                      // child: IconButton(
                      //   icon: const Icon(
                      //     Icons.language,
                      //     color: Color(0xff333333),
                      //     size: 25,
                      //   ),
                      //   onPressed: () {
                      //     print(111);
                      //   },
                      // )
                      child: GestureDetector(
                        onTap: () {
                          // Get.toNamed('/chatService');

                          platformutil.PlatformUtils.toWebView(
                              title: '百度', url: 'https://baidu.com');
                        },
                        child: Image.asset(
                          'assets/images/chat/server.png',
                          width: 50,
                        ),
                      )),
                ]))));
  }

  void showmsDialog(){
    showSMSVerifyDialog(Get.context!,
            (p,i) async {

        },
            (p,m) async {

            },

         () {});
  }
}
