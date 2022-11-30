import 'package:container_tab_indicator/container_tab_indicator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';
import '../../../widgets/text_widget.dart';

import '../../../util/DefaultAppBar.dart';
import '../../../style/theme.dart';
import '../../../widgets/button_widget.dart';
import '../../../widgets/sizebox_widget.dart';
import 'logic.dart';

class AddBankPage extends StatelessWidget {
  final logic = Get.put(AddBankLogic());
  // final logic = Get.find<SetAddAddrLogic>();

  @override
  Widget build(BuildContext context) {
    return KeyboardDismisser(
        gestures: [
          GestureType.onTap,
          GestureType.onPanUpdateDownDirection,
        ],
        child: Scaffold(
            // resizeToAvoidBottomInset: false, //解决键盘导致溢出页面
            appBar: DefaultAppBar(
              titleStr: '新增账户'.tr,
            ),
            backgroundColor: const Color(0xffffffff),
            body: SafeArea(
                child: SingleChildScrollView(
                    child: Column(
              children: [
                divideLine(),
                // SizedBox(height: 5,),

                Container(
                    margin: const EdgeInsets.only(top: 15, left: 15, right: 15),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          // Row(children: [
                          //   // Container(child:
                          //   Column(crossAxisAlignment:
                          //   CrossAxisAlignment.start,
                          //     mainAxisAlignment: MainAxisAlignment.start,children: [
                          //       syText(text: '名字'),
                          //     SizedBox(height: 10,),
                          //
                          //     Container(
                          //         width: ScreenUtil().setWidth(165),
                          //         height: 44,
                          //         child:
                          //         TextField(
                          //           controller: logic.controller0,
                          //           keyboardType: TextInputType.text,
                          //           decoration: InputDecoration(
                          //               // filled: true,
                          //               focusedBorder:  OutlineInputBorder(
                          //                 borderSide: BorderSide(color: AppTheme.themeHightColor, width: 1.0),
                          //               ),
                          //               enabledBorder: OutlineInputBorder(
                          //                 borderSide: BorderSide(color: HexColor('#DDDDDD'), width: 1.0),
                          //               ),
                          //               labelText: '',
                          //               labelStyle: TextStyle(
                          //                   color: Color(0xff666B84)
                          //               ),
                          //               border: InputBorder.none,
                          //               counterText: '',
                          //               // suffixIcon: IconButton(
                          //               //     icon: const Icon(Icons.cancel,size: 15,
                          //               //         color: Color(0xff50577B)),
                          //               //     onPressed: () {
                          //               //       logic.controller0.text = '';
                          //               //     })
                          //           ),
                          //           style: const TextStyle(
                          //               color: Colors.black),
                          //           maxLength: 20,
                          //           onChanged: logic.textFieldChanged,
                          //           autofocus: false,
                          //         )
                          //     ),
                          //   ],),
                          //   // ),
                          //   Expanded(child: SizedBox()) ,
                          //
                          //   Column(crossAxisAlignment:
                          //   CrossAxisAlignment.start,
                          //     mainAxisAlignment: MainAxisAlignment.start,children: [
                          //     syText(text: '姓氏'),
                          //       SizedBox(height: 10,),
                          //     Container(
                          //         width: ScreenUtil().setWidth(165),
                          //         height: 44,
                          //         child: TextField(
                          //           controller: logic.controller1,
                          //           keyboardType: TextInputType.text,
                          //           decoration: InputDecoration(
                          //             // fillColor: Color(0xff2F375B),
                          //             //   filled: true,
                          //               focusedBorder:  OutlineInputBorder(
                          //                 borderSide: BorderSide(color: AppTheme.themeHightColor, width: 1.0),
                          //               ),
                          //               enabledBorder: OutlineInputBorder(
                          //                 borderSide: BorderSide(color: HexColor('#DDDDDD'), width: 1.0),
                          //               ),
                          //               labelText: '',
                          //               labelStyle: TextStyle(
                          //                   color: Color(0xff666B84)),
                          //               border: InputBorder.none,
                          //               counterText: '',
                          //               // suffixIcon: IconButton(
                          //               //     icon: const Icon(Icons.cancel,size: 15,
                          //               //         color: Color(0xff50577B)),
                          //               //     onPressed: () {
                          //               //       logic.controller1.text = '';
                          //               //     })
                          //           ),
                          //           style: const TextStyle(
                          //               color: Colors.black),
                          //           maxLength: 20,
                          //           onChanged: logic.textFieldChanged,
                          //           autofocus: false,
                          //         )),
                          //   ],),
                          //
                          //
                          // ],),

                          SizedBox(
                            height: 15,
                          ),
                          syText(text: '真实姓名（仅支持本人）'.tr),
                          SizedBox(
                            height: 10,
                          ),
                          Obx(
                            () => Container(
                                height: 44,
                                child: TextField(
                                  controller: logic.controller1,
                                  keyboardType: TextInputType.text,
                                  decoration: InputDecoration(
                                      isCollapsed: true,
                                      // contentPadding: EdgeInsets.all(10),

                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                              vertical: 13.0, horizontal: 10),
                                      // filled: true,
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: AppTheme.themeHightColor,
                                            width: 1.0),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Color(0xffDDDDDD),
                                            width: 1.0),
                                      ),
                                      // labelText: '请输入姓名'.tr,
                                      // labelStyle: TextStyle(
                                      //     color: Color(0xff666B84)
                                      // ),
                                      hintText: '请输入真实姓名'.tr,
                                      hintStyle:
                                          TextStyle(color: Color(0xff666B84)),
                                      border: InputBorder.none,
                                      counterText: '',
                                      suffixIcon: IconButton(
                                          icon: Icon(Icons.cancel,
                                              size: 18,
                                              color: logic.cTxt.value.isNotEmpty
                                                  ? Color(0xffCCCCCC)
                                                  : Colors.transparent),
                                          onPressed: () {
                                            logic.controller1.text = '';
                                          })),
                                  style: const TextStyle(color: Colors.black),
                                  maxLength: 100,
                                  onChanged: logic.textFieldChanged,
                                  autofocus: false,
                                )),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          syText(text: '开户行名称'.tr),
                          SizedBox(
                            height: 10,
                          ),
                          Obx(
                            () => Container(
                                height: 44,
                                child: TextField(
                                  controller: logic.controller2,
                                  keyboardType: TextInputType.text,
                                  decoration: InputDecoration(
                                      isCollapsed: true,
                                      // contentPadding: EdgeInsets.all(10),

                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                              vertical: 13.0, horizontal: 10),

                                      // filled: true,
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: AppTheme.themeHightColor,
                                            width: 1.0),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Color(0xffDDDDDD),
                                            width: 1.0),
                                      ),
                                      hintText: '开户行名称'.tr,
                                      hintStyle:
                                          TextStyle(color: Color(0xff666B84)),
                                      border: InputBorder.none,
                                      counterText: '',
                                      suffixIcon: IconButton(
                                          icon: Icon(Icons.cancel,
                                              size: 18,
                                              color:
                                                  logic.cTxt2.value.isNotEmpty
                                                      ? Color(0xffCCCCCC)
                                                      : Colors.transparent),
                                          onPressed: () {
                                            logic.controller2.text = '';
                                          })),
                                  style: const TextStyle(color: Colors.black),
                                  maxLength: 100,
                                  onChanged: logic.textFieldChanged,
                                  autofocus: false,
                                )),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          syText(text: '号'.tr),
                          SizedBox(
                            height: 10,
                          ),
                          Obx(
                            () => Container(
                                height: 44,
                                child: TextField(
                                  inputFormatters: [
                                    FilteringTextInputFormatter.allow(
                                        RegExp('[0-9]')),
                                    // FilteringTextInputFormatter.allow(
                                    //     RegExp(r'[a-zA-Z0-9_@.]'
                                    //     r'')),
                                  ],
                                  controller: logic.controller3,
                                  keyboardType: TextInputType.phone,
                                  decoration: InputDecoration(
                                    isCollapsed: true,
                                    // contentPadding: EdgeInsets.all(10),

                                    contentPadding: const EdgeInsets.symmetric(
                                        vertical: 13.0, horizontal: 10),
                                    // fillColor: Color(0xff2F375B),
                                    // filled: true,
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: AppTheme.themeHightColor,
                                          width: 1.0),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Color(0xffDDDDDD), width: 1.0),
                                    ),
                                    hintText: '请输入号'.tr,
                                    hintStyle:
                                        TextStyle(color: Color(0xff666B84)),
                                    border: InputBorder.none,
                                    counterText: '',
                                    suffixIcon: IconButton(
                                        icon: Icon(Icons.cancel,
                                            size: 18,
                                            color: logic.cTxt3.value.isNotEmpty
                                                ? Color(0xffCCCCCC)
                                                : Colors.transparent),
                                        onPressed: () {
                                          logic.controller3.text = '';
                                        }),
                                  ),
                                  style: const TextStyle(color: Colors.black),
                                  maxLength: 30,
                                  onChanged: logic.textFieldChanged,
                                  autofocus: false,
                                )),
                          ),
                        ])),

                Column(children: [
                  SizedBox(
                    height: 15,
                  ), //

                  Container(
                    margin: const EdgeInsets.only(left: 15, right: 15),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: Container(
                            //padding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                            child: textContainer(
                                text: '设为默认账户'.tr,
                                continerAlign: Alignment.centerLeft),
                          ),
                        ),
                        Obx(
                          () => CupertinoSwitch(
                            value: logic.status0.value == 0 ? false : true,
                            onChanged: (bool value) {
                              logic.status0.value = value == false ? 0 : 1;
                            },
                          ),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(
                    height: 15,
                  ),
                  customFootFuncBtn('保存'.tr, () {
                    logic.txtForm(context);
                  }),
                  SizedBox(
                    height: 15,
                  ),
                ]),
              ],
            )))));
  }
}
