import 'package:container_tab_indicator/container_tab_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ftoast/ftoast.dart';
import 'package:get/get.dart';
import '../../../style/theme.dart';
import 'logic.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';

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
                                                '??????'.tr,
                                                style: TextStyle(
                                                    fontSize: 30,
                                                    fontWeight:
                                                        FontWeight.w700),
                                              ),
                                            ),
                                            // Obx(() => Row(
                                            //       crossAxisAlignment:
                                            //           CrossAxisAlignment.start,
                                            //       mainAxisAlignment:
                                            //           MainAxisAlignment.start,
                                            //       children: [
                                            //         Container(
                                            //           height: 34,
                                            //           margin: EdgeInsets.only(
                                            //               top: 30),
                                            //           child: FlatButton(
                                            //             color:
                                            //                 logic.tab_show
                                            //                             .value ==
                                            //                         1
                                            //                     ? AppTheme
                                            //                         .themeHightColor
                                            //                     : Color(
                                            //                         0xffEEEEEE),
                                            //             minWidth: 50,
                                            //             padding:
                                            //                 EdgeInsets.only(
                                            //                     left: 25,
                                            //                     right: 25),
                                            //             child: Text(
                                            //               '??????'.tr,
                                            //               style: logic.tab_show
                                            //                           .value ==
                                            //                       1
                                            //                   ? TextStyle(
                                            //                       color: Colors
                                            //                           .white)
                                            //                   : TextStyle(
                                            //                       color: Colors
                                            //                           .black),
                                            //             ),
                                            //             onPressed: () async {
                                            //               logic.controller
                                            //                   .text = "";
                                            //               logic.controller2
                                            //                   .text = "";
                                            //               logic.controller3
                                            //                   .text = "";
                                            //               logic.tab_show.value =
                                            //                   1;
                                            //             },
                                            //           ),
                                            //         ),
                                            //         Container(
                                            //           height: 34,
                                            //           margin: EdgeInsets.only(
                                            //               left: 10, top: 30),
                                            //           child: FlatButton(
                                            //             color:
                                            //                 logic.tab_show
                                            //                             .value ==
                                            //                         2
                                            //                     ? AppTheme
                                            //                         .themeHightColor
                                            //                     : Color(
                                            //                         0xffEEEEEE),
                                            //             minWidth: 50,
                                            //             padding:
                                            //                 EdgeInsets.only(
                                            //                     left: 25,
                                            //                     right: 25),
                                            //             child: Text(
                                            //               '?????????'.tr,
                                            //               style: logic.tab_show
                                            //                           .value ==
                                            //                       2
                                            //                   ? TextStyle(
                                            //                       color: Colors
                                            //                           .white)
                                            //                   : TextStyle(
                                            //                       color: Colors
                                            //                           .black),
                                            //             ),
                                            //             onPressed: () async {
                                            //               logic.controller
                                            //                   .text = "";
                                            //               logic.controller2
                                            //                   .text = "";
                                            //               logic.controller3
                                            //                   .text = "";
                                            //               logic.tab_show.value =
                                            //                   2;
                                            //             },
                                            //           ),
                                            //         )
                                            //       ],
                                            //     )),
                                            // Obx(() => Container(
                                            //       margin: EdgeInsets.only(
                                            //           top: 20, bottom: 10),
                                            //       child: Text(
                                            //         logic.tab_show.value == 1
                                            //             ? '??????'.tr
                                            //             : '?????????'.tr,
                                            //       ),
                                            //     )),
                                            Obx(() => Container(
                                                height: 44,
                                                child: TextField(
                                                  inputFormatters: [
                                                    if (logic.tab_show.value !=
                                                        1)
                                                      FilteringTextInputFormatter
                                                          .allow(
                                                              RegExp('[0-9]')),
                                                  ],
                                                  controller: logic.controller,
                                                  keyboardType:
                                                      logic.tab_show.value == 1
                                                          ? TextInputType.text
                                                          : TextInputType.phone,
                                                  decoration: InputDecoration(
                                                    contentPadding:
                                                        EdgeInsets.symmetric(
                                                            horizontal: 8,
                                                            vertical: 10),
                                                    hintText:
                                                        logic.tab_show.value ==
                                                                1
                                                            ? '???????????????'.tr
                                                            : '??????????????????'.tr,
                                                    hintStyle: TextStyle(
                                                        color:
                                                            Color(0xff999999)),
                                                    counterText: '',
                                                    suffixIcon: IconButton(
                                                        icon: Icon(Icons.cancel,
                                                            size: 18,
                                                            color: logic
                                                                    .cTxt
                                                                    .value
                                                                    .isNotEmpty
                                                                ? Color(
                                                                    0xffCCCCCC)
                                                                : Colors
                                                                    .transparent),
                                                        onPressed: () {
                                                          logic.controller
                                                              .text = '';
                                                        }),
                                                    border: OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  5)),
                                                    ),

                                                    ///??????????????????????????????????????????
                                                    enabledBorder:
                                                        OutlineInputBorder(
                                                      ///??????????????????????????????
                                                      borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  5)),

                                                      ///???????????????????????????
                                                      borderSide: BorderSide(
                                                        ///?????????????????????
                                                        color:
                                                            Color(0xffDDDDDD),

                                                        ///?????????????????????
                                                        width: 1.0,
                                                      ),
                                                    ),

                                                    ///?????????????????????????????????????????????
                                                    focusedBorder:
                                                        OutlineInputBorder(
                                                      ///??????????????????????????????
                                                      borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  5)),

                                                      ///???????????????????????????
                                                      borderSide: BorderSide(
                                                        ///?????????????????????
                                                        color: AppTheme
                                                            .themeHightColor,

                                                        ///?????????????????????
                                                        width: 1.0,
                                                      ),
                                                    ),
                                                  ),
                                                  style: const TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 14),
                                                  maxLength: 20,
                                                  onChanged:
                                                      logic.textFieldChanged,
                                                  autofocus: false,
                                                ))),
                                            Container(
                                              margin: EdgeInsets.only(
                                                  top: 25, bottom: 10),
                                              child: Text(
                                                '??????'.tr,
                                              ),
                                            ),
                                            Obx(
                                              () => Container(
                                                  height: 44,
                                                  child: TextField(
                                                    controller:
                                                        logic.controller2,
                                                    keyboardType:
                                                        TextInputType.text,
                                                    obscureText: true,
                                                    decoration: InputDecoration(
                                                        // fillColor: Color(0xff2F375B),
                                                        contentPadding:
                                                            EdgeInsets
                                                                .symmetric(
                                                                    horizontal:
                                                                        8,
                                                                    vertical:
                                                                        10),
                                                        hintText: '???????????????'.tr,
                                                        hintStyle: TextStyle(
                                                            color: Color(
                                                                0xff999999)),
                                                        border:
                                                            OutlineInputBorder(
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                  Radius
                                                                      .circular(
                                                                          5)),
                                                        ),

                                                        ///??????????????????????????????????????????
                                                        enabledBorder:
                                                            OutlineInputBorder(
                                                          ///??????????????????????????????
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                  Radius
                                                                      .circular(
                                                                          5)),

                                                          ///???????????????????????????
                                                          borderSide:
                                                              BorderSide(
                                                            ///?????????????????????
                                                            color: Color(
                                                                0xffDDDDDD),

                                                            ///?????????????????????
                                                            width: 1.0,
                                                          ),
                                                        ),

                                                        ///?????????????????????????????????????????????
                                                        focusedBorder:
                                                            OutlineInputBorder(
                                                          ///??????????????????????????????
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                  Radius
                                                                      .circular(
                                                                          5)),

                                                          ///???????????????????????????
                                                          borderSide:
                                                              BorderSide(
                                                            ///?????????????????????
                                                            color: AppTheme
                                                                .themeHightColor,

                                                            ///?????????????????????
                                                            width: 1.0,
                                                          ),
                                                        ),
                                                        counterText: '',
                                                        suffixIcon: IconButton(
                                                            icon: Icon(
                                                                Icons.cancel,
                                                                size: 18,
                                                                color: logic
                                                                        .cTxt2
                                                                        .value
                                                                        .isNotEmpty
                                                                    ? Color(
                                                                        0xffCCCCCC)
                                                                    : Colors
                                                                        .transparent),
                                                            onPressed: () {
                                                              logic.controller2
                                                                  .text = '';
                                                            })),
                                                    style: const TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 14),
                                                    maxLength: 20,
                                                    onChanged:
                                                        logic.textFieldChanged,
                                                    autofocus: false,
                                                  )),
                                            ),
                                            // GestureDetector(
                                            //   onTap: () {
                                            //     Get.toNamed('/chatService');
                                            //   },
                                            //   child: Container(
                                            //     margin:
                                            //         EdgeInsets.only(top: 10),
                                            //     child: Text(
                                            //       '???????????????'.tr,
                                            //       style: TextStyle(
                                            //           color: Color(0xff1D91FF),
                                            //           fontSize: 14),
                                            //     ),
                                            //   ),
                                            // ),
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
                                            //                 msg: "???????????????".tr);
                                            //             return;
                                            //           }
                                            //           if (logic.controller2
                                            //                   .text ==
                                            //               '') {
                                            //             FToast.toast(context,
                                            //                 msg: "???????????????".tr);
                                            //             return;
                                            //           }
                                            //         } else {
                                            //           if (logic.controller
                                            //                   .text ==
                                            //               '') {
                                            //             FToast.toast(context,
                                            //                 msg: "??????????????????".tr);
                                            //             return;
                                            //           }
                                            //           if (logic.controller2
                                            //                   .text ==
                                            //               '') {
                                            //             FToast.toast(context,
                                            //                 msg: "???????????????".tr);
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
                                            //           '??????'.tr,
                                            //           style: TextStyle(
                                            //               color: Colors.white,
                                            //               fontSize: 16),
                                            //         )),
                                            //       ),
                                            //     )),
                                            // Container(
                                            //   margin: EdgeInsets.only(top: 25),
                                            //   child: Row(
                                            //     crossAxisAlignment:
                                            //         CrossAxisAlignment.center,
                                            //     mainAxisAlignment:
                                            //         MainAxisAlignment.center,
                                            //     children: [
                                            //       Container(
                                            //         child: Text(
                                            //           '??????????????????'.tr,
                                            //           style: TextStyle(),
                                            //         ),
                                            //       ),
                                            //       GestureDetector(
                                            //         onTap: () {
                                            //           Navigator.of(context)
                                            //               .pushReplacementNamed(
                                            //                   "/register");
                                            //         },
                                            //         child: Text(
                                            //           '?????????'.tr,
                                            //           style: TextStyle(
                                            //               color: Colors.blue),
                                            //         ),
                                            //       )
                                            //     ],
                                            //   ),
                                            // ),
                                            Container(
                                              width: double.infinity,
                                              height:
                                                  ScreenUtil().setHeight(100),
                                            )
                                          ])))))),
                  // Positioned(
                  //     top: 30,
                  //     right: 8,
                  //     child: IconButton(
                  //       icon: const Icon(
                  //         Icons.language,
                  //         color: Color(0xff333333),
                  //         size: 25,
                  //       ),
                  //       onPressed: () {
                  //         Get.offNamed('/langSetting',
                  //             parameters: {'path': '0'});
                  //       },
                  //     )),
                  // Positioned(
                  //     bottom: 0,
                  //     right: 20,
                  //     // child: IconButton(
                  //     //   icon: const Icon(
                  //     //     Icons.language,
                  //     //     color: Color(0xff333333),
                  //     //     size: 25,
                  //     //   ),
                  //     //   onPressed: () {
                  //     //     print(111);
                  //     //   },
                  //     // )
                  //     child: GestureDetector(
                  //       onTap: () {
                  //         Get.toNamed('/chatService');
                  //       },
                  //       child: Image.asset(
                  //         'assets/images/chat/server.png',
                  //         width: 50,
                  //       ),
                  //     )),
                ]))));
  }
}
