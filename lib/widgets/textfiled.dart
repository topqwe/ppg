import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../widgets/text_widget.dart';

import 'button_widget.dart';



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

