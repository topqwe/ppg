import 'dart:io';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:ftoast/ftoast.dart';
import 'package:get/get.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';

import '../../../widgets/button_widget.dart';
import '../../../widgets/text_widget.dart';
import '../../services/responseHandle/request.dart';


class AuthView extends Dialog {
  AuthView(
    this.boolSafeword,
    this.boolId,
  );

  var boolSafeword;
  var boolId;

  @override
  // TODO: implement backgroundColor
  Color? get backgroundColor => Colors.transparent;

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
                height: 380 - 10 - 60, //540,
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
                        height: 310 - 10,
                        padding: EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(
                            Radius.circular(4.0),
                          ),
                        ),
                        child: Stack(
                          alignment: Alignment(0, 0), //居中对齐
                          children: <Widget>[
                            Positioned(
                              top: 5,
                              child: Column(
                                children: <Widget>[
                                  syText(
                                      text: '温馨提示'.tr,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xff000000)),
                                  // Container(
                                  //   child: Image.asset(
                                  //     'assets/images/bottom/Slice2.png',
                                  //     width: double.infinity,
                                  //     height: 112,
                                  //   ),
                                  //   width: double.infinity,
                                  //   height: 112,
                                  // ),
                                ],
                              ),
                            ),
                            Positioned(
                                top: 0,
                                right: 0,
                                child:
                                    // IconButton(
                                    //   iconSize: 30,
                                    //   padding: EdgeInsets.only(right: 0,top: 0),
                                    //   alignment: Alignment.centerRight,
                                    //
                                    //   icon: Icon(Icons.close,size: 30,),
                                    //   onPressed: () {
                                    //     Navigator.of(context).pop();
                                    //   },
                                    // ),),
                                    GestureDetector(
                                  child: Container(
                                    width: 100, height: 100,
                                    color: Colors.white,
                                    alignment: Alignment.topRight,
                                    // padding: EdgeInsets.only(right: 0,top: 0),
                                    margin:
                                        const EdgeInsets.only(right: 0, top: 3),
                                    child: Icon(
                                      Icons.close,
                                      color: Colors.black,
                                    ),
                                  ),
                                  onTap: () {
                                    Navigator.of(context).pop();
                                  },
                                )),
                            Container(
                                margin: EdgeInsets.only(top: 50), //112
                                child: Container(
                                    // padding: EdgeInsets.only(left: 15,right: 15),
                                    color: Colors.white,
                                    child: Column(
                                      children: <Widget>[
                                        Expanded(
                                            child: Container(
                                          width: double.infinity,
                                          child: SingleChildScrollView(
                                              // physics: AlwaysScrollableScrollPhysics(
                                              //   parent: BouncingScrollPhysics(),
                                              // ),
                                              child: Column(
                                            children: [
                                              // SizedBox(height: 15,),
                                              syText(
                                                  text: '为了保障您的账户取款安全,您需要完善信息'
                                                          .tr +
                                                      ':'),

                                              SizedBox(
                                                height: 27,
                                              ),
                                              ultimatelyLRForwardTxt(
                                                  textl: '设置交易密码'.tr,
                                                  lColor: Colors.black,
                                                  textr: boolSafeword == 1
                                                      ? '已完成'
                                                      : '未设置',
                                                  rColor: boolSafeword == 1
                                                      ? Colors.green
                                                      : Colors.black,
                                                  onPressed: () {
                                                    if (boolSafeword == 0) {
                                                      Get.back();
                                                      Get.toNamed(
                                                          "/setFPW");
                                                    }
                                                  }),

                                              SizedBox(
                                                height: 39,
                                              ),
                                              ultimatelyLRForwardTxt(
                                                  textl: '身份认证'.tr,
                                                  lColor: Colors.black,
                                                  textr: boolId == 1
                                                      ? '已完成'
                                                      : '未设置',
                                                  rColor: boolId == 1
                                                      ? Colors.green
                                                      : Colors.black,
                                                  onPressed: () {
                                                    // if(boolId==0){
                                                    Get.back();
                                                    Get.toNamed('/idVerify');
                                                    // }
                                                  }),
                                            ],
                                          )),
                                        )),
                                        Container(
                                          width: double.infinity,
                                          height: 32,
                                        ),
                                        customFootFuncBtn(
                                            marginlr: 0,
                                            margintb: 0,
                                            '立即完善'.tr, () {
                                          if (boolSafeword == 1 &&
                                              boolId == 1) {
                                            Get.back();
                                            // Get.toNamed('/transaction_record');
                                          }
                                        }),
                                      ],
                                    ))),
                          ],
                        )

                        //   Column(
                        //
                        //     crossAxisAlignment: CrossAxisAlignment.center,
                        //     children: [
                        //       Container(
                        //         // color: Colors.white,
                        //         // color: backgroundColor,//wrong
                        //         width: double.maxFinite,
                        //         // height: 40,
                        //         child: Row(
                        //             crossAxisAlignment:
                        //             CrossAxisAlignment.center,
                        //             children: [
                        //               Expanded(
                        //                   flex: 1, child: Container()),
                        //               Container(
                        //                 margin:
                        //                 EdgeInsets.only(right: 12),
                        //                 child: Image.asset(
                        //                     'assets/images/home/bonusLeftLine.png',
                        //                     width: 50,
                        //                     height: 1,fit: BoxFit.fill,),
                        //               ),
                        //               Container(
                        //                   child: Text('Hi~'+'初次见面'.tr,
                        //                       style: TextStyle(
                        //                           color:
                        //                           AppTheme.themeGreyColor,
                        //                           fontSize: 17))),
                        //               Container(
                        //                 margin:
                        //                 EdgeInsets.only(left: 12),
                        //                 child: Image.asset(
                        //                     'assets/images/home/bonusRightLine.png',
                        //                     width: 50,
                        //                     height: 1,fit: BoxFit.fill,),
                        //               ),
                        //               Expanded(
                        //                   flex: 1, child: Container()),
                        //             ]),
                        //
                        //         // padding: EdgeInsets.only(left: 30,top: 30,right: 30,bottom: 30),
                        //
                        //         //  decoration: BoxDecoration(
                        //         //   // color: backgroundColor,
                        //         //   // borderRadius: BorderRadius.only(
                        //         //   //     bottomRight: Radius.circular(8.0),
                        //         //   //     bottomLeft: Radius.circular(8.0)),
                        //         //   image: DecorationImage(
                        //         //       image:
                        //         //       AssetImage("assets/images/bgUpdateTop2.png",),
                        //         //       fit: BoxFit.fill,),
                        //         // ),
                        //       ),
                        //
                        //
                        //       Expanded(child: Container(
                        //         width: double.infinity,
                        //         child: SingleChildScrollView(
                        //           // physics: AlwaysScrollableScrollPhysics(
                        //           //   parent: BouncingScrollPhysics(),
                        //           // ),
                        //           child:
                        //           Column(children: [
                        //             SizedBox(height: 15,),
                        //             syText(text: '新人专属奖励'.tr,fontSize:28,fontWeight: FontWeight.bold ),
                        //
                        //             SizedBox(height: 15,),
                        //           Container(
                        //             // color: backgroundColor,//wrong
                        //             // width: 280,
                        //             // height: 230,
                        //             height: 100,
                        //
                        //             // padding: EdgeInsets.all(20),
                        //             decoration: BoxDecoration(
                        //               color: Colors.white,
                        //               borderRadius: BorderRadius.all(
                        //                 Radius.circular(0.0),),
                        //               // borderRadius: BorderRadius.only(
                        //               //     bottomRight: Radius.circular(8.0),
                        //               //     bottomLeft: Radius.circular(8.0)),
                        //               image: DecorationImage(
                        //                   image:  AssetImage("assets/images/home/homeNew.png"),
                        //                   fit: BoxFit.fill,
                        //                   repeat: ImageRepeat.noRepeat),
                        //               ),
                        //             child:
                        //             Container(
                        //               padding: EdgeInsets.only(left: 12,right: 24,top: 12),
                        //               child:
                        //             Row(children: [
                        //               textContainer(text: '已存'.tr,color: Colors.white,continerAlign: Alignment.centerLeft),
                        //               Expanded(child: SizedBox()),
                        //               Container(
                        //                 padding: EdgeInsets.only(right: 12),
                        //                 alignment: Alignment.centerRight,
                        //                 child: RichText(
                        //                   textAlign: TextAlign.right,
                        //                   text: TextSpan(
                        //                     text: boolId == 1?'yij':'wei',
                        //                     style: TextStyle(height: 1,
                        //                         fontSize: 24,
                        //                         color: Colors.black,fontWeight: FontWeight.bold),
                        //                     children: <TextSpan>[
                        //                       TextSpan(
                        //                         text: '\n',
                        //                         style: TextStyle(height: 1.5,
                        //                             fontSize: 17,
                        //                             color: Colors.black,fontWeight: FontWeight.normal),
                        //                       ),
                        //
                        //                     ],
                        //                   ),
                        //                 ),
                        //               ),
                        //
                        //             ],),),
                        //             ),
                        //
                        //
                        //
                        //
                        //             SizedBox(height: 13,),
                        //
                        //
                        //           ],)
                        //
                        //
                        //         ),
                        //       )),
                        //
                        //
                        // customFootFuncBtn(marginlr:0,margintb:0,'查看'.tr, (){
                        //   Get.back();
                        //   Get.toNamed('/transaction_record');
                        //
                        //       }),
                        //
                        //     ],
                        //   ),

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
        // var data = await requestClient.post(APIS.vipRecharge,
        //     data:{
        //       'safeword':password,
        //       'level':listModel['id'],
        //       'valid_day':int.parse(listModel['validDay'].toString()).toString(),
        //       'amount':double.parse(listModel['prize'].toString()).toString()
        //     });
        FToast.toast(Get.context!, msg: '成功'.tr);
        Navigator.of(Get.context!).pop();
        Get.offNamed('/succ?path=2');
      });



  @override
  EdgeInsetsGeometry get contentPadding => EdgeInsets.all(0);
}
