import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '/widgets/sizebox_widget.dart';
import '/widgets/image_widget.dart';
import '/widgets/button_widget.dart';
import '/widgets/text_widget.dart';

Widget noDataWidget(
    {MainAxisAlignment mainAxisAlignment = MainAxisAlignment.center,
   double topPadding = 0}) {
  return Container(
    alignment: Alignment.center,
    child: Column(
      mainAxisAlignment: mainAxisAlignment,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        sizeBoxPadding(w: 0, h: topPadding),
        // buttonText(w: 100, h: 100, text: '', onPressed: (){}),
        buttonImage(
          text: '',
          onPressed: (){},
            w: 212,
            h: 212,
            circular: 0,
            imageName: "assets/images/public/.png"),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            sizeBoxPadding(w: 5, h: 0),
            syText(text: '暂无记录'.tr,
                // color: Colors.black
            ),
          ],
        ),
      ],
    ),
  );
}

Widget noNetworkWidget(
    {MainAxisAlignment mainAxisAlignment = MainAxisAlignment.center,
      double topPadding = 0}) {
  return Container(
    alignment: Alignment.center,
    child: Column(
      mainAxisAlignment: mainAxisAlignment,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        sizeBoxPadding(w: 0, h: topPadding),
        // buttonText(w: 100, h: 100, text: '', onPressed: (){}),
        buttonImage(
            text: '',
            onPressed: (){},
            w: 212,
            h: 212,
            circular: 0,
            imageName: "assets/images/public/.png"),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            sizeBoxPadding(w: 5, h: 0),
            syText(text: '暂无记录'.tr,
              // color: Colors.black
            ),
          ],
        ),
      ],
    ),
  );
}

Widget noAddrDataWidget(
    {MainAxisAlignment mainAxisAlignment = MainAxisAlignment.center,
      double topPadding = 0}) {
  return Container(
    alignment: Alignment.center,
    child: Column(
      mainAxisAlignment: mainAxisAlignment,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        sizeBoxPadding(w: 0, h: topPadding),
        // buttonText(w: 100, h: 100, text: '', onPressed: (){}),
        buttonImage(
            text: '',
            onPressed: (){},
            w: 212,
            h: 212,
            circular: 0,
            imageName: "assets/images/public/.png"),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            sizeBoxPadding(w: 5, h: 0),
            syText(text: '去添加'.tr,
              // color: Colors.black
            ),
          ],
        ),
      ],
    ),
  );
}

Widget noDataListWidget(
    {MainAxisAlignment mainAxisAlignment = MainAxisAlignment.center,
   double topPadding = 0}) {
  return  Container(
        //WarmingS contain as Column tags
        // color: Colors.white,//BoxDecoration col
        width: double.infinity,
        // height: 50,
        alignment: Alignment.topCenter,
        padding: const EdgeInsets.only(left: 10, right: 10),
        // padding: EdgeInsets.only(left: padding(), right: padding()),
        decoration: const BoxDecoration(
          color: Colors.white,
          // borderRadius: BorderRadius.only(
          //     bottomRight: Radius.circular(20.0),
          //     bottomLeft: Radius.circular(20.0)),
        ),
        // child: ClipRRect(
        //   borderRadius: const BorderRadius.all(Radius.circular(20)),
        child: Column(
          children: <Widget>[
            ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              itemExtent: 50,
              shrinkWrap: true,
              itemCount: 7,
              itemBuilder: (BuildContext context, int index) {
                return Image.asset(
                  "assets/images/public/cell.png",
                  fit: BoxFit.fill,
                  height: 60,
                );
              },
            ),
            sizeBoxPadding(w: 0, h: 20),
            // if (widget.isHiddenMore == false) MarketBV(),
          ],
        ),
      )
          // ),
          ;
}

 