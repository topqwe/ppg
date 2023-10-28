import 'package:flutter/material.dart';

///空白边距
Widget sizeBoxPadding({
  required double w,
  required double h,
}) {
  return SizedBox(
    width: w,
    height: h,
  );
}


Widget divideLine(){
 return Container(padding:
  const EdgeInsets.only(left: 0, right: 0),
    height: 1,color: Color(0xffF6F6F6),);
}




