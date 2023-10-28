import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:webviewx/webviewx.dart';

import '../../../util/DefaultAppBar.dart';
import 'logic.dart';

class OnlineServicePage extends StatelessWidget {
  final logic = Get.put(OnlineServiceLogic());

  @override
  Widget build(BuildContext context) {
    String par = Get.parameters['type'].toString();
    double bottomPadding = par == '0' ? 120 : 56;
    return Scaffold(
        // resizeToAvoidBottomInset: false, //解决键盘导致溢出页面
        appBar: DefaultAppBar(
          titleStr: par == '0'
              ? '客服'.tr
              : par == '1'
                  ? '关于我们'.tr
                  : par == '2'
                      ? '规则'.tr
                      : '',
        ),
        body: SafeArea(
          child: Center(
            child: Container(
              // padding: const EdgeInsets.only(bottom:120),
              child: Column(
                children: <Widget>[
                  Container(
                    child: WebViewX(
                      key: const ValueKey('webService'),
                      // initialSourceType: SourceType.html,
                      // height: ScreenUtil().screenHeight,
                      // width: double.infinity,
                      height: ScreenUtil().screenHeight - bottomPadding,
                      width: ScreenUtil().screenWidth,
                      onWebViewCreated: (controller) {
                        logic.webViewController = controller;
                        logic.webViewController.loadContent(
                          logic.urlStr,
                          // 'https://flutter.dev',
                          SourceType.URL,
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
