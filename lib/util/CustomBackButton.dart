
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

/**
 * 页面后退按钮
 */
class CustomBackButton extends StatelessWidget {
  const CustomBackButton({Key? key, this.onPressed, this.color,
    this.iconSize = 20, this.alignment = Alignment.centerLeft, this.iconColor,
    this.icon, this.padding: const EdgeInsets.only(left: 10)
  }): super(key: key);

  /// 点击事件
  final VoidCallback? onPressed;

  /// 颜色
  final Color? color;

  /// 按钮大小
  final double iconSize;

  /// 按钮
  final Widget? icon;

  /// 对齐方式
  final Alignment alignment;

  /// 填充
  final EdgeInsetsGeometry padding;

  final Color? iconColor;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return IconButton(
      padding:  padding,
      alignment: alignment,
      iconSize: iconSize, // package: "project_common",
      icon: icon ??
          Icon(Icons.arrow_back_ios,
              color: iconColor??const Color(0xff333333), size: 20),
          // Image.asset("assets/images/arrow-lift.png", color: iconColor??Colors.white),
      color: color,
      onPressed: () {
        if (onPressed != null) {
          onPressed!();
        } else {
          // Navigator.maybePop(context);
          Get.back();
        }
      },
    );
  }
}