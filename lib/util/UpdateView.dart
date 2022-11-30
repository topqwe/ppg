import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../style/theme.dart';
import '../widgets/image_widget.dart';
import '../widgets/text_widget.dart';

import '../page/bottom/logic.dart';
import '../widgets/helpTools.dart';
import 'UpdateVersion.dart';

class UpdateView extends Dialog {
  UpdateView(this.appStoreUrl, this.latestVersion, this.latestContent,
      this.latestTitle, this.isShowCancelBtn, this.isFromHome);
  String appStoreUrl;
  String latestVersion;
  String latestContent;
  String latestTitle;
  bool isShowCancelBtn;
  bool isFromHome;

  @override
  // TODO: implement backgroundColor
  Color? get backgroundColor => Colors.transparent;

  @override
  Widget build(BuildContext context) {
    bool isShowCancelBtn = this.isShowCancelBtn;
    return WillPopScope(
      child: //Android <-
          Center(
        child: Container(
          // color: backgroundColor,//wrong
          width: double.maxFinite,
          height: 540,
          margin: EdgeInsets.only(left: 30, right: 30),
          // padding: EdgeInsets.only(left: 30,top: 30,right: 30,bottom: 30),
          child: Stack(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    // color: Colors.white,//wrong
                    width: double.maxFinite,
                    height: 301,
                    // margin: EdgeInsets.only(left: 30,right: 30),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          bottomRight: Radius.circular(8.0),
                          bottomLeft: Radius.circular(8.0)),
                    ),
                  ),
                ],
              ),
              Column(
                children: [
                  Container(
                    // color: Colors.white,
                    // color: backgroundColor,//wrong
                    width: double.maxFinite,
                    height: 240,
                    // decoration: BoxDecoration(
                    //   image: DecorationImage(
                    //     image: AssetImage(
                    //       "assets/images/UpdateTopBg.png",
                    //     ),
                    //     fit: BoxFit.fill,
                    //   ),
                    // ),
                  ),
                  Container(
                    // color: backgroundColor,//wrong
                    width: double.maxFinite,
                    // height: 230,
                    height: 300,
                    padding: EdgeInsets.only(
                        left: 30, top: 30, right: 30, bottom: 30),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          bottomRight: Radius.circular(8.0),
                          bottomLeft: Radius.circular(8.0)),
                      // image: DecorationImage(
                      //     image:  AssetImage("assets/images/updateVBg.png"),
                      //     fit: BoxFit.fill,
                      //     repeat: ImageRepeat.noRepeat),
                      // ),
                    ),

                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        syText(
                            text: this.latestTitle,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                        SizedBox(
                          height: 20,
                        ),
                        Expanded(
                            child: Container(
                          width: double.infinity,
                          child: SingleChildScrollView(
                            child: textContainer(
                                text: this.latestContent,
                                continerAlign: Alignment.centerLeft),
                          ),
                        )),
                        SizedBox(
                          height: 20,
                        ),
                        Row(mainAxisSize: MainAxisSize.min, children: [
                          Visibility(
                            child: Container(
                              width: ScreenUtil().setWidth(118),
                              height: 44,
                              child: OutlinedButton(
                                style: ButtonStyle(
                                    shape: MaterialStateProperty.all(
                                        RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(4))),
                                    side: MaterialStateProperty.all(BorderSide(
                                        color: AppTheme.themeHightColor))),
                                child: Text(
                                  '暂不更新'.tr,
                                  style: TextStyle(
                                      fontSize: 11,
                                      fontWeight: FontWeight.w400,
                                      color: AppTheme.themeHightColor),
                                ),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                            ),
                            visible: isShowCancelBtn ? true : false,
                          ),
                          Visibility(
                            child: SizedBox(
                              width: ScreenUtil().setWidth(14),
                            ),
                            visible: isShowCancelBtn ? true : false,
                          ),
                          Container(
                            // alignment: Alignment.center,
                            // margin:
                            // const EdgeInsets
                            //     .only(
                            //     right: 10),
                            width: ScreenUtil().setWidth(118),
                            height: 44,
                            child: MaterialButton(
                              color: AppTheme.themeHightColor,
                              child: Text(
                                '立即更新'.tr,
                                style: TextStyle(
                                    fontSize: 11,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.white),
                              ),
                              onPressed: () {
                                if (isShowCancelBtn)
                                  Navigator.of(context).pop();
                                // if(isFromHome)Get.offNamed('/index');
                                launchWebURL(appStoreUrl);
                              },
                            ),
                          ),
                        ])
                      ],
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
      onWillPop: () async {
        return false;
      },
    );
  }

  @override
  EdgeInsetsGeometry get contentPadding => EdgeInsets.all(0);
}
