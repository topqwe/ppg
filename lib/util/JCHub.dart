import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class JCHub {
  static void showmsg(String msg, BuildContext context) {
    if (kIsWeb) {
      Fluttertoast.showToast(
          msg: msg,
          webPosition: "center",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1);
    } else {
      Fluttertoast.showToast(
          msg: msg,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1);
    }
  }

  static void showCupertinoDialog(String title, Function CancelBlock,
      Function CertainBlock, BuildContext context) {
    var dialog = CupertinoAlertDialog(
      content: Text(
        title,
        style: TextStyle(fontSize: 20),
      ),
      actions: <Widget>[
        CupertinoButton(
          child: Text("取消".tr),
          onPressed: () {
            CancelBlock();
            Navigator.pop(context);
          },
        ),
        CupertinoButton(
          child: Text("确定".tr),
          onPressed: () {
            CertainBlock();
            Navigator.pop(context);
          },
        ),
      ],
    );

    showDialog(context: context, builder: (_) => dialog);
  }
}
