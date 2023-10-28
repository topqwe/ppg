import 'dart:async';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';
import '../../../style/theme.dart';
import '../../../widgets/helpTools.dart';
import '../../../widgets/text_widget.dart';
import 'package:flutter/rendering.dart';
import 'package:tapped/tapped.dart';

import '../../../util/Country/countryChoosePage.dart';
import '../../../util/DefaultAppBar.dart';
import '../../../widgets/image_widget.dart';
import 'logic.dart';
import '/widgets/button_widget.dart';

class IdVerifyPage extends StatelessWidget {
  final logic = Get.put(IdVerifyLogic());

  getStateTxt() {
    String idState = "已认证".tr;
    if (logic.boolId.value == 0) {
      idState = "未认证".tr;
    } else if (logic.boolId.value == 1) {
      idState = "审核中".tr;
    } else if (logic.boolId.value == 3) {
      idState = "认证失败".tr;
    }
    return idState;
  }

  getStateImage() {
    String status = "assets/images/succeed.png";
    if (logic.boolId.value == 0) {
    } else if (logic.boolId.value == 1) {
      status = "assets/images/waiting.png";
    } else if (logic.boolId.value == 3) {
      status = "assets/images/failed.png";
    }
    return status;
  }

  _buildCountryPickerDropdownSoloExpanded() {
    return Container(
      padding: const EdgeInsets.only(left: 0, bottom: 5, top: 5),
      child: Tapped(
        child: Row(
          children: [
            SizedBox(
              width: 10,
            ),
            imageCircular(
                w: 16,
                h: 16,
                radius: 8,
                image:
                    'assets/images/country/${logic.m_countryiso.value.toLowerCase()}.png'),
            SizedBox(
              width: 10,
            ),
            Text(logic.m_countryiso.value,
              style: TextStyle(
              fontWeight: FontWeight.normal,
              fontSize: 14,
              inherit: true,
            ),),
            Expanded(child: SizedBox()),
            Icon(Icons.arrow_drop_down_outlined,
                size: 20,
                color:
                    // logic.cTxt.value.isNotEmpty?
                    Colors.black
                // :Colors.transparent
                ),
            // Icon(Icons.arrow_drop_down,
            //     size: 20,
            //     color:
            //     // logic.cTxt.value.isNotEmpty?
            //     Colors.black
            //   // :Colors.transparent
            // ),
            // Image.asset(
            //   "assets/images/login/down.png",
            //   width: 10,
            // ),
            SizedBox(
              width: 15,
            ),
          ],
        ),
        onTap: () {
          if (logic.boolCanEdit.value == 1) {
            pushCountryPage(Get.context!, () {
              logic.m_countryiso.value = m_gChooseIso;
              // setState(() {});
              ;
            }, () {});
          }
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return KeyboardDismisser(
        gestures: [
          GestureType.onTap,
          GestureType.onPanUpdateDownDirection,
        ],
        child: Scaffold(
            backgroundColor: Colors.white,
            // resizeToAvoidBottomInset: false, //解决键盘导致溢出页面
            appBar: DefaultAppBar(
              titleStr: '身份认证'.tr,
            ),
            body: SafeArea(
                child: Column(
              children: [
                Expanded(
                  child: ListView(
                    padding: EdgeInsets.only(left: 15, right: 15),
                    physics: AlwaysScrollableScrollPhysics(
                      parent: BouncingScrollPhysics(),
                    ),
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    children: <Widget>[
                      const SizedBox(height: 23),

                      Obx(
                        () => Visibility(
                            visible: logic.boolId.value != 0,
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      '身份认证'.tr,
                                      style: TextStyle(
                                          color: Colors.black, fontSize: 14),
                                    ),
                                    Expanded(child: SizedBox()),
                                    // Image.asset(getStateImage(),
                                    //     width: 16, fit: BoxFit.fitWidth
                                    //     // scale: 0.4,
                                    //     ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                      getStateTxt(),
                                      style: TextStyle(
                                          fontSize: 14, color: Colors.black),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 30,
                                )
                              ],
                            )),
                      ),

                      Container(
                          margin: EdgeInsets.only(bottom: 10),
                          child: Text(
                            '国籍'.tr,
                            style: TextStyle(color: Colors.black, fontSize: 14),
                          )),
                      Obx(
                        () => Container(
                            height: 48,
                            child: TextField(
                              readOnly: true,
                              // controller: logic.controller,
                              // keyboardType: TextInputType.number,
                              // inputFormatters: [
                              //   // FilteringTextInputFormatter.allow(RegExp('[0-9]')),
                              //   FilteringTextInputFormatter.allow(
                              //       RegExp(r'[0-9.]'
                              //       r'')),
                              // ],
                              decoration: InputDecoration(
                                prefixIcon:
                                    _buildCountryPickerDropdownSoloExpanded(),
                                isCollapsed: true,
                                contentPadding: EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 10),
                                // hintText: '请输入数量'.tr,
                                // hintStyle: TextStyle(color: Color(0xff999999)),
                                counterText: '',
                                // suffixIcon: IconButton(
                                //     icon:  Icon(Icons.cancel,
                                //         size: 18,
                                //         color:
                                //         logic.cTxt.value>0.0?
                                //         Color(0xffCCCCCC)
                                //             :Colors.transparent
                                //     ),
                                //     onPressed: () {
                                //       logic.cTxt.value = 0.0;
                                //       logic.controller.text = '';
                                //     }),
                                border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(5)),
                                ),

                                ///设置输入框可编辑时的边框样式
                                enabledBorder: OutlineInputBorder(
                                  ///设置边框四个角的弧度
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(5)),

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
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(5)),

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
                                  color: Colors.black, fontSize: 14),
                              maxLength: 12,
                              onChanged: logic.textFieldChanged,
                              autofocus: false,
                            )),
                      ),

                      const SizedBox(height: 20),
                      Container(
                          margin: EdgeInsets.only(bottom: 10),
                          child: Text(
                            '真实姓名'.tr,
                            style: TextStyle(color: Colors.black, fontSize: 14),
                          )),
                      Obx(
                        () => Container(
                            height: 48,
                            child: TextField(
                              readOnly: logic.boolCanEdit.value == 0,
                              controller: logic.controller0,
                              // keyboardType: TextInputType.number,
                              // inputFormatters: [
                              //   // FilteringTextInputFormatter.allow(RegExp('[0-9]')),
                              //   FilteringTextInputFormatter.allow(
                              //       RegExp(r'[0-9.]'
                              //       r'')),
                              // ],
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 10),
                                hintText: '请输入真实姓名'.tr,
                                hintStyle: TextStyle(color: Color(0xff999999)),
                                counterText: '',
                                suffixIcon: IconButton(
                                    icon: Icon(Icons.cancel,
                                        size: 18,
                                        color: logic.boolCanEdit.value == 1
                                            ? logic.cTxt0.value.isNotEmpty
                                                ? Color(0xffCCCCCC)
                                                : Colors.transparent
                                            : Colors.transparent),
                                    onPressed: () {
                                      logic.cTxt0.value = '';
                                      logic.controller0.text = '';
                                    }),
                                border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(5)),
                                ),

                                ///设置输入框可编辑时的边框样式
                                enabledBorder: OutlineInputBorder(
                                  ///设置边框四个角的弧度
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(5)),

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
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(5)),

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
                                  color: Colors.black, fontSize: 14),
                              maxLength: 12,
                              onChanged: logic.textFieldChanged,
                              autofocus: false,
                            )),
                      ),

                      const SizedBox(height: 20),
                      Container(
                          margin: EdgeInsets.only(bottom: 10),
                          child: Text(
                            '证件/护照号码'.tr,
                            style: TextStyle(color: Colors.black, fontSize: 14),
                          )),
                      Obx(
                        () => Container(
                            height: 48,
                            child: TextField(
                              readOnly: logic.boolCanEdit.value == 0,
                              controller: logic.controller,
                              // keyboardType: TextInputType.number,
                              inputFormatters: [
                                // FilteringTextInputFormatter.allow(RegExp('[0-9]')),
                                FilteringTextInputFormatter.allow(
                                    RegExp(r'[0-9.]'
                                        r'')),
                              ],
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 10),
                                hintText: '请输入证件/护照号码'.tr,
                                hintStyle: TextStyle(color: Color(0xff999999)),
                                counterText: '',
                                suffixIcon: IconButton(
                                    icon: Icon(Icons.cancel,
                                        size: 18,
                                        color: logic.boolCanEdit.value == 1
                                            ? logic.cTxt.value > 0.0
                                                ? Color(0xffCCCCCC)
                                                : Colors.transparent
                                            : Colors.transparent),
                                    onPressed: () {
                                      logic.cTxt.value = 0.0;
                                      logic.controller.text = '';
                                    }),
                                border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(5)),
                                ),

                                ///设置输入框可编辑时的边框样式
                                enabledBorder: OutlineInputBorder(
                                  ///设置边框四个角的弧度
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(5)),

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
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(5)),

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
                                  color: Colors.black, fontSize: 14),
                              maxLength: 30,
                              onChanged: logic.textFieldChanged,
                              autofocus: false,
                            )),
                      ),
                      const SizedBox(height: 20),

                      Container(
                          margin: EdgeInsets.only(bottom: 10),
                          child: Text(
                            '证件照/上传护照'.tr,
                            style: TextStyle(color: Colors.black, fontSize: 14),
                          )),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          imgButtonUpIcon(0),
                          imgButtonUpIcon(1),
                          imgButtonUpIcon(2),
                        ],
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Container(
                            width: 105,
                            child: Text(
                              '证件正面'.tr,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Color.fromARGB(255, 153, 153, 153),
                                fontWeight: FontWeight.normal,
                                fontSize: 12,
                                inherit: true,
                              ),
                            ),
                          ),
                          Container(
                            width: 105,
                            child: Text(
                              '证件反面'.tr,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Color.fromARGB(255, 153, 153, 153),
                                fontWeight: FontWeight.normal,
                                fontSize: 12,
                                inherit: true,
                              ),
                            ),
                          ),
                          Container(
                            width: 105,
                            child: Text(
                              '手持证件照'.tr,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Color.fromARGB(255, 153, 153, 153),
                                fontWeight: FontWeight.normal,
                                fontSize: 12,
                                inherit: true,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Obx(
                        () => Visibility(
                          child: Column(
                            children: [
                              textContainer(
                                  text: "拍摄示例".tr,
                                  continerAlign: Alignment.centerLeft),
                              // imageCircular(
                              //     w: MediaQuery.of(Get.context!).size.width,
                              //     h: 120,
                              //     radius: 4,
                              //     image: "assets/images/uploadDemo.png",
                              //     fit: BoxFit.fitWidth),
                              const SizedBox(height: 15),
                              customFootFuncBtn(
                                  marginlr: 0,
                                  logic.boolId == 3 ? "重新申请".tr : "申请认证".tr,
                                  () {
                                logic.postform(context);
                              }),
                            ],
                          ),
                          visible: logic.boolCanEdit.value == 1,
                        ),
                      ),
                      // Visibility(child: txtdes(context),visible: logic.boolCanEdit.value == 1,) ,
                    ],
                  ),
                )
              ],
            ))));
  }

  Widget imgButtonUpIcon(int id) {
    double itemHeight = 100;
    double itemWidth = 100;
    // MediaQuery.of(Get.context!).size.width-30;
    // String strurl = (m_picRecharge)!;
    String strurl = '';
    var pic;
    String urlPath = '';
    Widget defImage = Container(
      width: itemWidth,
      height: itemHeight,
      child: Image.asset(
        "assets/images/public/imageUpload.png",
        // width: itemWidth,
        // height: itemHeight,
        fit: BoxFit.fill,
      ),
    );
    if (strurl == "") {
      pic = id == 0
          ? Container(
              child: Obx(() => logic.image0.value == ''
                  ? defImage
                  : ExtendedImage.network(
                      '$urlPath${logic.image0.value}',
                      fit: BoxFit.cover,
                      height: itemHeight,
                      width: itemWidth,
                    )),
            )
          : id == 1
              ? Container(
                  child: Obx(() => logic.image1.value == ''
                      ? defImage
                      : ExtendedImage.network(
                          '$urlPath${logic.image1.value}',
                          fit: BoxFit.cover,
                          height: itemHeight,
                          width: itemWidth,
                        )),
                )
              : Container(
                  child: Obx(() => logic.image2.value == ''
                      ? defImage
                      : ExtendedImage.network(
                          '$urlPath${logic.image2.value}',
                          fit: BoxFit.cover,
                          height: itemHeight,
                          width: itemWidth,
                        )),
                );
    } else {
      pic = Image.network(
        strurl,
        fit: BoxFit.fitWidth,
      );
    }

    return Tapped(
        onTap: () {
          if (logic.boolCanEdit.value == 1) logic.getImage(id);
        },
        child: Container(
            width: itemWidth,
            height: itemHeight,
            // decoration: BoxDecoration(
            //     color: Colors.white,
            //     image: DecorationImage(
            //         image: Image.network(""), fit: BoxFit.fitWidth)),
            alignment: Alignment.centerLeft,
            child: pic));
  }
}
