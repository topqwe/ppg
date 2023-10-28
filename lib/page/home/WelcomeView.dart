import 'dart:io';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:ftoast/ftoast.dart';
import 'package:get/get.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';
import '../../services/responseHandle/request.dart';
import '../../style/theme.dart';
import '../../../widgets/button_widget.dart';
import '../../../widgets/text_widget.dart';


class WelcomeView extends Dialog {
//非State，no GetTickerProviderStateMixin,so in Control
  List<String> _charList = [];
  List<AnimationController> _controllerList = [];
  List<CurvedAnimation> _moveAnimation = [];

  bool played = false;
  bool playing = false;

  WelcomeView(this.userWallet, this.listModel, this.animationController);

  String userWallet;
  var listModel;
  var animationController;

  @override
  // TODO: implement backgroundColor
  Color? get backgroundColor => Colors.transparent;

  void play() {
    played = true;
    playing = true;
    for (int i = 0; i < _charList.length; i++) {
      Future.delayed(Duration(
        milliseconds: i * 80,
      )).then((_) {
        _controllerList[i].forward().whenComplete(() {
          if (i == _charList.length - 1) {
            playing = false;
          }
        });
      });
    }
  }

  void initState() {
    String testString = '初次见面'.tr;
    testString.tr.codeUnits.forEach((value) {
      _charList.add(String.fromCharCode(value));
      var controller = animationController;
      // var animationController = AnimationController(
      //     vsync: this, duration: Duration(milliseconds: 600));
      _controllerList.add(controller);
      _moveAnimation.add(CurvedAnimation(
        parent: controller,
        curve: Curves.easeInOutExpo,
      ));
    });
    play();
    // super.initState();
  }

  @override
  Widget build(BuildContext context) {
    initState();

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
                height: 380 - 10, //540,
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
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Expanded(flex: 1, child: Container()),
                                  // Container(
                                  //   margin: EdgeInsets.only(right: 12),
                                  //   child: Image.asset(
                                  //     '',
                                  //     width: 50,
                                  //     height: 1,
                                  //     fit: BoxFit.fill,
                                  //   ),
                                  // ),
                                  Container(
                                      child: Center(
                                    child: Wrap(
                                      children:
                                          List.generate(_charList.length, (i) {
                                        return AnimatedText(
                                            animation: _moveAnimation[i],
                                            child: Text(
                                              _charList[i],
                                              style: TextStyle(
                                                fontSize: 17,
                                                color: AppTheme.themeGreyColor,
                                              ),
                                            ));
                                      }),
                                    ),
                                  )
                                      // Text('Hi~'+'初次见面'.tr,
                                      //     style: TextStyle(
                                      //         color:
                                      //         AppTheme.themeGreyColor,
                                      //         fontSize: 17))

                                      ),
                                  // Container(
                                  //   margin: EdgeInsets.only(left: 12),
                                  //   child: Image.asset(
                                  //     '',
                                  //     width: 50,
                                  //     height: 1,
                                  //     fit: BoxFit.fill,
                                  //   ),
                                  // ),
                                  Expanded(flex: 1, child: Container()),
                                ]),

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
                                // physics: AlwaysScrollableScrollPhysics(
                                //   parent: BouncingScrollPhysics(),
                                // ),
                                child: Column(
                              children: [
                                SizedBox(
                                  height: 15,
                                ),
                                syText(
                                    text: '新人'.tr,
                                    fontSize: 28,
                                    fontWeight: FontWeight.bold),
                                SizedBox(
                                  height: 15,
                                ),
                                Container(
                                  // color: backgroundColor,//wrong
                                  // width: 280,
                                  // height: 230,
                                  height: 100,

                                  // padding: EdgeInsets.all(20),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(0.0),
                                    ),
                                    // borderRadius: BorderRadius.only(
                                    //     bottomRight: Radius.circular(8.0),
                                    //     bottomLeft: Radius.circular(8.0)),
                                    image: DecorationImage(
                                        image: AssetImage(
                                            "assets/images/home/homeNew.png"),
                                        fit: BoxFit.fill,
                                        repeat: ImageRepeat.noRepeat),
                                  ),
                                  child: Container(
                                    padding: EdgeInsets.only(
                                        left: 12, right: 24, top: 12),
                                    child: Row(
                                      children: [
                                        textContainer(
                                            text: '已存'.tr,
                                            color: Colors.white,
                                            continerAlign:
                                                Alignment.centerLeft),
                                        Expanded(child: SizedBox()),
                                        Container(
                                          padding: EdgeInsets.only(right: 12),
                                          alignment: Alignment.centerRight,
                                          child: RichText(
                                            textAlign: TextAlign.right,
                                            text: TextSpan(
                                              text: userWallet,
                                              style: TextStyle(
                                                  height: 1,
                                                  fontSize: 24,
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.bold),
                                              children: <TextSpan>[
                                                TextSpan(
                                                  text: '\n' 'SB',
                                                  style: TextStyle(
                                                      height: 1.5,
                                                      fontSize: 17,
                                                      color: Colors.black,
                                                      fontWeight:
                                                          FontWeight.normal),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 13,
                                ),
                              ],
                            )),
                          )),

                          // syText(text: this.latestTitle,fontSize: 20,fontWeight: FontWeight.bold),

                          customFootFuncBtn(marginlr: 0, margintb: 0, '查看'.tr,
                              () {
                            Get.back();
                            Get.toNamed('/transaction_record');
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

                    Container(
                        margin: EdgeInsets.only(top: 30),
                        child: Row(
                          children: [
                            Expanded(flex: 1, child: Container()),
                            IconButton(
                              icon: Image.asset(
                                'assets/images/O.png',
                                width: 30,
                                fit: BoxFit.fitWidth,
                              ),
                              onPressed: () {
                                // Get.offNamed("/");
                                Get.back();
                                return;
                              },
                            ),
                            Expanded(flex: 1, child: Container()),
                          ],
                        )),
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

class AnimatedText extends AnimatedWidget {
  final Tween<double> _opacityAnim = Tween(begin: 0, end: 1);
  final Widget? child;

  AnimatedText({required Animation<double> animation, this.child})
      : super(listenable: animation);

  _getOpacity() {
    var value = _opacityAnim.evaluate(listenable as Animation<double>);
    if (value < 0) {
      return 0;
    } else if (value > 1) {
      return 1;
    } else {
      return value;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: _getOpacity(),
      child: SlideTransition(
        position: Tween(begin: Offset(0, 5), end: Offset(0, 0))
            .animate(listenable as Animation<double>),
        child: child,
      ),
    );
  }
}
