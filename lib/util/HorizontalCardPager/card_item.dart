import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

abstract class CardItem {
  Widget buildWidget(double diffPosition);
}

class ImageCarditem extends CardItem {
  final Widget image;

  ImageCarditem({required this.image});

  @override
  Widget buildWidget(double diffPosition) {
    return image;
  }
}

class IconTitleCardItem extends CardItem {
  final IconData iconData;
  final String text;
  final Color selectedBgColor;
  final Color noSelectedBgColor;
  final Color selectedIconTextColor;
  final Color noSelectedIconTextColor;

  IconTitleCardItem(
      {required this.iconData,
      required this.text,
      this.selectedIconTextColor = Colors.white,
      this.noSelectedIconTextColor = Colors.grey,
      this.selectedBgColor = Colors.blue,
      this.noSelectedBgColor = Colors.white});

  @override
  Widget buildWidget(double diffPosition) {
    double iconOnlyOpacity = 1.0;
    double iconTextOpacity = 0;

    if (diffPosition < 1) {
      iconOnlyOpacity = diffPosition;
      iconTextOpacity = 1 - diffPosition;
    } else {
      iconOnlyOpacity = 1.0;
      iconTextOpacity = 0;
    }

    return Container(
        child: Stack(
      fit: StackFit.expand,
      children: [
        Opacity(
          opacity: iconTextOpacity,
          child: Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                      color: Colors.black26,
                      offset: Offset(0, 4),
                      blurRadius: 6)
                ],
                color: selectedBgColor,
                borderRadius: BorderRadius.all(Radius.circular(4))),
            child: Column(
              children: [
                Expanded(
                  child: FittedBox(
                    fit: BoxFit.fill,
                    child: Icon(
                      iconData,
                      color: selectedIconTextColor,
                    ),
                  ),
                ),
                FittedBox(
                  fit: BoxFit.fitHeight,
                  child: Text(
                    text,
                    style:
                        TextStyle(fontSize: 15, color: selectedIconTextColor),
                  ),
                )
              ],
            ),
          ),
        ),
        Opacity(
          opacity: iconOnlyOpacity,
          child: Container(
            decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                      color: Colors.black26,
                      offset: Offset(0, 4),
                      blurRadius: 6),
                ],
                color: noSelectedBgColor,
                borderRadius: BorderRadius.all(Radius.circular(4))),
            padding: EdgeInsets.all(10),
            child: FittedBox(
              fit: BoxFit.fill,
              child: Icon(
                iconData,
                color: noSelectedIconTextColor,
              ),
            ),
          ),
        ),
      ],
    ));
  }
}

class ImageTitleSubTitleCardItem extends CardItem {
  final Widget imageWidget;
  final IconData iconData;
  final String text;
  final String subTitle;
  final Color selectedBgColor;
  final Color noSelectedBgColor;
  final Color titleSelectedIconTextColor;
  final Color selectedIconTextColor;
  final Color noSelectedIconTextColor;

  ImageTitleSubTitleCardItem(
      {
        required this.imageWidget,
        required this.iconData,
        required this.text,
        required this.subTitle,
        this.titleSelectedIconTextColor=const Color(0xff999999),
        this.selectedIconTextColor = Colors.black,
            // Colors.white,
        this.noSelectedIconTextColor = Colors.grey,
        this.selectedBgColor = Colors.blue,
        this.noSelectedBgColor = Colors.white});

  @override
  Widget buildWidget(double diffPosition) {
    double iconOnlyOpacity = 1.0;
    double iconTextOpacity = 0;

    if (diffPosition < 1) {
      iconOnlyOpacity = diffPosition;
      iconTextOpacity = 1 - diffPosition;
    } else {
      iconOnlyOpacity = 1.0;
      iconTextOpacity = 0;
    }

    return Container(
      // width: 400,
      // height: 400,
        child: Stack(
          // fit: StackFit.expand,
          children: [
            Opacity(
              opacity: iconTextOpacity,
              child: Container(
                // width: 400,
                // height: 400,
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/images/home/scrBgNormal.png"),
                    fit: BoxFit.fill,
                  ),

                    // boxShadow: [
                    //   BoxShadow(
                    //       color: Colors.black26,
                    //       offset: Offset(0, 4),
                    //       blurRadius: 6)
                    // ],
                    // color: selectedBgColor,
                    // borderRadius: BorderRadius.all(Radius.circular(4))

                ),
                child:

                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    // SizedBox(height: 3,),
                    // Expanded(
                    //   child: FittedBox(
                    //     fit: BoxFit.fill,
                    //     child:
                    //
                    //     Icon(
                    //       iconData,
                    //       color: selectedIconTextColor,
                    //     ),
                    //   ),
                    // ),
                    imageWidget,
                    SizedBox(height: 3,),
                    FittedBox(
                      fit: BoxFit.fitWidth,
                      child: Text(
                        text,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style:
                        TextStyle(fontSize: 15, color: titleSelectedIconTextColor,fontWeight: FontWeight.normal),
                      ),
                    ),
                    // SizedBox(height: 3,),
                    FittedBox(
                      fit: BoxFit.fitWidth,
                      child: Text(
                        subTitle,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style:
                        TextStyle(fontSize: 15, color: selectedIconTextColor),
                      ),
                    )
                  ],
                ),
              ),
            ),
            Opacity(
              opacity:
              iconOnlyOpacity,
              child: Container(
                // width: 400,
                // height: 400,
                decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("assets/images/home/scrBgSelected.png"),
                      fit: BoxFit.fill,
                    ),
                    // boxShadow: [
                    //   BoxShadow(
                    //       color: Colors.black26,
                    //       offset: Offset(0, 4),
                    //       blurRadius: 6),
                    // ],
                    // color: noSelectedBgColor,
                    borderRadius: BorderRadius.all(Radius.circular(4))
                ),
                padding: EdgeInsets.all(10),
                child://未选的text 隐藏，只现图
                // imageWidge,
                // // FittedBox(
                // //   fit: BoxFit.fill,
                // //   child: Icon(
                // //     iconData,
                // //     color: noSelectedIconTextColor,
                // //   ),
                // // ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    // SizedBox(height: 5-3.0,),
                    // Expanded(
                    //   child: FittedBox(
                    //     fit: BoxFit.fill,
                    //     child:
                    //
                    //     Icon(
                    //       iconData,
                    //       color: selectedIconTextColor,
                    //     ),
                    //   ),
                    // ),
                    imageWidget,
                    SizedBox(height: 3.0,),
                    FittedBox(
                      fit: BoxFit.fitWidth,
                      child:
                      Text(
                        text,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,

                        style:
                        TextStyle(fontSize: 14, color: titleSelectedIconTextColor,fontWeight: FontWeight.normal),
                      ),
                    ),
                    // SizedBox(height: 3.1,),
                    FittedBox(
                      fit: BoxFit.fitWidth,
                      child: Text(
                        subTitle,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style:
                        TextStyle(fontSize: 14, color: selectedIconTextColor),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ));
  }
}