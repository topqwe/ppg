import 'package:flutter/material.dart';
import '../../widgets/sizebox_widget.dart';
import '../widgets/text_widget.dart';
import 'package:tapped/tapped.dart';
import '../style/theme.dart';
import 'image_widget.dart';
Widget ButtonBordor({
  required String text,
  required VoidCallback onPressed,
  double w = 300,
  double? h = 40,
  TextStyle style = const TextStyle(
    color: Color.fromARGB(255, 0, 0, 0),
    fontWeight: FontWeight.normal,
    fontSize: 14,
    inherit: true,
  ),
  Alignment al = Alignment.center,
  Color bordercolor = AppTheme.themebtnColor,
  //Color overlayColor = Colors.transparent,
}) {
  return Container(
    //color: ColorPlate.,
      alignment: al,
      height: h,
      // padding: EdgeInsets.all(5),
      child: GestureDetector(
        child: Container(
          width: w,

          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.2),
            borderRadius: BorderRadius.circular(4),
            border: Border.all(
              style: BorderStyle.solid,
              color: bordercolor,
              width: 1,
            ),
          ),
          // color: Colors.black.withOpacity(0),
          // padding: EdgeInsets.fromLTRB(4, 0, 4, 4),
          alignment: Alignment.center,
          child: Text(text,style: style,),
        ),
        onTap: onPressed,
      ));
}
//图片按钮
Widget buttonImage({
  required double w,
  required double h,
  required String imageName,
  required String text,
  required VoidCallback onPressed,
  Color textColor = Colors.black,
  double fontSize = 14,
  double circular = 0,
  Color backgroundColor = Colors.transparent,
}) {
  return ClipRRect(
    borderRadius: BorderRadius.circular(circular),
    child: Container(
      width: w,
      height: h,
      decoration: BoxDecoration(
        color: backgroundColor,
        image: DecorationImage(image: AssetImage(imageName), fit: BoxFit.fill),
      ),
      alignment: Alignment.center,
      // child: FlatButton(
      //   onPressed: onPressed,
      //   child: Text(
      //     text,
      //     style: TextStyle(
      //       color: textColor,
      //       fontSize: fontSize,
      //       fontWeight: FontWeight.normal,
      //     ),
      //   ),
      //   color: Colors.transparent,
      // ),
      child: Row(
        children: <Widget>[
          Expanded(
            child: TextButton(
              style: ButtonStyle(
                overlayColor: MaterialStateProperty.all(Colors.transparent),
              ),
              child: Text(
                text,
                style: TextStyle(
                  color: textColor,
                  fontSize: fontSize,
                  fontWeight: FontWeight.normal,
                ),
              ),
              onPressed: onPressed,
            ),
          ),
        ],
      ),
    ),
  );
}
Widget buttonPaddingImage({
  required double imageW,
  required double imageH,
  required String image,
  required VoidCallback onPressed,
  double leftPadding = 0,
  double rightPadding = 0,
  double topPadding = 0,
  double bottomPadding = 0,
}) {
  return InkWell(
    onTap: onPressed,
    child: Container(
      padding: EdgeInsets.only(
          left: leftPadding,
          right: rightPadding,
          bottom: bottomPadding,
          top: topPadding),
      child: imageCircular(
        w: imageW,
        h: imageH,
        radius: 0,
        image: image,
      ),
    ),
  );
}

class MyButton extends StatelessWidget {

  const MyButton({
    Key? key,
    this.text = '',
    this.fontSize = 18,
    this.textColor,
    this.disabledTextColor,
    this.backgroundColor,
    this.disabledBackgroundColor,
    this.minHeight = 48.0,
    this.minWidth = double.infinity,
    this.padding = const EdgeInsets.symmetric(horizontal: 16.0),
    this.radius = 2.0,
    this.side = BorderSide.none,
    required this.onPressed,
  }): super(key: key);

  final String text;
  final double fontSize;
  final Color? textColor;
  final Color? disabledTextColor;
  final Color? backgroundColor;
  final Color? disabledBackgroundColor;
  final double? minHeight;
  final double? minWidth;
  final VoidCallback? onPressed;
  final EdgeInsetsGeometry padding;
  final double radius;
  final BorderSide side;

  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: onPressed,
        style: ButtonStyle(
          // 文字颜色
          foregroundColor: MaterialStateProperty.resolveWith((states) {
            if (states.contains(MaterialState.disabled)) {
              return disabledTextColor ?? ( Colors.grey);
            }
            return textColor ?? ( Colors.white);
          },
          ),
          // 背景颜色
          backgroundColor: MaterialStateProperty.resolveWith((states) {
            if (states.contains(MaterialState.disabled)) {
              return disabledBackgroundColor ?? ( Colors.grey);
            }
            return backgroundColor ?? ( AppTheme.themeHightColor);
          }),
          // 水波纹
          overlayColor: MaterialStateProperty.resolveWith((states) {
            return (textColor ?? ( Colors.white)).withOpacity(0.12);
          }),
          // 按钮最小大小
          minimumSize: (minWidth == null || minHeight == null) ? null : MaterialStateProperty.all<Size>(Size(minWidth!, minHeight!)),
          padding: MaterialStateProperty.all<EdgeInsetsGeometry>(padding),
          shape: MaterialStateProperty.all<OutlinedBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(radius),
            ),
          ),
          side: MaterialStateProperty.all<BorderSide>(side),
        ),
        child: Text(text, style: TextStyle(fontSize: fontSize),)
    );
  }
}

Widget buttonText({
  required double w,
  required double h,
  required String text,
  required VoidCallback onPressed,
  Color overlayColor = Colors.transparent,
  Color borderColor = Colors.transparent,
  Color backgroundColor = Colors.transparent,
  Color textColor = Colors.black, //AppColors.textBlack,
  double textSize = 14,
  double radius = 0,
  TextAlign textAlign = TextAlign.center,
  Alignment alignmentGeometry = Alignment.center,
  FontWeight fontWeight = FontWeight.normal,
}) {
  return Container(
    alignment: alignmentGeometry,
    decoration: BoxDecoration(
      border: Border.all(color: borderColor),
      borderRadius: BorderRadius.circular(radius),
      color: backgroundColor,
    ),
    width: w,
    height: h,
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Expanded(
          child: TextButton(
            style: ButtonStyle(
              overlayColor: MaterialStateProperty.all(overlayColor),
            ),
            child: Text(
              text,
              textAlign: textAlign,
              style: TextStyle(
                  color: textColor,
                  fontSize: textSize, //setSp(textSize)
                  fontWeight: fontWeight),
            ),
            onPressed: onPressed,
          ),
        ),
      ],
    ),
  );
}

Widget funcButtonText({
  required String text,
  required Function onPressed,
  double w = double.infinity,
  double h = 44,
  Color overlayColor = Colors.transparent,
  Color borderColor = Colors.transparent,
  Color backgroundColor = AppTheme.themeHightColor,
  Color textColor = Colors.white, //AppColors.textBlack,
  double textSize = 14,
  double radius = 4,
  TextAlign textAlign = TextAlign.center,
  Alignment alignmentGeometry = Alignment.center,
  FontWeight fontWeight = FontWeight.normal,
}) {
  return Container(
    alignment: alignmentGeometry,
    decoration: BoxDecoration(
      border: Border.all(color: borderColor),
      borderRadius: BorderRadius.circular(radius),
      color: backgroundColor,
    ),
    width: w,
    height: h,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Expanded(
          child: buttonText(
              textColor: textColor,
              w: w,
              h: h,
              text: text,
              onPressed: () {
                onPressed();
              },
              radius: radius),
        ),
      ],
    ),
  );
}
///左图
Widget buttonLeftImage({
  required double imageW,
  required double imageH,
  required String image,
  required VoidCallback onPressed,
  double topPadding = 0,
  String text = "",
  Color textColor = Colors.black,
  double textSize = 14,
  TextAlign textAlign = TextAlign.center,
  Alignment alignmentGeometry = Alignment.center,
  FontWeight fontWeight = FontWeight.normal,
}) {
  return InkWell(
    onTap: onPressed,
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        sizeBoxPadding(w: 0, h: topPadding),
        imageCircular(w: imageW, h: imageH, radius: 0, image: image),
        sizeBoxPadding(w: 5, h: 0),
        Text(
          text,
          textAlign: textAlign,
          style: TextStyle(
              color: textColor,
              fontSize: textSize,
              fontWeight: fontWeight),
        ),
      ],
    ),
  );
}

Widget sliverSectionHeadAction(
  String text,
  VoidCallback onTap, {
  Color borderColor = Colors.transparent,
  Color backgroundColor = Colors.transparent,
  Color textColor = Colors.black,
}) {
  return SliverToBoxAdapter(
    child: InkWell(
        hoverColor: Colors.transparent,
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.only(left: 15, right: 15),
          // padding: EdgeInsets.only(left: padding(), right: padding()),
          alignment: Alignment.center,
          height: 40,
          width: double.infinity,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Expanded(child:
              textContainer(
                  text: text,
                  textAlign: TextAlign.left,
                  continerAlign: Alignment.centerLeft),
              // ),
              Expanded(child: SizedBox()),
              arrowForward(size: 13),
            ],
          ),
        )),
  );
}

Widget sliverSectionFootFuncBtn(
  String text,
  Function onPressed, {
  Color borderColor = Colors.transparent,
  Color backgroundColor = AppTheme.themeHightColor,
  Color textColor = Colors.white,
}) {
  return SliverToBoxAdapter(
    child: Container(
        padding: const EdgeInsets.only(left: 15, right: 15),
        // padding: EdgeInsets.only(left: padding(), right: padding()),
        alignment: Alignment.centerLeft,
        height: 44,
        width: double.infinity,
        child: funcButtonText(
          borderColor: borderColor,
          backgroundColor: backgroundColor,
          textColor: textColor,
          text: text,
          onPressed: onPressed,
        )),
  );
}

Widget customFootFuncBtn(
  String text,
  Function onPressed, {
  double paddinglf = 15,
  double marginlr = 15,
  double margintb = 13,
  Color borderColor = Colors.transparent,
  Color containerBgColor = Colors.white,
  Color backgroundColor = AppTheme.themeHightColor,
  Color textColor = Colors.white,
}) {
  return Container(
      color: containerBgColor,
      // padding:  EdgeInsets.only(left: paddinglf,right: paddinglf),
      margin: EdgeInsets.only(
          left: marginlr, right: marginlr, top: margintb, bottom: margintb),
      // padding: EdgeInsets.only(left: padding(), right: padding()),
      alignment: Alignment.center,
      // height: 44+2*13,
      width: double.infinity,
      child: funcButtonText(
        borderColor: borderColor,
        backgroundColor: backgroundColor,
        textColor: textColor,
        text: text,
        onPressed: onPressed,
      ));
}

Widget rowImgTxtCheckBox({
  required String textl,
  required String textr,
  required VoidCallback onPressed,
  required String urlL,
  required String urlR,
  double w = 20, //= StandardTextStyle.smallgray,

  bool check = true,
}) {
  Widget wcheck = Container();
  if(check) {
    wcheck =Icon(Icons.check_box_rounded,
        color: AppTheme.primary, size: 20);
  }
  else {
    wcheck =Icon(Icons.check_box_outline_blank_rounded,
        color: AppTheme.themeGreyColor, size: 20);
  }

  // if (check) {
  //   wcheck = imageCircular(
  //     w: 33 / 2,
  //     h: 26 / 2,
  //     radius: 0,
  //     fit: BoxFit.fill,
  //     image: urlR,
  //   );
  // }
  // else{
  //   wcheck = Container(
  //     width: 33 / 2,
  //     height: 26 / 2,
  //     color: Colors.cyanAccent,
  //     // radius: 0,
  //     // fit: BoxFit.fill,
  //     // image: urlR,
  //   );
  // }

  return Container(
      padding: EdgeInsets.only(left: 15, right: 15),
      child: Tapped(
        child: Row(
          children: <Widget>[
            Expanded(
              child: Container(
                child: Row(
                  children: [
                    imageCircularNoH(radius: 0, image: urlL, w: 30),
                    const SizedBox(width: 15),
                    syText(text: textl, textAlign: TextAlign.left),
                  ],
                ),
              ),
            ),
            const SizedBox(width: 5),
            wcheck,
          ],
        ),
        onTap: onPressed,
      ));
}

Widget rowImgTxtImg({
  required String textl,
  required String textr,
  required VoidCallback onPressed,
  required String urlL,
  required String urlR,
  double w = 20, //= StandardTextStyle.smallgray,

  bool check = true,
}) {
  Widget wcheck = Container();
  // if(check) {
  //   wcheck =Icon(Icons.check_box_rounded,
  //       color: AppTheme.primary, size: 20);
  // }
  // else {
  //   wcheck =Icon(Icons.check_box_outline_blank_rounded,
  //       color: AppTheme.themeGreyColor, size: 20);
  // }

  if (check) {
    wcheck = imageCircular(
      w: 33 / 2,
      h: 26 / 2,
      radius: 0,
      fit: BoxFit.fill,
      image: urlR,
    );
  }
  // else{
  //   wcheck = Container(
  //     width: 33 / 2,
  //     height: 26 / 2,
  //     color: Colors.cyanAccent,
  //     // radius: 0,
  //     // fit: BoxFit.fill,
  //     // image: urlR,
  //   );
  // }

  return Container(
      padding: EdgeInsets.only(left: 15, right: 15),
      child: Tapped(
        child: Row(
          children: <Widget>[
            Expanded(
              child: Container(
                child: Row(
                  children: [
                    imageCircularNoH(radius: 0, image: urlL, w: 30),
                    const SizedBox(width: 15),
                    syText(text: textl, textAlign: TextAlign.left),
                  ],
                ),
              ),
            ),
            const SizedBox(width: 5),
            wcheck,
          ],
        ),
        onTap: onPressed,
      ));
}

Widget arrowBackBtn(
  VoidCallback onPressed, {

  Color backgroundColor = const Color(0xff333333),
}) {
  return IconButton(
    // padding: EdgeInsets.only(left: 0),
    // alignment: Alignment.centerLeft,
    color: backgroundColor,
    icon: Icon(Icons.arrow_back_ios,
        color: backgroundColor, size: 20), //, size: 14
    iconSize: 20,
    onPressed: onPressed,
  );
}

Widget arrowForwardBtn(
  VoidCallback onPressed, {
  Color backgroundColor = Colors.transparent,
}) {
  return IconButton(
    padding: EdgeInsets.only(right: 0),
    alignment: Alignment.centerRight,
    color: Color(0xff999999),
    icon: Icon(Icons.arrow_forward_ios, color: Color(0xff999999), size: 15),
    iconSize: 15,
    onPressed: onPressed,
  );
}

Widget arrowForward(
    {Color backgroundColor = Colors.transparent, double size = 15}) {
  return Icon(Icons.arrow_forward_ios, color: Color(0xff999999), size: size);
}
