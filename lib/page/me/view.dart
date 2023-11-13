import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../router/RouteConfig.dart';
import '../../../widgets/sizebox_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../style/theme.dart';
import '../../util/RiseNumberText.dart';
import '../../widgets/button_widget.dart';
import '../../widgets/helpTools.dart';
import '../../widgets/image_widget.dart';
import 'AuthView.dart';
import 'logic.dart';

class MePage extends StatelessWidget {
  final logic = Get.put(MeLogic());

  Widget headItemContainer(String txt0, String txt1) {
    return Container(
      alignment: Alignment.centerLeft,
      child: RichText(
        textAlign: TextAlign.left,
        text: TextSpan(
          text: txt0,
          style: TextStyle(fontSize: 20, height: 1.5, color: Colors.black),
          children: [
            TextSpan(
              text: '\n' + txt1,
              style: TextStyle(fontSize: 12, color: AppTheme.themeGreyColor),
            ),
            WidgetSpan(
                child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 3.0, vertical: 3),
                    child: Icon(Icons.arrow_forward_ios,
                        color: Color(0xff999999), size: 12))),
          ],
        ),
      ),
    );
  }

  Widget cellForRow() {
    var size = MediaQuery.of(Get.context!).size;
    double itemWidth = (size.width - 4 * 15) / 3;

    return
        // Padding(
        //     padding: const EdgeInsets.only(left: 0, right: 0),
        //     child:
        Container(
      // margin: const EdgeInsets.only(left: 15, right: 15),
      child: Row(mainAxisAlignment: MainAxisAlignment.start, children: <Widget>[
        GestureDetector(
          onTap: () {
            Get.toNamed('/statRecord');
          },
          child: Container(
            width: itemWidth,
            child: headItemContainer('${logic.mb.value}', 'A'.tr),
          ),
        ),

        // Expanded(child: SizedBox()),
        GestureDetector(
          onTap: () {
            Get.toNamed('/stickyRecord');
          },
          child: Container(
            width: itemWidth,
            child: headItemContainer('${logic.mb.value}', 'B'.tr),
          ),
        ),
        // Expanded(child: SizedBox()),
        Visibility(
          child: Container(
            width: itemWidth,
            child: headItemContainer('', 'B'.tr),
          ),
          visible: false,
        ),
      ]),
    )
        // )
        ;
  }

  @override
  Widget build(BuildContext context) {

    var size = MediaQuery.of(Get.context!).size;
    double itemWidth = (size.width - 2 * 15 - 10) / 2;
    return Scaffold(
      backgroundColor: Colors.white,
      body:
          // SafeArea(
          //     child:


          // SingleChildScrollView(
          //     child:

      ListView(children: [

        Column(children: [
        Container(
            width: double.infinity,
            // height: 287,
            decoration: const BoxDecoration(
              // borderRadius: BorderRadius.all(
              //   Radius.circular(6),
              // ),
              // image: DecorationImage(
              //   image: AssetImage("assets/images/meHeaderBg.png"),
              //   fit: BoxFit.cover,
              // ),
            ),
            child: Column(children: <Widget>[
              Container(
                  margin: const EdgeInsets.only(left: 19, right: 19, top: 60),
                  child: headInfoView(context)),
              Container(
                  margin: const EdgeInsets.only(top: 30),
                  // height: 150,
                  padding: const EdgeInsets.only(left: 15, right: 15),
                  width: double.infinity,
                  child: IntrinsicHeight(
                      child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                          flex: 1,
                          child: Container(
                              child: Container(
                                  padding: const EdgeInsets.only(
                                      left: 15, right: 15, top: 15, bottom: 15),
                                  decoration: const BoxDecoration(
                                    gradient: LinearGradient(colors: [
                                      Color(0xffffffff),
                                      Color(0xffffffff),
                                      Color(0xffffffff),
                                      Color(0xffffffff),
                                    ]), // 渐变色
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(6),
                                    ),
                                    boxShadow: [
                                      BoxShadow(
                                        blurRadius: 2,
                                        //阴影范围
                                        spreadRadius: 1,
                                        //阴影浓度
                                        offset: Offset(0.0, 5.0),
                                        //阴影y轴偏移量
                                        color: Color(0xffEAEDF3), //阴影颜色
                                      ),
                                    ],
                                  ),
                                  child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        //  Text(
                                        //   'Bl'.tr,
                                        //   style:
                                        //       TextStyle(fontSize: 14),
                                        // ),
                                        Container(
                                            // margin:
                                            //     const EdgeInsets.only(
                                            //         top: 16),
                                            // padding:
                                            //     const EdgeInsets.only(
                                            //         bottom: 15),
                                            child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                Obx(() =>_AccountMoney(
                                                    title: 'Bl',
                                                    money: '${logic.ma.value}',
                                                    alignment: MainAxisAlignment.end,
                                                    moneyTextStyle: TextStyle(color: Colors.black, fontSize: 32.0, fontWeight: FontWeight.bold, fontFamily: 'RobotoThin'),
                                                  ),),
                                              Obx(() => Expanded(
                                                  flex: 1,
                                                  child: RichText(
                                                    // textAlign: TextAlign.right,
                                                    text: TextSpan(
                                                      text:
                                                          '${logic.ma.value}',
                                                      style: TextStyle(
                                                          color: Colors.black,
                                                          fontSize: 30,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                      children: [
                                                        TextSpan(
                                                          text: '\n' 'Bl'.tr ,
                                                          style: TextStyle(
                                                              fontSize: 12,
                                                              height: 1.5,
                                                              color: AppTheme
                                                                  .themeGreyColor,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .normal),
                                                        ),
                                                        // TextSpan(
                                                        //     text: '\n${logic.ma.value}',
                                                        //     style: TextStyle(
                                                        //         color: Colors
                                                        //             .black,
                                                        //         fontSize:
                                                        //             24)),
                                                        WidgetSpan(
                                                            child: GestureDetector(
                                                                onTap: () {
                                                                  logic.requestMoney(
                                                                      true);
                                                                },
                                                                child: RotationTransition(
                                                                    turns: logic.turns,
                                                                    child: Padding(
                                                                      padding: EdgeInsets.symmetric(
                                                                        vertical: 2,
                                                                          horizontal:
                                                                              6.0),
                                                                      child:
                                                                          Icon(
                                                                        Icons
                                                                            .loop,
                                                                        color: Color(
                                                                            0xffAAAAAA),
                                                                        size:
                                                                            20,
                                                                      ),
                                                                    ))))
                                                      ],
                                                    ),
                                                  ))),

                                              // Expanded(
                                              //     flex: 1,
                                              //     child:
                                              Visibility(
                                                child: Container(
                                                    // alignment: Alignment.centerRight,
                                                    //   margin:
                                                    //   const EdgeInsets
                                                    //       .only(
                                                    //       right: 10),
                                                    width: 180,
                                                    height: 34,
                                                    child: Row(
                                                      children: [
                                                        Container(
                                                          // alignment: Alignment.center,
                                                          // margin:
                                                          // const EdgeInsets
                                                          //     .only(
                                                          //     right: 10),
                                                          width: 85,
                                                          height: 34,
                                                          child: OutlinedButton(
                                                            style: ButtonStyle(
                                                                shape: MaterialStateProperty.all(RoundedRectangleBorder(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            4))),
                                                                side: MaterialStateProperty
                                                                    .all(BorderSide(
                                                                        color: AppTheme
                                                                            .themeHightColor))),
                                                            child: Text(
                                                              'C'.tr,
                                                              style: TextStyle(
                                                                  fontSize: 11,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w400,
                                                                  color: AppTheme
                                                                      .themeHightColor),
                                                            ),
                                                            onPressed: () {
                                                              Get.toNamed(
                                                                  '/index');
                                                            },
                                                          ),
                                                        ),
                                                        Container(
                                                          width: 10,
                                                        ),
                                                        Container(
                                                          // alignment: Alignment.center,
                                                          // margin:
                                                          // const EdgeInsets
                                                          //     .only(
                                                          //     right: 10),
                                                          width: 85,
                                                          height: 34,
                                                          child: MaterialButton(
                                                            color: AppTheme
                                                                .themeHightColor,
                                                            child: Text(
                                                              'D'.tr,
                                                              style: TextStyle(
                                                                  fontSize: 11,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w400,
                                                                  color: Colors
                                                                      .white),
                                                            ),
                                                            onPressed: () {
                                                            },
                                                          ),
                                                        ),
                                                      ],
                                                    )),
                                                visible: false,
                                              ),
                                              // )
                                            ])),

                                        SizedBox(
                                          height: 10,
                                        ),
                                        Obx(() => cellForRow()),

                                        // Container(
                                        //   margin: EdgeInsets.only(bottom: 15),
                                        //     padding:
                                        //     const EdgeInsets.only(
                                        //         left: 0,right: 0),
                                        //   // height: 1,color: Colors.red,
                                        //   child: divideLine(),
                                        // ),

                                        // GestureDetector(child:
                                        // Row(
                                        //     mainAxisAlignment:
                                        //     MainAxisAlignment.start,
                                        //     children: <Widget>[
                                        //     Obx(() =>
                                        //
                                        //       Expanded(
                                        //           flex: 1,
                                        //           child:
                                        //           RichText(
                                        //
                                        //             text:
                                        //             TextSpan(
                                        //               text: ''.tr+'：',
                                        //               style:
                                        //               TextStyle(color:Color(0xff999999), fontSize: 14),
                                        //               children: [
                                        //                 TextSpan(
                                        //                     text:
                                        //                     '${logic.mb.value}',
                                        //                     style: TextStyle(
                                        //                         color: Colors
                                        //                             .black,
                                        //                         fontSize:
                                        //                         14)),
                                        //
                                        //               ],
                                        //             ),
                                        //           )),
                                        //     ),
                                        //       arrowForward(),
                                        //     ]),
                                        //   onTap: (){
                                        //     Get.toNamed('/statRecord');
                                        //
                                        // },),
                                        //
                                        //           sizeBoxPadding(w: 0, h: 30),

                                        // Container(
                                        //   // padding:
                                        //   //     const EdgeInsets.only(
                                        //   //         bottom: 15),
                                        //   child: Row(
                                        //     children: [
                                        //       Expanded(
                                        //         // width: 62,
                                        //         flex: 1,
                                        //         child: OutlinedButton(
                                        //           style: ButtonStyle(
                                        //               shape: MaterialStateProperty.all(RoundedRectangleBorder(
                                        //                   borderRadius:
                                        //                       BorderRadius.circular(
                                        //                           4))),
                                        //               side: MaterialStateProperty
                                        //                   .all(BorderSide(
                                        //                       color: Color(
                                        //                           0xffFF843E)))),
                                        //           child:  Text(
                                        //             'C'.tr,
                                        //             style: TextStyle(
                                        //                 color: Color(
                                        //                     0xffFF843E)),
                                        //           ),
                                        //           onPressed: () {
                                        //             Get.toNamed(
                                        //                 '/index');
                                        //           },
                                        //         ),
                                        //       ),
                                        //       Container(
                                        //           width: 10,),
                                        //       Expanded(
                                        //           // margin:
                                        //           //     const EdgeInsets
                                        //           //             .only(
                                        //           //         left: 10),
                                        //           // width: 62,
                                        //         flex: 1,
                                        //           child:
                                        //               MaterialButton(
                                        //             color: Color(
                                        //                 0xffFF843E),
                                        //             child:  Text(
                                        //               'D'.tr,
                                        //               style: TextStyle(
                                        //                   color: Colors
                                        //                       .white),
                                        //             ),
                                        //             onPressed: () {
                                        //               final logic =
                                        //                   Get.put(
                                        //                       BottomLogic());
                                        //               logic
                                        //                   .changePage(
                                        //                       1);
                                        //             },
                                        //           ))
                                        //     ],
                                        //   ),
                                        // )
                                      ])))),
                      Container(width: 10, height: 10),
                      Expanded(
                          flex: 1,
                          child: Container(
                              child: Container(
                                  padding: const EdgeInsets.only(
                                      left: 15, right: 15, top: 15),
                                  decoration: const BoxDecoration(
                                    gradient: LinearGradient(colors: [
                                      Color(0xffffffff),
                                      Color(0xffffffff),
                                      Color(0xffffffff),
                                      Color(0xffffffff),
                                    ]), // 渐变色
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(6),
                                    ),
                                    boxShadow: [
                                      BoxShadow(
                                        blurRadius: 2,
                                        //阴影范围
                                        spreadRadius: 1,
                                        //阴影浓度
                                        offset: Offset(0.0, 5.0),
                                        //阴影y轴偏移量
                                        color:
                                            Color(0xffEAEDF3), //阴影颜色
                                      ),
                                    ],
                                  ),
                                  child:

                                  Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                         Text(
                                          ''.tr,
                                          style:
                                              TextStyle(fontSize: 14),
                                        ),
                                        Container(
                                            margin:
                                                const EdgeInsets.only(
                                                    top: 16),
                                            padding:
                                                const EdgeInsets.only(
                                                    bottom: 15),
                                            child: Row(children: [
                                              Expanded(
                                                  flex: 1,
                                                  child:
                                                  RichText(
                                                    text:
                                                         TextSpan(
                                                      children: [
                                                        TextSpan(
                                                            text:
                                                            '${logic.mb.value}',
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .black,
                                                                fontSize:
                                                                    24)),
                                                        // WidgetSpan(
                                                        //   child: Padding(
                                                        //     padding: EdgeInsets
                                                        //         .symmetric(
                                                        //         horizontal:
                                                        //         2.0),
                                                        //     child: Icon(
                                                        //       Icons.loop,
                                                        //       color: Colors.white,
                                                        //     ),
                                                        //   ),
                                                        // )
                                                      ],
                                                    ),
                                                  )),
                                            ])),
                                        Container(
                                            width: double.infinity,
                                            padding:
                                                const EdgeInsets.only(
                                                    bottom: 15),
                                            child: OutlinedButton(
                                              style: ButtonStyle(
                                                  shape: MaterialStateProperty.all(
                                                      RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius.circular(
                                                                  4))),
                                                  side: MaterialStateProperty
                                                      .all(BorderSide(
                                                          color: Color(
                                                              0xffFF8888)))),
                                              child:  Text(
                                                '🔍'.tr,
                                                style: TextStyle(
                                                    color: Color(
                                                        0xffFF8888)),
                                              ),
                                              onPressed: () {
                                                Get.toNamed('/statRecord');
                                              },
                                            ))
                                      ]))))
                    ],
                  )))
            ])),
        SizedBox(
          height: 20,
        ),
        Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.only(left: 15, right: 15),
            //   width: 180,
            height: 44,
            child: Row(
              children: [
                Container(
                  // alignment: Alignment.center,
                  // margin:
                  // const EdgeInsets
                  //     .only(
                  //     right: 10),
                  width: itemWidth,
                  height: 44,
                  child: OutlinedButton(
                    style: ButtonStyle(
                        shape: MaterialStateProperty.all(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4))),
                        side: MaterialStateProperty.all(
                            BorderSide(color: AppTheme.themeHightColor))),
                    child: Text(
                      'C'.tr,
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: AppTheme.themeHightColor),
                    ),
                    onPressed: () {
                      // logic.boolCanEdit.value == 1
                      //     ? Get.dialog(
                      //         AuthView(
                      //             logic.boolSafeword.value, logic.boolId.value),
                      //         barrierDismissible: true)
                      //     :
                      Get.toNamed('/index');
                    },
                  ),
                ),
                Container(
                  width: 10,
                ),
                Container(
                  // alignment: Alignment.center,
                  // margin:
                  // const EdgeInsets
                  //     .only(
                  //     right: 10),
                  width: itemWidth,
                  height: 44,
                  child: MaterialButton(
                    color: AppTheme.themeHightColor,
                    child: Text(
                      'D'.tr,
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: Colors.white),
                    ),
                    onPressed: () {

                    },
                  ),
                ),
              ],
            )),


        // Expanded(flex: 1,
        //        child:
        //            Column(children: [


               ListView.builder(
                 padding: const EdgeInsets.only(
                     left: 15, right: 15),
                 //  padding: EdgeInsets.all(5),
                 physics: const NeverScrollableScrollPhysics(),
                 itemExtent: 50,
                 shrinkWrap: true,
                 itemCount: logic.listModels.length,
                 itemBuilder: (BuildContext context, int index) {
                   var data = logic.listModels[index];
                   return listCellForRow(data, index);
                 },
               ),


                 //   ],),
                 //
                 // ) ,


    ]

          )
      // )

      ],)



    );
  }

  Widget listCellForRow(var listModel, int index) {
    final logic = Get.put(MeLogic());
    return
      Container(
          padding: const EdgeInsets.only(top: 0, bottom: 0),
          child: InkWell(
              hoverColor: Colors.transparent,
              onTap: () {
                index==0?
                Get.offNamed('/langSetting', parameters: {'path': '1'})
                    :
                index==1?
                launchWebURL('')
                    : Get.toNamed('/setting')
                ;
              },
              child: Row(
                  children: <Widget>[
                    Expanded(
                        flex: 1,
                        child: Row(children: <Widget>[
                          SizedBox(
                              width: 18,
                              height: 18,
                              child:listModel['icon']
                            // Image.asset(
                            //     'assets/images/me/feedback.png')
                          ),
                          Expanded(
                              child: Container(
                                  alignment: Alignment.centerLeft,
                                  margin: const EdgeInsets.only(left: 10,top: 5),
                                  child: Text(
                                    listModel['name'],
                                    style: TextStyle(),
                                  )))
                        ])),
                    arrowForward()
                  ])))
        ;
  }

  Widget headInfoView(BuildContext context) {
    var _future = Future.delayed(Duration(seconds: 3), () {
      return '服务器返回的数据';
    });

    return FutureBuilder<String>(
      future: _future,
        builder: (BuildContext context, AsyncSnapshot snapshot) {

            return Row(crossAxisAlignment: CrossAxisAlignment.start, children: <
                Widget>[
              Obx(() => Container(
                  height: 80,
                  width: 80,
                  padding: const EdgeInsets.symmetric(
                      horizontal: 0.5, vertical: 0.5),
                  decoration: BoxDecoration(
                      border:
                          Border.all(color: const Color(0xffffffff), width: 2),
                      borderRadius: BorderRadius.circular(40)),
                  child: ClipOval(
                    child: Image.asset(
                        'assets/images/avatar/head_${logic.userInfo['avatar']}.jpg'),
                  ))),
              Expanded(
                flex: 1,
                child: Obx(() => Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                              margin: const EdgeInsets.only(left: 15, top: 15),
                              child: Row(
                                children: [
                                  Text(
                                    '${logic.userInfo['username']}',
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 18),
                                  ),
                                  sizeBoxPadding(w: 5, h: 0),
                                  // imageCircular(
                                  //     w: 30,
                                  //     h: 16,
                                  //     radius: 0,
                                  //     image:
                                  //         'assets/images/avatar/v${logic.userInfo['l']}.png'),
                                ],
                              )),
                          Container(
                              margin: const EdgeInsets.only(left: 15, top: 15),
                              child: Opacity(
                                child: Text(
                                  'ID:  ${logic.userInfo['usercode']}',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 14),
                                ),
                                opacity: 0.8,
                              ))
                        ])),
              ),
              const SizedBox(
                  height: 80,
                  width: 25,
                  child:
                      Icon(Icons.chevron_right, color: Colors.black, size: 30)),
            ]);

        });
  }



}

class _AccountMoney extends StatelessWidget {

  const _AccountMoney({
    Key? key,
    required this.title,
    required this.money,
    this.alignment,
    this.moneyTextStyle
  }): super(key: key);

  final String title;
  final String money;
  final MainAxisAlignment? alignment;
  final TextStyle? moneyTextStyle;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: MergeSemantics(
        child: Column(
          mainAxisAlignment: alignment ?? MainAxisAlignment.center,
          children: <Widget>[
            /// 横向撑开Column，扩大语义区域
            const SizedBox(width: double.infinity),
            Text(title, style: const TextStyle(color: Colors.black, fontSize: 12)),
            SizedBox(height: 8,),
            RiseNumberText(
                num.parse(money),
                style: moneyTextStyle ?? const TextStyle(
                    color: Colors.grey,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'RobotoThin'
                )
            ),
          ],
        ),
      ),
    );
  }
}

