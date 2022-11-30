import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../store/AppCacheManager.dart';
import 'package:webviewx/webviewx.dart';

import '../../../api/request/config.dart';
import '../../../api/request/request.dart';


class WebViewXPage extends StatefulWidget {
  String url = '';
  double bottomPadding ;

  WebViewXPage({
    this.url = "",
    this.bottomPadding = 56
  });

  @override
  _WebViewXPageState createState() => _WebViewXPageState();
}

class _WebViewXPageState extends State<WebViewXPage> {
  late WebViewXController webviewController;


  String url = '';
  double bottomPadding = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    url = widget.url;
    bottomPadding = widget.bottomPadding;
    // postRequest();
  }

  void postRequest() => request(() async {

    String? token = AppCacheManager.instance.getUserToken();
    String lang = 'en';
    if('${Get.locale}'.contains('en_')){
      lang = 'en';
    }else{
      lang = 'zh-CN';
    }
    url =
        RequestConfig.noWapBaseUrl + RequestConfig.chatHome + '?token=${token}&&lang=${lang}';


  });


  @override
  void dispose() {
    webviewController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar:
      // DefaultAppBar(titleStr: ''.tr,leading: SizedBox.shrink(),),
      body:
      Center(
        child: Container(
          // padding: const EdgeInsets.all(10.0),
          child: Column(
            children: <Widget>[

               Container(
                child: WebViewX(
                  key: const ValueKey('webviewx'),
                  // initialSourceType: SourceType.html,
                  // height: ScreenUtil().screenHeight,
                  // width: double.infinity,
                  height: ScreenUtil().screenHeight-bottomPadding,
                  width: ScreenUtil().screenWidth,
                  onWebViewCreated: (controller) {
                    webviewController = controller;
                    webviewController.loadContent(
                      url,
                      // 'https://flutter.dev',
                      SourceType.url,
                    );
                  },

                ),

              ),

            ],
          ),
        ),
      ),
    );
  }


}
