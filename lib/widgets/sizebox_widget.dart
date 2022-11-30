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

///竖线横线
Widget sizeBoxVerticalLine({
  required double w,
  required double h,
  required Color color,
}) {
  return  SizedBox(
    width: w,
    height: h,
    child:  DecoratedBox(
      decoration:
      BoxDecoration(color: color),
    ),
  );
}
Widget divideLine(){
 return Container(padding:
  const EdgeInsets.only(left: 0, right: 0),
    height: 1,color: Color(0xffF6F6F6),);
}

Widget vdivider(double h) {
  return Container(
    width: 1,
    height: h,
    //
    //padding: EdgeInsets.fromLTRB(4, 20, 4, 4),
    alignment: Alignment.center,
    child: VerticalDivider(
      color: Color(0xffF6F6F6),
      width: 1,
      // color: ColorPlate.lineColor,
    ),
  );
}



