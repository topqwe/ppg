import 'package:flutter/material.dart'; 
///圆角图片
Widget imageCircular(
    {required double w,
    required double h,
    required double radius,
    required String image,
    BoxFit fit = BoxFit.fill}) {
  return Container(
    color: Colors.transparent,
    width: w,
    height: h,
    child: ClipRRect(
      borderRadius: BorderRadius.circular(radius),
      child: Image.asset(
        image,
        fit: fit,width: w,height: h,
      ),
    ),
  );
}
///圆角图片
Widget imageCircularNoH(
    {required double w,

      required double radius,
      required String image,
      BoxFit fit = BoxFit.fill}) {
  return Container(
    color: Colors.transparent,
    width: w,
  //  height: h,
    child: ClipRRect(
      borderRadius: BorderRadius.circular(radius),
      child: Image.asset(
        image,
        fit: fit,
      ),
    ),
  );
}
