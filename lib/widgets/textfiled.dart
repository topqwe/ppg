import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../widgets/text_widget.dart';

import 'button_widget.dart';

///带头部标题输入框
Widget textFieldUpTitle(
  String title,
  String hintText,
  TextEditingController controller, {
  Widget? rightWidget,
  double titleSize = 14,
  double fontSize = 14,
  double hintFontSize = 14,
  double radius = 0,
  double borderWidth = 0,
  Color backgroundColor = Colors.transparent,
  bool obscureType = false,
  bool obscureText = false,
  TextInputType keyboardType = TextInputType.text,
  Function? obscureTap,
}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      csText(text: title, fontSize: titleSize),
      Container(
        decoration: BoxDecoration(
          border: Border.all(
              width: borderWidth,
              color:
                  borderWidth == 0 ? Colors.white : Colors.grey),
          borderRadius: BorderRadius.circular(radius),
          color: backgroundColor,
        ),
        margin: const EdgeInsets.only(top: 10),
        padding: const EdgeInsets.only(left: 12, right: 12),
        alignment: Alignment.centerLeft,
        height: 44,
        child: Row(
          children: [
            Expanded(
              child: TextField(
                controller: controller,
                obscureText: obscureText,
                textAlign: TextAlign.start,
                keyboardType: keyboardType,
                style: TextStyle(
                    fontSize: fontSize,
                    color: Colors.black,
                    fontWeight: FontWeight.w500),
                decoration: InputDecoration(
                  isCollapsed: true,
                  border: const OutlineInputBorder(borderSide: BorderSide.none),
                  contentPadding: const EdgeInsets.all(0),
                  hintStyle: TextStyle(
                      fontSize: hintFontSize,
                      color: Colors.grey,
                      fontWeight: FontWeight.normal),
                  hintText: hintText,
                ),
              ),
            ),
            Visibility(
              visible: obscureType,
              child: buttonPaddingImage(
                imageW: 20,
                imageH: 16,
                // image:obscureText? ("close.png"): ("open.png"),
                image: "",
                onPressed: () {
                  obscureTap!();
                },
              ),
            ),
            Visibility(
              visible: rightWidget == null ? false : true,
              child: rightWidget ?? Container(),
            ),
          ],
        ),
      ),
    ],
  );
}

///输入框
Widget textField({
  required TextEditingController controller,
  String hintText = "",
  double height = 44,
  Color backgroundColor = Colors.transparent,
  EdgeInsetsGeometry padding = EdgeInsets.zero,
  double radius = 0,
}) {
  return Container(
      decoration:  BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.all(Radius.circular(radius)),
        ),
    padding: padding,
    alignment: Alignment.centerLeft,
    height: height,
    child: Row(
      children: [
        Expanded(
          child: TextField(
            controller: controller,
            textAlign: TextAlign.start,
            style: TextStyle(
                fontSize: 14,
                color: Colors.black,
                fontWeight: FontWeight.w500),
            decoration: InputDecoration(
              isCollapsed: true,
              border: const OutlineInputBorder(borderSide: BorderSide.none),
              contentPadding: const EdgeInsets.all(0),
              hintStyle: TextStyle(
                  fontSize: 14,
                  color: Colors.grey,
                  fontWeight: FontWeight.normal),
              hintText: hintText,
            ),
          ),
        ),
      ],
    ),
  );
}

Widget textFieldNewLine(
    {required TextEditingController controller,
    String hintText = "",
    double height = 44}) {
  return Container(
    alignment: Alignment.centerLeft,
    height: height,
    child: Row(
      children: [
        Expanded(
          child: TextField(
            controller: controller,
            maxLines: 1000,
            textAlign: TextAlign.start,
            style: TextStyle(
                fontSize: 14,
                color: Colors.black,
                fontWeight: FontWeight.w500),
            decoration: InputDecoration(
              isCollapsed: true,
              border: const OutlineInputBorder(borderSide: BorderSide.none),
              contentPadding: const EdgeInsets.all(0),
              hintStyle: TextStyle(
                  fontSize: 14,
                  color: Colors.grey,
                  fontWeight: FontWeight.normal),
              hintText: hintText,
            ),
          ),
        ),
      ],
    ),
  );
}
