import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ftoast/ftoast.dart';
import 'package:get/get.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../style/theme.dart';
import 'logic.dart';

class RegisterPage extends StatelessWidget {
  final logic = Get.put(RegisterLogic());

  @override
  Widget build(BuildContext context) {
    return
      KeyboardDismisser(
        gestures: [
        GestureType.onTap,
        GestureType.onPanUpdateDownDirection,
        ],
        child:
      WillPopScope(
        onWillPop: () async {
          // Navigator.of(context).pushReplacementNamed("/");
          Get.offNamed("/");
          
          return true;
        },
        child: Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
                centerTitle: true,
                // 标题居中
                // title: const Text("登录"),
                // backgroundColor: const Color(0xff1D223A),
                elevation: 0,
                actions: [
                  IconButton(
                    // 左边图标
                    icon: const Icon(Icons.close),
                    onPressed: () {
                      // Navigator.of(context).pushReplacementNamed("/login");
                      Get.offNamed("/login");
                    },
                  ),
                ]),
            // resizeToAvoidBottomInset: false, //解决键盘导致溢出页面
            // backgroundColor: const Color(0xff1D223A),
            body: Obx(() =>Scrollbar(
                child: SafeArea(
                    child: SizedBox(
                        width: double.infinity,
                        child: SingleChildScrollView(
                            child: Container(
                                margin: const EdgeInsets.only(
                                    top: 10, left: 15, right: 15, bottom: 15),
                                child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: <Widget>[
                                      Container(
                                        margin: EdgeInsets.only(top: 20),
                                        child: Text(
                                          '注册'.tr,
                                          style: TextStyle(
                                              fontSize: 30,
                                              fontWeight: FontWeight.w700),
                                        ),
                                      ),
                                      Row(
                                        crossAxisAlignment:CrossAxisAlignment.start,
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: [
                                          Container(
                                            height: 34,
                                            margin: EdgeInsets.only(
                                                top: 30),
                                            child: FlatButton(
                                              color: logic.tab_show.value==1?AppTheme.themeHightColor:Color(0xffEEEEEE),
                                              minWidth: 50,
                                              padding:
                                              EdgeInsets.only(left: 25, right: 25),
                                              child: Text(
                                                '账号'.tr,
                                                style: logic.tab_show.value==1?TextStyle(color: Colors.white):TextStyle(color: Colors.black),
                                              ),
                                              onPressed: () async {
                                                logic.controller.text = "";
                                                logic.controller2.text = "";
                                                logic.controller3.text = "";
                                                logic.tab_show.value = 1;
                                              },
                                            ),
                                          ),
                                          Container(
                                            height: 34,
                                            margin: EdgeInsets.only(left: 10,
                                                top: 30),
                                            child: FlatButton(
                                              color: logic.tab_show.value==2?AppTheme.themeHightColor:Color(0xffEEEEEE),
                                              minWidth: 50,
                                              padding:
                                              EdgeInsets.only(left: 25, right: 25),
                                              child: Text(
                                                '手机号'.tr,
                                                style: logic.tab_show.value==2?TextStyle(color: Colors.white):TextStyle(color: Colors.black),
                                              ),
                                              onPressed: () async {
                                                logic.controller.text = "";
                                                logic.controller2.text = "";
                                                logic.controller3.text = "";
                                                logic.tab_show.value = 2;
                                              },
                                            ),
                                          )
                                        ],
                                      ),
                                      Container(
                                        margin: EdgeInsets.only(
                                            top: 24, bottom: 10),
                                        child: Text(
                                          logic.tab_show.value==1?'账号'.tr:'手机号'.tr,
                                        ),
                                      ),
                                      Obx(() =>Container(
                                        height: 44,
                                          child: TextField(
                                            inputFormatters: [
                                              if(logic.tab_show.value != 1)FilteringTextInputFormatter.allow(RegExp('[0-9]')),

                                            ],
                                        controller: logic.controller,
                                        keyboardType:
                                        logic.tab_show.value == 1
                                            ? TextInputType.text
                                            : TextInputType.phone,
                                        decoration: InputDecoration(
                                          contentPadding:
                                          EdgeInsets.symmetric(horizontal: 8, vertical: 10),
                                            hintText: logic.tab_show.value==1?'请输入账号'.tr:'请输入手机号'.tr,
                                            hintStyle: TextStyle(
                                                color: Color(0xff999999)),
                                            counterText: '',
                                            // suffixIcon:Icon(Icons.close),
                                            suffixIcon: IconButton(
                                                icon:  Icon(Icons.cancel,
                                                    size: 18,
                                                    color:
                                                    logic.cTxt.value.isNotEmpty?
                                                    Color(0xffCCCCCC)
                                                        :Colors.transparent
                                                ),
                                                onPressed: () {
                                                  logic.controller.text = '';
                                                }),
                                          border: OutlineInputBorder(
                                            borderRadius: BorderRadius.all(Radius.circular(5)),
                                          ),
                                          ///设置输入框可编辑时的边框样式
                                          enabledBorder: OutlineInputBorder(
                                            ///设置边框四个角的弧度
                                            borderRadius: BorderRadius.all(Radius.circular(5)),
                                            ///用来配置边框的样式
                                            borderSide: BorderSide(
                                              ///设置边框的颜色
                                              color: Color(0xffDDDDDD),
                                              ///设置边框的粗细
                                              width: 1.0,
                                            ),
                                          ),
                                          ///用来配置输入框获取焦点时的颜色
                                          focusedBorder: OutlineInputBorder(
                                            ///设置边框四个角的弧度
                                            borderRadius: BorderRadius.all(Radius.circular(5)),
                                            ///用来配置边框的样式
                                            borderSide: BorderSide(
                                              ///设置边框的颜色
                                              color: AppTheme.themeHightColor,
                                              ///设置边框的粗细
                                              width: 1.0,
                                            ),
                                          ),
                                        ),
                                        style: const TextStyle(
                                            color: Colors.black,fontSize: 14),
                                        maxLength: 20,
                                        onChanged: logic.textFieldChanged,
                                        autofocus: false,
                                      )),),
                                      Container(
                                        margin: EdgeInsets.only(
                                            top: 25, bottom: 10),
                                        child: Text(
                                          '密码'.tr,
                                        ),
                                      ),
                                      Obx(() =>Container(
                                        height: 44,
                                          child: TextField(
                                        controller: logic.controller2,
                                        keyboardType: TextInputType.text,
                                        obscureText: true,
                                        decoration: InputDecoration(
                                          contentPadding:
                                          EdgeInsets.symmetric(horizontal: 8, vertical: 10),
                                            // fillColor: Color(0xff2F375B),
                                            hintText: '请输入密码'.tr,
                                            hintStyle: TextStyle(
                                                color: Color(0xff999999)),
                                            counterText: '',
                                            // suffixIcon:Icon(Icons.close),
                                            suffixIcon: IconButton(
                                                icon:  Icon(Icons.cancel,
                                                    size: 18,
                                                    color:
                                                    logic.cTxt2.value.isNotEmpty?
                                                    Color(0xffCCCCCC)
                                                        :Colors.transparent
                                                ),
                                                onPressed: () {
                                                  logic.controller2.text = '';
                                                }),
                                          border: OutlineInputBorder(
                                            borderRadius: BorderRadius.all(Radius.circular(5)),
                                          ),
                                          ///设置输入框可编辑时的边框样式
                                          enabledBorder: OutlineInputBorder(
                                            ///设置边框四个角的弧度
                                            borderRadius: BorderRadius.all(Radius.circular(5)),
                                            ///用来配置边框的样式
                                            borderSide: BorderSide(
                                              ///设置边框的颜色
                                              color: Color(0xffDDDDDD),
                                              ///设置边框的粗细
                                              width: 1.0,
                                            ),
                                          ),
                                          ///用来配置输入框获取焦点时的颜色
                                          focusedBorder: OutlineInputBorder(
                                            ///设置边框四个角的弧度
                                            borderRadius: BorderRadius.all(Radius.circular(5)),
                                            ///用来配置边框的样式
                                            borderSide: BorderSide(
                                              ///设置边框的颜色
                                              color: AppTheme.themeHightColor,
                                              ///设置边框的粗细
                                              width: 1.0,
                                            ),
                                          ),
                                        ),
                                        style: const TextStyle(
                                            color: Colors.black,fontSize: 14),
                                        maxLength: 20,
                                        onChanged: logic.textFieldChanged,
                                        autofocus: false,
                                      )),),
                                      Container(
                                        margin: EdgeInsets.only(
                                            top: 25, bottom: 10),
                                        child: Text(
                                          '邀请码'.tr,
                                        ),
                                      ),
                                      Obx(() =>Container(
                                        height: 44,
                                          child: Row(children: [
                                        Expanded(
                                            flex: 1,
                                            child: TextField(
                                              controller: logic.controller3,
                                              keyboardType: TextInputType.text,
                                              decoration:  InputDecoration(
                                                contentPadding:
                                                EdgeInsets.symmetric(horizontal: 8, vertical: 10),
                                                  // fillColor: Color(0xff2F375B),
                                                  hintText: '请输入邀请码'.tr,
                                                  hintStyle: TextStyle(
                                                      color: Color(0xff999999)),
                                                  counterText: '',
                                                  suffixIcon: IconButton(
                                                      icon:  Icon(Icons.cancel,
                                                          size: 18,
                                                          color:
                                                          logic.cTxt3.value.isNotEmpty?
                                                          Color(0xffCCCCCC)
                                                              :Colors.transparent
                                                      ),
                                                      onPressed: () {
                                                        logic.controller3.text = '';
                                                      }),
                                                border: OutlineInputBorder(
                                                  borderRadius: BorderRadius.all(Radius.circular(5)),
                                                ),
                                                ///设置输入框可编辑时的边框样式
                                                enabledBorder: OutlineInputBorder(
                                                  ///设置边框四个角的弧度
                                                  borderRadius: BorderRadius.all(Radius.circular(5)),
                                                  ///用来配置边框的样式
                                                  borderSide: BorderSide(
                                                    ///设置边框的颜色
                                                    color: Color(0xffDDDDDD),
                                                    ///设置边框的粗细
                                                    width: 1.0,
                                                  ),
                                                ),
                                                ///用来配置输入框获取焦点时的颜色
                                                focusedBorder: OutlineInputBorder(
                                                  ///设置边框四个角的弧度
                                                  borderRadius: BorderRadius.all(Radius.circular(5)),
                                                  ///用来配置边框的样式
                                                  borderSide: BorderSide(
                                                    ///设置边框的颜色
                                                    color: AppTheme.themeHightColor,
                                                    ///设置边框的粗细
                                                    width: 1.0,
                                                  ),
                                                ),
                                              ),
                                              style: const TextStyle(
                                                  color: Colors.black,fontSize: 14),
                                              maxLength: 20,
                                              onChanged: logic.textFieldChanged,
                                              autofocus: false,
                                            ))
                                      ])),),
                                      Container(
                                          margin: EdgeInsets.only(top: 20),
                                          child: GestureDetector(
                                            onTap: () async {
                                              // if( logic.tab_show.value==1){
                                              //   logic.register_form(context);
                                              // }else{
                                              //   logic.register_phone_form(context);
                                              // }
                                              if (logic.tab_show.value == 1) {
                                                if (logic.controller.text == '') {
                                                  FToast.toast(context, msg: "请输入账号".tr);
                                                  return;
                                                }
                                                if (logic.controller2.text == '') {
                                                  FToast.toast(context, msg: "请输入密码".tr);
                                                  return;
                                                }
                                              } else {
                                                if(logic.controller.text==''){
                                                  FToast.toast(context, msg: "请输入手机号".tr);
                                                  return;
                                                }
                                                if(logic.controller2.text==''){
                                                  FToast.toast(context, msg: "请输入密码".tr);
                                                  return;
                                                }
                                              }
                                              if (logic.controller3.text == '') {
                                                FToast.toast(context, msg: "请输入邀请码".tr);
                                                return;
                                              }
                                              logic.post_tijiao();

                                              // Captcha_registerPage().show(context);

                                            },
                                            child: Container(
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(4),
                                                  color: AppTheme.themeHightColor),
                                              padding: EdgeInsets.only(
                                                  top: 14, bottom: 14),
                                              child: Center(
                                                  child: Text(
                                                '注册'.tr,
                                                style: TextStyle(
                                                    color: Colors.white,fontSize: 16),
                                              )),
                                            ),
                                          )),
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
                                                '已有账号？'.tr,
                                                style: TextStyle(),
                                              ),
                                            ),
                                            GestureDetector(
                                              onTap: () {
                                                Navigator.of(context)
                                                    .pushReplacementNamed(
                                                        "/login");
                                              },
                                              child: Text(
                                                '去登录'.tr,
                                                style: TextStyle(
                                                    color: Colors.blue),
                                              ),
                                            )
                                          ],
                                        ),
                                      )
                                    ])))))))
        ))
      )
    ;
  }
}
