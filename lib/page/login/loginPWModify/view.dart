import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../util/DefaultAppBar.dart';
import '../../../style/theme.dart';
import 'logic.dart';

class LoginPWModifyPage extends StatelessWidget {
  final logic = Get.put(LoginPWModifyLogic());

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
          // resizeToAvoidBottomInset: false, //解决键盘导致溢出页面
            backgroundColor: const Color(0xffffffff),
            appBar:
            DefaultAppBar(titleStr: '重置密码'.tr,),
            body:  SafeArea(
                        child: SingleChildScrollView(
                            child: Container(
                                margin:
                                const EdgeInsets.only(top: 1, bottom: 15,right: 15,left: 15),
                                child: Column(crossAxisAlignment: CrossAxisAlignment.start,children: [
                                  const SizedBox(height: 20),
                                  Container(
                                      margin: EdgeInsets.only(bottom: 10),
                                      child: Text(
                                        '原密码'.tr,
                                        style: TextStyle(color: Colors.black, fontSize: 14,),
                                        textAlign: TextAlign.left,
                                      )),
                                  Obx(() =>
                                      Container(
                                          height: 44,
                                          child: TextField(
                                            obscureText: true,
                                            controller: logic.controller,
                                            keyboardType: TextInputType.text,
                                            decoration: InputDecoration(
                                              contentPadding:
                                              EdgeInsets.symmetric(horizontal: 8, vertical: 10),
                                              hintText: '请输入原密码'.tr,
                                              hintStyle: TextStyle(color: Color(0xff999999)),
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
                                            style:
                                            const TextStyle(color: Colors.black, fontSize: 14),
                                            maxLength: 20,
                                            onChanged: logic.textFieldChanged,
                                            autofocus: false,
                                          )),
                                  ),

                                  const SizedBox(height: 20),
                                  Container(
                                      margin: EdgeInsets.only(bottom: 10),
                                      child: Text(
                                        '新密码'.tr,
                                        style: TextStyle(color: Colors.black, fontSize: 14,),
                                        textAlign: TextAlign.left,
                                      )),
                                  Obx(() =>
                                      Container(
                                          height: 44,
                                          child: TextField(
                                            obscureText: true,
                                            controller: logic.controller2,
                                            keyboardType: TextInputType.text,
                                            decoration: InputDecoration(
                                              contentPadding:
                                              EdgeInsets.symmetric(horizontal: 8, vertical: 10),
                                              hintText: '请输入新密码'.tr,
                                              hintStyle: TextStyle(color: Color(0xff999999)),
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
                                            style:
                                            const TextStyle(color: Colors.black, fontSize: 14),
                                            maxLength: 20,
                                            onChanged: logic.textFieldChanged,
                                            autofocus: false,
                                          )),
                                  ),

                                  const SizedBox(height: 20),
                                  Container(
                                      margin: EdgeInsets.only(bottom: 10),
                                      child: Text(
                                        '再次输入新密码'.tr,
                                        style: TextStyle(color: Colors.black, fontSize: 14,),
                                        textAlign: TextAlign.left,
                                      )),
                                  Obx(() =>
                                      Container(
                                          height: 44,
                                          child: TextField(
                                            obscureText: true,
                                            controller: logic.controller3,
                                            keyboardType: TextInputType.text,
                                            decoration: InputDecoration(
                                              contentPadding:
                                              EdgeInsets.symmetric(horizontal: 8, vertical: 10),
                                              hintText: '请再次输入新密码'.tr,
                                              hintStyle: TextStyle(color: Color(0xff999999)),
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
                                            style:
                                            const TextStyle(color: Colors.black, fontSize: 14),
                                            maxLength: 20,
                                            onChanged: logic.textFieldChanged,
                                            autofocus: false,
                                          )),
                                  ),

                                  Container(
                                    width: double.infinity,
                                    margin: EdgeInsets.only(top: 30),
                                    // padding: EdgeInsets.only(left: 15,right: 15),
                                    height: 44,
                                    child: MaterialButton(
                                      color: AppTheme.themeHightColor,
                                      minWidth: 50,
                                      padding:
                                      EdgeInsets.only(left: 25, right: 25),
                                      child:  Text(
                                        '提交'.tr,
                                        style: TextStyle(color: Colors.white),
                                      ),
                                      onPressed: () async {
                                        logic.resetLPW(context);
                                      },
                                    ),
                                  )
                                ])))));
  }
}
