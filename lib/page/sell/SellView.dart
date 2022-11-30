import 'dart:io';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ftoast/ftoast.dart';
import 'package:get/get.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';
import '../../../page/setting/bankList/view.dart';
import '../../style/theme.dart';
import '../../../widgets/button_widget.dart';
import '../../../widgets/text_widget.dart';

import '../../api/request/request.dart';

class SellView extends Dialog {
  List<String> choseTypes = ['按数量出售', '按类型出售'];
  var choseId = 0.obs;

  var inputMoney = 0.0.obs;

  late TextEditingController m_txtMoney = TextEditingController();
  SellView(
    // this.choseTypes,this.defalutType,
    this.userWallet,
    this.listModel,
  );

  String userWallet;
  var listModel;

  @override
  // TODO: implement backgroundColor
  Color? get backgroundColor => Colors.transparent;
  var result = {}.obs;

  @override
  Widget build(BuildContext context) {

    return WillPopScope(
      child: KeyboardDismisser(
          gestures: [
            GestureType.onTap,
            GestureType.onPanUpdateDownDirection,
          ],
          child: Center(
            // padding: EdgeInsets.only(top: 20),
            child: Container(
                // color: backgroundColor,//wrong
                width: double.maxFinite,
                height: 430, //540,
                // margin: EdgeInsets.only(left: 0,right: 0),
                padding: EdgeInsets.only(
                  left: 20,
                  right: 20,
                ),
                // padding: EdgeInsets.only(left: 30,top: 30,right: 30,bottom: 30),
                child: Column(
                  children: [
                    // Container(
                    //   // color: Colors.white,
                    //   // color: backgroundColor,//wrong
                    //   width: double.maxFinite,
                    //   height: 240,
                    //   // height: 115,
                    //   // padding: EdgeInsets.only(left: 30,top: 30,right: 30,bottom: 30),
                    //
                    //   decoration: BoxDecoration(
                    //     // color: backgroundColor,
                    //     // borderRadius: BorderRadius.only(
                    //     //     bottomRight: Radius.circular(8.0),
                    //     //     bottomLeft: Radius.circular(8.0)),
                    //     image: DecorationImage(
                    //         image:
                    //         AssetImage("assets/images/bgUpdateTop2.png",),
                    //         fit: BoxFit.fill,),
                    //   ),
                    // ),

                    Container(
                      // color: backgroundColor,//wrong
                      width: double.maxFinite,
                      // height: 230,
                      height: 430,
                      padding: EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(
                          Radius.circular(4.0),
                        ),
                        // borderRadius: BorderRadius.only(
                        //     bottomRight: Radius.circular(8.0),
                        //     bottomLeft: Radius.circular(8.0)),
                        // image: DecorationImage(
                        //     image:  AssetImage("assets/images/updateVBg.png"),
                        //     fit: BoxFit.fill,
                        //     repeat: ImageRepeat.noRepeat),
                        // ),
                      ),

                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            // color: Colors.white,
                            // color: backgroundColor,//wrong
                            width: double.maxFinite,
                            // height: 40,
                            child: Row(
                              children: <Widget>[
                                Expanded(
                                  child: Container(
                                    child: textContainer(
                                        text: 'CNY' + 'Ex'.tr,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        continerAlign: Alignment.centerLeft),
                                  ),
                                ),
                                Expanded(child: SizedBox()),
                                InkWell(
                                  hoverColor: Colors.transparent,
                                  onTap: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: Container(
                                    child: Row(
                                      children: [
                                        Container(
                                          alignment: Alignment.centerRight,
                                          child: textContainer(
                                              text: 'bbbbbbbbbbb',
                                              color: Colors.transparent,
                                              continerAlign:
                                                  Alignment.centerRight),
                                        ),
                                        Container(
                                          alignment: Alignment.centerRight,
                                          child: Icon(Icons.close_rounded,
                                              size: 20,
                                              color:
                                                  // logic.cTxt.value.isNotEmpty?
                                                  Colors.black
                                              // :Colors.transparent
                                              ),
                                        ),
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            ),
                            // padding: EdgeInsets.only(left: 30,top: 30,right: 30,bottom: 30),

                            //  decoration: BoxDecoration(
                            //   // color: backgroundColor,
                            //   // borderRadius: BorderRadius.only(
                            //   //     bottomRight: Radius.circular(8.0),
                            //   //     bottomLeft: Radius.circular(8.0)),
                            //   image: DecorationImage(
                            //       image:
                            //       AssetImage("assets/images/bgUpdateTop2.png",),
                            //       fit: BoxFit.fill,),
                            // ),
                          ),

                          Expanded(
                              child: Container(
                            width: double.infinity,
                            child: SingleChildScrollView(
                                physics: AlwaysScrollableScrollPhysics(
                                  parent: BouncingScrollPhysics(),
                                ),
                                child: Column(
                                  children: [
                                    SizedBox(
                                      height: 15,
                                    ),
                                    Container(
                                      alignment: Alignment.centerLeft,
                                      child: RichText(
                                        textAlign: TextAlign.left,
                                        text: TextSpan(
                                          text: '当前'.tr,
                                          style: TextStyle(
                                              height: 1,
                                              fontSize: 14,
                                              color: Colors.black),
                                          children: <TextSpan>[
                                            TextSpan(
                                              text: '1 ≈ ' +
                                                  '${listModel['rebate']}' +
                                                  ' Y',
                                              style: TextStyle(
                                                  height: 1.5,
                                                  fontSize: 14,
                                                  color:
                                                      AppTheme.themeHightColor),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Obx(() => Container(
                                          alignment: Alignment.topLeft,
                                          child: Wrap(
                                            alignment: WrapAlignment.start,
                                            spacing: 10,
                                            runSpacing: 10,
                                            children: List.generate(
                                                choseTypes.length, (i) {
                                              return Container(
                                                margin:
                                                    EdgeInsets.only(top: 10),
                                                child: Container(
                                                    width: 90,
                                                    height: 35,
                                                    margin: EdgeInsets.only(
                                                        right: 10),
                                                    child: GestureDetector(
                                                      onTap: () {
                                                        choseId.value = i;
                                                        m_txtMoney.text = choseId.value ==0? '':'';
                                                        inputMoney.value = 0.0;
                                                      },
                                                      child: Container(
                                                        decoration:
                                                            BoxDecoration(
                                                          color: choseId
                                                                      .value ==
                                                                  i
                                                              ? AppTheme
                                                                  .themeHightColor
                                                              : Color(
                                                                  0xffEEEEEE),

                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(4),
                                                          // // color: Color(0xff262C4A),
                                                          // border: Border.all(
                                                          //     color: choseId.value == i?AppTheme.themeHightColor:Color(0xffDDDDDD), width: 1)
                                                        ),
                                                        child: Stack(
                                                          children: [
                                                            Positioned(
                                                                // red box
                                                                right: -1,
                                                                bottom: -1,
                                                                child:
                                                                    // choseId.value == i?Container(
                                                                    //   child: Image.asset(
                                                                    //     'assets/images/public/positionTag.png',
                                                                    //     width: 23,
                                                                    //     height: 23,
                                                                    //   ),
                                                                    // ):
                                                                    Container()),
                                                            Center(
                                                                child: Text(
                                                              '${choseTypes[i]}'
                                                                  .tr,
                                                              style: TextStyle(
                                                                  color: choseId
                                                                              .value ==
                                                                          i
                                                                      ? Colors
                                                                          .white
                                                                      : Color(
                                                                          0xff333333),
                                                                  fontSize: 12),
                                                              // TextStyle(color: choseId.value == i?AppTheme.themeHightColor:Color(0xffAAAAAA)),
                                                            )),
                                                          ],
                                                        ),
                                                      ),
                                                    )),
                                              );
                                            }),
                                          ),
                                        )),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Obx(
                                      () => Container(
                                          height: 48,
                                          child: TextField(
                                            controller: m_txtMoney,
                                            // keyboardType: TextInputType.number,
                                            inputFormatters: [
                                              // FilteringTextInputFormatter.allow(RegExp('[0-9]')),
                                              FilteringTextInputFormatter.allow(
                                                  RegExp(r'[0-9.]'
                                                      r'')),
                                            ],
                                            decoration: InputDecoration(
                                              isCollapsed: true,
                                              // contentPadding: EdgeInsets.all(10),

                                              contentPadding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 17.0,
                                                      horizontal: 13),
                                              // filled: true,
                                              focusedBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: AppTheme
                                                        .themeHightColor,
                                                    width: 1.0),
                                              ),
                                              enabledBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Color(0xffDDDDDD),
                                                    width: 1.0),
                                              ),
                                              hintText: choseId.value == 0
                                                  ? '0.00'
                                                  : '0.00' ,
                                              hintStyle: TextStyle(
                                                  color: Color(0xff666B84)),
                                              border: InputBorder.none,
                                              counterText: '',
                                              suffixIcon: Container(
                                                width: 70,
                                                alignment:
                                                    Alignment.centerRight,
                                                child: RichText(
                                                  textAlign: TextAlign.center,
                                                  text: TextSpan(
                                                    text: '',
                                                    // choseId.value == 0?' ':' ',
                                                    //'${logic.dropdownValue.value}',
                                                    style: TextStyle(
                                                      color: Color.fromARGB(255, 153, 153, 153),
                                                      fontWeight: FontWeight.normal,
                                                      fontSize: 12,
                                                      inherit: true,
                                                    ),
                                                    children: <TextSpan>[
                                                      TextSpan(
                                                          text: '全部'.tr,
                                                          style: TextStyle(
                                                              color: AppTheme
                                                                  .themeHightColor,
                                                              decoration:
                                                                  TextDecoration
                                                                      .none),
                                                          recognizer:
                                                              TapGestureRecognizer()
                                                                ..onTap =
                                                                    () async {
                                                                  //这里做点击事件
                                                                  m_txtMoney
                                                                          .text =
                                                                      userWallet;
                                                                  inputMoney
                                                                          .value =
                                                                      double.parse(
                                                                          m_txtMoney
                                                                              .text);
                                                                  // SetMoney(m_txtMoney.text);
                                                                }),
                                                      TextSpan(
                                                        text: '     ',
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                            style: const TextStyle(
                                                color: Colors.black),
                                            // onChanged: logic.textFieldChanged,
                                            onChanged: (a) {
                                              inputMoney.value =
                                                  m_txtMoney.text.isNotEmpty
                                                      ? double.parse(
                                                          m_txtMoney.text)
                                                      : 0.0;
                                            },
                                            maxLength: 12,
                                            autofocus: false,
                                          )),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Container(
                                      alignment: Alignment.centerLeft,
                                      child: RichText(
                                        textAlign: TextAlign.left,
                                        text: TextSpan(
                                          text: '限额'.tr + ':' + '￥1 - ￥9999.99',
                                          style: TextStyle(
                                              height: 1,
                                              fontSize: 12,
                                              color: AppTheme.themeGreyColor),
                                          children: <TextSpan>[
                                            TextSpan(
                                              text: '\n' '当前'.tr ,
                                              style: TextStyle(
                                                  height: 2,
                                                  fontSize: 12,
                                                  color:
                                                      AppTheme.themeGreyColor),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Obx(
                                      () => Container(
                                        alignment: Alignment.centerLeft,
                                        child: RichText(
                                          textAlign: TextAlign.left,
                                          text: TextSpan(
                                            text: '可得'.tr +
                                                ':' +
                                                '￥' +
                                                '${(inputMoney.value * listModel['rebate']).toStringAsFixed(1)}',
                                            style: TextStyle(
                                                height: 1,
                                                color: Colors.black,
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold),
                                            children: <TextSpan>[
                                              TextSpan(
                                                text: '',
                                                style: TextStyle(
                                                    height: 2,
                                                    fontSize: 12,
                                                    color: AppTheme
                                                        .themeHightColor),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 32,
                                    ),
                                    Obx(
                                      () => InkWell(
                                        hoverColor: Colors.transparent,
                                        onTap: () async {
                                          result.value = await Get.to(
                                              BankListPage(),
                                              arguments: '1');
                                        },
                                        child: Container(
                                          child: Row(
                                            children: <Widget>[
                                              Expanded(
                                                child: Container(
                                                  child: textContainer(
                                                      text: '账户'.tr,
                                                      continerAlign:
                                                          Alignment.centerLeft),
                                                ),
                                              ),
                                              Expanded(child: SizedBox()),
                                              Container(
                                                child: Row(
                                                  children: [
                                                    Container(
                                                      alignment:
                                                          Alignment.centerRight,
                                                      child: textContainer(
                                                          text: result
                                                                  .isNotEmpty
                                                              ? result['phone']
                                                                  .toString()
                                                              : '${listModel['goodsNum']}',
                                                          color: AppTheme
                                                              .themeGreyColor,
                                                          continerAlign:
                                                              Alignment
                                                                  .centerRight),
                                                    ),
                                                    Container(
                                                      alignment:
                                                          Alignment.centerRight,
                                                      child: Icon(
                                                          Icons
                                                              .arrow_forward_ios,
                                                          color: AppTheme
                                                              .themeGreyColor,
                                                          size: 12),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                  ],
                                )),
                          )),

                          // syText(text: this.latestTitle,fontSize: 20,fontWeight: FontWeight.bold),

                          customFootFuncBtn(marginlr: 0, margintb: 0, '出售'.tr,
                              () {
                            postRequest();
                          }),
                          // Row(
                          //     mainAxisSize: MainAxisSize.min,
                          //     children: [
                          //       Visibility(child:
                          //       Container(
                          //         // alignment: Alignment.center,
                          //         // margin:
                          //         // const EdgeInsets
                          //         //     .only(
                          //         //     right: 10),
                          //         width: ScreenUtil().setWidth(118),
                          //         height: 40,
                          //         child:
                          //         OutlinedButton(
                          //           style: ButtonStyle(
                          //               shape: MaterialStateProperty.all(RoundedRectangleBorder(
                          //                   borderRadius:
                          //                   BorderRadius.circular(
                          //                       4))),
                          //               side: MaterialStateProperty
                          //                   .all(BorderSide(
                          //                   color: AppTheme.themeHightColor))),
                          //           child:  Text(
                          //             '暂不更新'.tr,
                          //             style: TextStyle(fontSize: 11,fontWeight: FontWeight.w400,
                          //                 color: AppTheme.themeHightColor),
                          //           ),
                          //           onPressed: () {
                          //             Navigator.of(context).pop();
                          //             // if(isFromHome)Get.offNamed('/index');
                          //             //no back,or backto login
                          //           },
                          //         ),
                          //
                          //       ),visible: true),
                          //
                          //
                          //
                          //
                          //
                          //     ]
                          //
                          // )
                        ],
                      ),
                    ),
                  ],
                )),
          )),
      onWillPop: () async {
        return true;
      },
    );
  }

  void postRequest() => request(() async {
        if (m_txtMoney.text.isEmpty) {
          FToast.toast(Get.context!, msg: '请输入'.tr);
          return;
        }
        // var data = await requestClient.post(APIS.vipRecharge,
        //     data:{
        //       'safeword':password,
        //       'level':listModel['id'],
        //       'valid_day':int.parse(listModel['validDay'].toString()).toString(),
        //       'amount':double.parse(listModel['prize'].toString()).toString()
        //     });
        FToast.toast(Get.context!, msg: '成功'.tr);
        // eventBus.fire(GrabRefreshHomeEvent("1"));
        Navigator.of(Get.context!).pop();
        Get.offNamed('/succ?path=2');
      });



  @override
  EdgeInsetsGeometry get contentPadding => EdgeInsets.all(0);
}
