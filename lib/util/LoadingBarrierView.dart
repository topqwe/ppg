import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import '../widgets/helpTools.dart';

class LoadingBarrierView {
  static bool isShow = false;

  static showLoading(BuildContext context) {
    if (!isShow) {
      isShow = true;
      showGeneralDialog(
        barrierColor: Colors.transparent,
          context: context,
          // barrierColor: Colors.white, // 背景色
          // barrierLabel: '',
          barrierDismissible: false, // 是否能通过点击空白处关闭
          transitionDuration: const Duration(milliseconds: 15), // 动画时长
          pageBuilder: (BuildContext context, Animation animation,
              Animation secondaryAnimation) {
            return
              WillPopScope(child://Android <-
              Align(
                child: Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    color: Colors.black54,
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  child: Theme(
                    data: ThemeData(
                      cupertinoOverrideTheme: CupertinoThemeData(
                        brightness: Brightness.dark,
                          // primaryColor:Colors.transparent,
                      ),
                    ),
                    child: CupertinoActivityIndicator(
                      radius: 14,
                    ),
                  ),
                ),
              )

                , onWillPop: () async {

                  return false;
                },);


          }).then((value) {
        isShow = false;
      });
    }
  }

  static hideLoading(BuildContext context) {
    if (isShow) {
      Navigator.of(context).pop();
      // popPage(context);
      // popPage(context);
    }
  }
}
