import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import '../style/theme.dart';
import 'dart:async';

import '../widgets/text_widget.dart';

import '../widgets/button_widget.dart';
import '../widgets/helpTools.dart';
import '../widgets/image_widget.dart';

showSafeValidPage(
    BuildContext context, VoidCallback okcb, VoidCallback canclecb) {
  //显示对话框
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return SafeValidPage(canclecb: canclecb, okcb: okcb);
    },
  );
}

class SafeValidPage extends StatefulWidget {
  final VoidCallback okcb;
  final VoidCallback canclecb;

  const SafeValidPage({
    Key? key,
    required this.okcb,
    required this.canclecb,
  }) : super(key: key);

  @override
  _SafeValidPageState createState() => _SafeValidPageState();
}

class _SafeValidPageState extends State<SafeValidPage> {
  int num = 0;

  String m_price = "";
  var m_txtMoney = new TextEditingController();

  int m_jiaogeCheckIndex = 0;
  List<dynamic> m_lstjiaoge = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initPos();
  }

  initPos() {
    m_beginPos = 20;
    m_hPos = 10;
    m_top = 65; //+ Random().nextInt(120).toDouble();
    m_bDrag = false;
    m_validPos = Random().nextInt(200).toDouble();
    m_validPos = m_validPos + 50;
    m_validPos = m_validPos >= Max ? Max.toDouble() : m_validPos;
    setState(() {});
  }

  @override
  void dispose() {
    super.dispose();
  }

  double m_beginPos = 0;
  double m_hPos = 10;
  int Max = 300;
  double m_validPos = 0;
  bool m_bDrag = false;
  double m_top = 50;
  @override
  Widget build(BuildContext context) {
    String txt = m_bDrag ? "" : '向右滑动完成拼图'.tr;
    Widget items = Container(
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(8.0)),
        color: Colors.white,
      ),

      height: 360,
      width: 400,
      padding: EdgeInsets.only(left: 10, right: 10, bottom: 0, top: 10),
      alignment: Alignment.center,
      child: Column(children: [
        Container(
          height: 15,
          child: Row(
            children: [
              Expanded(
                child: Container(
                  child: syText(text: '安全验证'.tr, color: Colors.transparent),
                ),
              ),
              IconButton(
                  padding: EdgeInsets.only(right: 0),
                  alignment: Alignment.topRight,
                  color: Color(0xff333333),
                  icon: Icon(Icons.close,
                      color: Color(0xff333333), size: 20), //, size: 14
                  iconSize: 20,
                  onPressed: () {
                    widget.canclecb();
                    Get.back();
                    // Get.offNamed('/index');
                  }),
            ],
          ),
        ),
        textContainer(text: '安全验证'.tr, fontSize: 18),
        // syText(text: '安全验证'),
        SizedBox(
          height: 10,
        ),

        // Positioned(
        //     top: 0,
        //     right: 0,
        //     child:
        //     IconButton(
        //       // padding: EdgeInsets.only(left: 0),
        //       // alignment: Alignment.centerLeft,
        //         color: Color(0xff333333),
        //         icon: Icon(Icons.close,
        //             color: Color(0xff333333), size: 20),//, size: 14
        //         iconSize: 20,
        //         onPressed: () {
        //           widget.canclecb();
        //           Get.back();
        //           // Get.offNamed('/index');
        //         }),
        // ),

        Stack(
          alignment: Alignment.center, //指定未定位或部分定位widget的对齐方式
          children: <Widget>[
            imageCircularNoH(
              w: ScreenUtil().screenWidth,
              radius: 2,
              image: "assets/images/login/safeValidBg.png",
            ),
            Positioned(
              top: m_top,
              left: m_validPos,
              child: imageCircularNoH(
                  w: 50, radius: 2, image: "assets/images/login/tob.png"),
            ),
            Positioned(
              top: m_top,
              left: m_hPos,
              child: imageCircularNoH(
                  w: 50, radius: 2, image: "assets/images/login/from.png"),
            ),
          ],
        ),
        SizedBox(height: 20),
        Stack(
          alignment: Alignment.center, //指定未定位或部分定位widget的对齐方式
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                color: AppTheme.themeGreyColor,
                borderRadius: BorderRadius.circular(0),
                // border: Border.all(
                //   style: BorderStyle.solid,
                //   color: ColorPlate.btnColor,
                //   width: 1,
                // ),
              ),
              height: 40,
              width: ScreenUtil().screenWidth,
              alignment: Alignment.center,
              child: Text(
                txt,
                style: TextStyle(
                  color: Colors.white,
                  //  fontWeight: FontWeight.normal,
                  fontSize: 12,
                  //overflow: TextOverflow.clip,
                ),
              ),
            ),
            Positioned(
              top: 0,
              left: m_hPos,
              child: GestureDetector(
                onHorizontalDragStart: (DragStartDetails details) {
                  m_beginPos = details.globalPosition.dx;
                  m_bDrag = true;
                },
                onHorizontalDragUpdate: (DragUpdateDetails details) {
                  double diff = details.globalPosition.dx - m_beginPos;
                  m_beginPos = details.globalPosition.dx;

                  double newpos = m_hPos + diff;
                  if (newpos < 0 || newpos > Max) {
                    return;
                  }
                  m_hPos = newpos;

                  setState(() {});
                },
                onHorizontalDragEnd: (DragEndDetails details) {
                  Future.delayed(Duration(milliseconds: 600), () {
                    double diff = (m_hPos - m_validPos).abs();
                    if (diff < 20) {
                      Navigator.of(context).pop();
                      // Get.offNamed('/index');
                      widget.okcb();
                    } else {
                      initPos();
                      // showMessage(getLan("图形验证错误，请重新再试"));
                    }
                  });
                },
                child: Container(
                    padding: EdgeInsets.only(top: 3),
                    child: Container(
                        // color: AppColors.theme,
                        child: Image.asset("assets/images/login/toright.png",
                            width: 64, fit: BoxFit.fitWidth))),
              ),
            ),
          ],
        ),
        Visibility(
          child: Container(
            padding: EdgeInsets.only(
              //   bottom: 10,
              top: 20,
            ),
            alignment: Alignment.bottomRight,
            // color: AppColors.theme,
            child: IconButton(
                padding: EdgeInsets.only(right: 0),
                alignment: Alignment.centerRight,
                color: Color(0xff333333),
                icon: Icon(Icons.refresh,
                    color: Color(0xff333333), size: 20), //, size: 14
                iconSize: 20,
                onPressed: () {
                  initPos();
                }),
          ),
          visible: false,
        ),
      ]),
      // height: 30,
    );

    Widget body = Container(
      // width: 350,
      padding: EdgeInsets.only(left: 15, right: 15, top: 0, bottom: 0),
      color: Colors.transparent,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          items,
        ],
      ),
    );
    return Scaffold(
      body: body,
      backgroundColor: Colors.transparent,
    );
  }
}
