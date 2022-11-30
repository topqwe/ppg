import 'package:flutter/material.dart';
import '../widgets/button_widget.dart';
import '../widgets/image_widget.dart';
Widget csText({
  required String text,
  Color color = Colors.black,
  double fontSize = 14.0,
  double letterSpacing = 0.0,
  double height = 0,
  FontWeight fontWeight = FontWeight.normal,
  TextAlign textAlign = TextAlign.center,
  String fontFamily = "Roboto",
  int maxLines = 1000,
  TextDecoration textDecoration = TextDecoration.none,
}) {
  return Text(
    text,
    textAlign: textAlign,
    overflow: TextOverflow.ellipsis,
    maxLines: maxLines,
    softWrap: true,
    style: TextStyle(
      decoration: textDecoration,
      color: color,
      fontSize: fontSize,
      fontWeight: fontWeight,
      letterSpacing: letterSpacing,
      fontFamily: fontFamily,
    ),
  );
}
Widget syText({
  required String text,
  Color color = Colors.black, //AppColors.textBlack,
  double fontSize = 14.0,
  double letterSpacing = 0.0,
  double height = 0,
  FontWeight fontWeight = FontWeight.normal,
  TextAlign textAlign = TextAlign.center,
}) {
  return Text(
    text,
    textAlign: textAlign,
    style: TextStyle(
      color: color,
      fontSize: fontSize,
      // height:height,
      fontWeight: fontWeight,
      letterSpacing: letterSpacing,
      // fontFamily: "Source Han Sans",
    ),
  );
}

Widget textContainer({
  String text = "",
  Color color = Colors.black, //AppColors.textBlack,
  containerBgColor = Colors.transparent,
  double fontSize = 14.0,
  double letterSpacing = 0.0,
  double height = 0,
  FontWeight fontWeight = FontWeight.normal,
  TextAlign textAlign = TextAlign.center,
  Alignment continerAlign = Alignment.center,
}) {
  TextStyle st = TextStyle(
    color: color,
    fontWeight: fontWeight,
    fontSize: fontSize,
    inherit: true,
  );
  return Container(
    padding: const EdgeInsets.all(0),
    color: containerBgColor,
    //padding: EdgeInsets.fromLTRB(4, 10, 4, 4),
    alignment: continerAlign,
    child: Text(
      text,
      style: st,
    ),
  );
}

Widget sliverSectionHead(String text,
    {Color backgroundColor = Colors.transparent}) {
  return SliverToBoxAdapter(
    child: Container(
      padding: const EdgeInsets.only(left: 15),
      // padding: EdgeInsets.only(left: padding(), right: padding()),
      alignment: Alignment.centerLeft,
      height: 40,
      width: double.infinity,
      child: textContainer(
          text: text,
          textAlign: TextAlign.left,
          continerAlign: Alignment.centerLeft),
    ),
  );
}

Widget ultimatelyLRTxt({
  required String textl,
  required String textr,
  Color textlColor = Colors.grey,
  Color textrColor = Colors.black,
}) {
  return Container(
    child: Row(
      children: <Widget>[
        Expanded(
          child: Container(
            //padding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
            child: textContainer(
                text: textl,
                color: textlColor,
                continerAlign: Alignment.centerLeft),
          ),
        ),
        textContainer(
            text: textr,
            color: textrColor,
            continerAlign: Alignment.centerRight),
      ],
    ),
  );
}

Widget ultimatelyLRMaxLinesTxtFixedRWidth({
  required String textl,
  required String textr,
  required double rWidth,
  required VoidCallback onPressed,
}) {
  return Container(
    child: Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Expanded(
          child: Container(
            child:
                // textContainer(text: textl,color: Colors.grey, continerAlign: Alignment.centerLeft),
                Container(
                    alignment: Alignment.topLeft,
                    child: Text(
                      textl,
                      //           maxLines: 1,
                      // overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.left,
                      style: TextStyle(fontSize: 14, color: Colors.grey),
                    )),
          ),
        ),
        Expanded(child: SizedBox()),
        InkWell(
          onTap: onPressed,
          child: Container(
            child: Row(
              children: [
                Container(
                    width: rWidth,
                    alignment: Alignment.topRight,
                    child: Text(
                      textr,
                      //           maxLines: 1,
                      // overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.right,
                      style: TextStyle(fontSize: 14, color: Colors.black),
                    )),

                // Container(
                //   alignment: Alignment.centerRight,
                //   child:
                //   imageCircular(w: 18, h: 18,
                //       radius: 0, image: "assets/images/copyIcon.png"),
                //   // buttonImage(
                //   //   w:18,
                //   //   h: 18,
                //   //   onPressed: onPressed,
                //   //   imageName: "assets/images/copyIcon.png", text: '',
                //   //   // al: Alignment.centerRight,
                //   // ),
                // ),
              ],
            ),
          ),
        )
      ],
    ),
  );
}

Widget ultimatelyLRCopyTxtFixedRWidth({
  required String textl,
  required String textr,
  required double rWidth,
  required VoidCallback onPressed,
}) {
  return Container(
    child: Row(
      children: <Widget>[
        Expanded(
          child: Container(
            child: textContainer(
                text: textl,
                color: Colors.grey,
                continerAlign: Alignment.centerLeft),
          ),
        ),
        Expanded(child: SizedBox()),
        InkWell(
          onTap: onPressed,
          child: Container(
            child: Row(
              children: [
                Container(
                    width: rWidth,
                    alignment: Alignment.centerRight,
                    child: Text(
                      textr,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.right,
                      style: TextStyle(fontSize: 14, color: Colors.black),
                    )),
                Container(
                  alignment: Alignment.centerRight,
                  child: imageCircular(
                      w: 18,
                      h: 18,
                      radius: 0,
                      image: "assets/images/public/copyIcon.png"),
                  // buttonImage(
                  //   w:18,
                  //   h: 18,
                  //   onPressed: onPressed,
                  //   imageName: "assets/images/copyIcon.png", text: '',
                  //   // al: Alignment.centerRight,
                  // ),
                ),
              ],
            ),
          ),
        )
      ],
    ),
  );
}

Widget ultimatelyLRForwardTxt({
  required String textl,
  required String textr,
  required Color lColor,
  required Color rColor,
  required VoidCallback onPressed,
}) {
  return InkWell(
      hoverColor: Colors.transparent,
      onTap: onPressed,
      child: Container(
        child: Row(
          children: <Widget>[
            Expanded(
              child: Container(
                child: textContainer(
                    text: textl,
                    color: lColor,
                    continerAlign: Alignment.centerLeft),
              ),
            ),
            Expanded(child: SizedBox()),
            Container(
              child: Row(
                children: [
                  Container(
                    alignment: Alignment.centerRight,
                    child: textContainer(
                        text: textr,
                        color: rColor,
                        continerAlign: Alignment.centerRight),
                  ),
                  Container(
                    alignment: Alignment.centerRight,
                    child: Icon(Icons.arrow_forward_ios,
                        color: Color(0xff999999), size: 12),

                    // imageCircular(w: 18, h: 18,
                    //     radius: 0, image: "assets/images/copyIcon.png"),

                    // buttonImage(
                    //     w:18,
                    //     h: 18,
                    //     onPressed: onPressed,
                    //     imageName: "assets/images/copyIcon.png", text: '',
                    //     // al: Alignment.centerRight,
                    //     ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ));
}

Widget ultimatelyLRCopyTxt({
  required String textl,
  required String textr,
  required VoidCallback onPressed,
}) {
  return Container(
    child: Row(
      children: <Widget>[
        Expanded(
          child: Container(
            child: textContainer(
                text: textl,
                color: Colors.grey,
                continerAlign: Alignment.centerLeft),
          ),
        ),
        Expanded(child: SizedBox()),
        InkWell(
          onTap: onPressed,
          child: Container(
            child: Row(
              children: [
                Container(
                  alignment: Alignment.centerRight,
                  child: textContainer(
                      text: textr,
                      color: Colors.black,
                      continerAlign: Alignment.centerRight),
                ),
                Container(
                  alignment: Alignment.centerRight,
                  child: imageCircular(
                      w: 18,
                      h: 18,
                      radius: 0,
                      image: "assets/images/public/copyIcon.png"),
                  // buttonImage(
                  //     w:18,
                  //     h: 18,
                  //     onPressed: onPressed,
                  //     imageName: "assets/images/copyIcon.png", text: '',
                  //     // al: Alignment.centerRight,
                  //     ),
                ),
              ],
            ),
          ),
        )
      ],
    ),
  );
}

Widget syBackgroundText({
  required String text,
  required double w,
  required double h,
  required Color backgroundColor,
  required Color textColor,
  double fontSize = 14,
  FontWeight fontWeight = FontWeight.normal,
}) {
  return Container(
      alignment: Alignment.center,
      height: h,
      width: w,
      decoration: BoxDecoration(color: backgroundColor),
      child: syText(
          text: text,
          // color: textColor,
          fontWeight: fontWeight,
          fontSize: fontSize));
}
