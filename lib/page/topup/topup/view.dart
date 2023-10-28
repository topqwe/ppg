import 'dart:async';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ftoast/ftoast.dart';
import 'package:get/get.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';
import 'package:share_plus/share_plus.dart';
import '../../../style/theme.dart';

import 'dart:ui' as ui;
import 'package:qr_flutter/qr_flutter.dart';
import 'package:flutter/rendering.dart';
import 'package:tapped/tapped.dart';

import '../../../util/DefaultAppBar.dart';
import '../../../widgets/text_widget.dart';
import 'logic.dart';
import '/widgets/button_widget.dart';

class TopupPage extends StatelessWidget {
  final logic = Get.put(TopupLogic());

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
              titleStr: ''.tr,
            ),
            body: SafeArea(
              child: ListView(
                padding: EdgeInsets.only(left: 15, right: 15),
                physics: BouncingScrollPhysics(),
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                children: <Widget>[
                  const SizedBox(height: 20),
                  Container(
                      child: Text(
                    '选择'.tr,
                    style: TextStyle(color: Colors.black, fontSize: 14),
                  )),
                  Obx(() => Container(

                        child: Wrap(
                          spacing: 10,
                          runSpacing: 10,
                          children: List.generate(
                              logic.choseDatas.length, (i) {
                            return Container(
                              margin: EdgeInsets.only(top: 10),
                              child: Container(
                                  width: 105,
                                  height: 44,
                                  margin: EdgeInsets.only(right: 10),
                                  child: GestureDetector(
                                    onTap: () {
                                      logic.showData.value =
                                          logic.choseDatas[i];
                                      logic.depositFee.value = logic
                                          .showData['fee'];
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(4),
                                          // color: Color(0xff262C4A),
                                          border: Border.all(
                                              color: logic.showData[
                                                          'id'] ==
                                                      logic.choseDatas[
                                                          i]['id']
                                                  ? AppTheme.themeHightColor
                                                  : Color(0xffDDDDDD),
                                              width: 1.5)),
                                      child: Stack(
                                        children: [
                                          Positioned(
                                              // red box
                                              right: -1,
                                              bottom: -1,
                                              child: logic.showData[
                                                          'id'] ==
                                                      logic.choseDatas[
                                                          i]['id']
                                                  ?
                                              Container()
                                              // Container(
                                              //         child: Image.asset(
                                              //           'assets/images/public/positionTag.png',
                                              //           width: 23,
                                              //           height: 23,
                                              //         ),
                                              //       )
                                                  : Container()),
                                          Center(
                                              child: Text(
                                            '${logic.choseDatas[i]['blockchain_name']}',
                                            style: TextStyle(
                                                color: logic.showData[
                                                            'id'] ==
                                                        logic.choseDatas[
                                                            i]['id']
                                                    ? AppTheme.themeHightColor
                                                    : Color(0xffAAAAAA)),
                                          )),
                                        ],
                                      ),
                                    ),
                                  )),
                            );
                          }),
                        ),
                      )),
                  Obx(() => Container(
                    height: 48,
                    alignment: Alignment.centerLeft,
                    width: double.infinity,
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    decoration: BoxDecoration(
                      border: Border.all(color: Color(0xffDDDDDD), width: 1),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: DropdownButton<String>(
                      //   focusColor: Colors.yellow,
                        itemHeight: 48,
                        isExpanded: true,
                        value: '${logic.showData['id']}',
                        icon: const Icon(
                          Icons.keyboard_arrow_down,
                          size: 20,
                        ),
                        elevation: 8,
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.normal,
                          fontSize: 14,
                          inherit: true,
                        ),
                        underline: Container(
                          height: 0,
                          color: AppTheme.themeGreyColor,
                        ),
                        onChanged: (newValue) {
                          print(newValue);
                          for (var i = 0;
                          i < logic.choseDatas.length;
                          i++) {
                            if (logic.choseDatas[i]['id'] ==
                                newValue) {
                              logic.showData.value =
                              logic.choseDatas[i];
                            }
                          }
                        },
                        // items: <String>[
                        //   'SB',
                        //   'ST',
                        // ].map<DropdownMenuItem<String>>((String value) {
                        //   return DropdownMenuItem<String>(
                        //     value: value,
                        //     child: Text(value),
                        //   );
                        // }).toList()),

                        items: logic.choseDatas
                            .map<DropdownMenuItem<String>>((value) {
                          return DropdownMenuItem<String>(
                            value: value['id'],
                            child: Text(value['blockchain_name']),
                          );
                        }).toList()),

                  )),
                  const SizedBox(height: 30),
                  Obx(() => codeImage()),
                  const SizedBox(height: 30),
                  Container(
                      margin: EdgeInsets.only(bottom: 10),
                      child: Text(
                        '地址'.tr,
                        style: TextStyle(color: Colors.black, fontSize: 14),
                      )),
                  Container(
                    width: double.infinity,
                    height: 48,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                      border: Border.all(
                        style: BorderStyle.solid,
                        color: Color(0xffDDDDDD),
                        width: 1,
                      ),
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 15,
                        ),
                        Expanded(
                            child: Obx(() => Text(
                                  '${logic.showData['address']}',
                                  softWrap: false,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontSize: 14,
                                  ),
                                ))),
                        GestureDetector(
                            onTap: () {
                              Clipboard.setData(ClipboardData(
                                  text: logic
                                      .showData['address']));
                              FToast.toast(context, msg: "复制成功".tr);
                            },
                            child: Container(
                                margin: EdgeInsets.only(right: 15, left: 15),
                                child: Text('复制'.tr,
                                    style: TextStyle(
                                        color: Color(0xff4AA8FF),
                                        fontSize: 14))))
                      ],
                    ),
                  ),

                      Container(
                    margin: EdgeInsets.only(top: 20),
                    child: Obx(() =>logic
                        .showData.isEmpty?Container(): ultimatelyLRCopyTxtFixedRWidth(
                        textl: '地址'.tr,
                        textr: logic
                            .showData['address'],
                        rWidth: 235,
                        onPressed: () {
                          FToast.toast(context, msg: "复制成功".tr);
                          Clipboard.setData(ClipboardData(
                              text: logic
                                  .showData['address']));
                        }),
                  )),
                  const SizedBox(height: 20),
                  Container(
                      margin: EdgeInsets.only(bottom: 10),
                      child: Text(
                        '数量'.tr,
                        style: TextStyle(color: Colors.black, fontSize: 14),
                      )),
                  Obx(
                    () => Container(
                        height: 48,
                        child: TextField(
                          controller: logic.controller,
                          // keyboardType: TextInputType.number,
                          inputFormatters: [
                            // FilteringTextInputFormatter.allow(RegExp('[0-9]')),
                            FilteringTextInputFormatter.allow(RegExp(r'[0-9.]'
                                r'')),
                          ],
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 8, vertical: 10),
                            hintText: '请输入数量'.tr,
                            hintStyle: TextStyle(color: Color(0xff999999)),
                            counterText: '',
                            suffixIcon: IconButton(
                                icon: Icon(Icons.cancel,
                                    size: 18,
                                    color: logic.cTxt.value > 0.0
                                        ? Color(0xffCCCCCC)
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
                          maxLength: 12,
                          onChanged: logic.textFieldChanged,
                          autofocus: false,
                        )),
                  ),
                  const SizedBox(height: 20),
                  Container(
                    margin: EdgeInsets.only(bottom: 10),
                    child: Obx(() => Text(

                              '1:${(logic.depositFee)}',
                          style: TextStyle(color: Colors.black, fontSize: 14),
                        )),
                  ),
                  Container(
                    width: double.infinity,
                    height: 48,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                      border: Border.all(
                        style: BorderStyle.solid,
                        color: Color(0xffDDDDDD),
                        width: 1,
                      ),
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 15,
                        ),
                        Expanded(
                            child: Obx(() => Text(
                                  '${(logic.depositFee * (logic.cTxt.value)).toStringAsFixed(2)}',
                                  softWrap: false,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontSize: 14,
                                  ),
                                ))),
                        GestureDetector(
                            onTap: () {

                            },
                            child: Container(
                                margin: EdgeInsets.only(right: 15, left: 15),
                                child: Text('SB',
                                    style: TextStyle(fontSize: 14))))
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  Container(
                      margin: EdgeInsets.only(bottom: 10),
                      child: Text(
                        '上传图片'.tr,
                        style: TextStyle(color: Colors.black, fontSize: 14),
                      )),
                  Container(
                    child: imgButtonUpIcon(
                        context, "assets/images/public/imageUpload.png", 0),
                    alignment: Alignment.centerLeft,
                  ),
                  const SizedBox(height: 15),
                  customFootFuncBtn(marginlr: 0, '提交'.tr, () {
                    logic.postform(context);
                  }),
                ],
              ),
            )));
  }

  Widget codeImage() {
String linkString = '${logic.showData['address']}';
    return  Container(
            width: double.infinity,

            alignment: Alignment.center,
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[

                  RepaintBoundary(
                      key: logic.repaintKey,
                      child: Container(
                        height: 150,
                        width: 150,
                        color: Colors.white,
                        child: QrImageView(
                          data: linkString,
                          dataModuleStyle:  QrDataModuleStyle(
                            dataModuleShape: QrDataModuleShape.square,
                            color: Colors.black,
                          ),
                          size: 132,
                        ),
                      )),
                  Container(height: 9),
                  customFootFuncBtn(marginlr:0,'分享'.tr, (){
                    Share.share(linkString, subject: '');
                  }),

                  customFootFuncBtn(marginlr:0,margintb: 0,'保存'.tr, (){
                    logic.getPerm();
                  }),
                  ButtonBordor(
                      text: ('保存'.tr),
                      onPressed: () {
                        logic.getPerm();
                      },
                      w: 114,
                      h: 40,
                      bordercolor: Color(0xffDDDDDD),),


                ]));

  }

  Widget imgButtonUpIcon(BuildContext context, String img, int id) {

    var pic;
      pic = Container(
        child: Obx(() => logic.image2 == ''
            ? Image.asset(img)
            : ExtendedImage.network(
                    '${logic.image2}',
                fit: BoxFit.cover,
                height: 88,
                width: 88,
              )),
      );


    return Tapped(
        onTap: () {
          logic.getImage();
        },
        child: Container(
            width: 100.0,
            height: 100.0,
            // decoration: BoxDecoration(
            //     color: Colors.white,
            //     image: DecorationImage(
            //         image: Image.network(""), fit: BoxFit.fitWidth)),
            alignment: Alignment.centerLeft,
            child: pic));
  }
}
