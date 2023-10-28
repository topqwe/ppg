/*
 *  Copyright (C), 2015-2021
 *  FileName: default_appbar
 *  Author: Tonight丶相拥
 *  Date: 2021/3/11
 *  Description: 
 **/

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../widgets/text_widget.dart';

import 'CustomBackButton.dart';

class DefaultAppBar extends AppBar {
  DefaultAppBar({
    Key? key,
    Widget leading = const CustomBackButton(),
    bool automaticallyImplyLeading = true,
    Widget? title,
    String titleStr = "",
    List<Widget>? actions,
    Widget? flexibleSpace,
    PreferredSizeWidget? bottom,
    double? elevation,
    Color? shadowColor,
    ShapeBorder? shape,
    Color? backgroundColor,
    Color? foregroundColor,
    Brightness? brightness = Brightness.light,
    IconThemeData? iconTheme,
    IconThemeData? actionsIconTheme,
    TextTheme? textTheme,
    bool primary = true,
    bool? centerTitle = true,
    bool excludeHeaderSemantics = false,
    double? titleSpacing,
    double toolbarOpacity = 1.0,
    double bottomOpacity = 1.0,
    double? toolbarHeight,
    double? leadingWidth,
    bool? backwardsCompatibility,
    TextStyle? toolbarTextStyle,
    TextStyle? titleTextStyle,
    // SystemUiOverlayStyle? systemOverlayStyle = SystemUiOverlayStyle.light
  }) : super(
          key: key,
          leading: leading,
          automaticallyImplyLeading: automaticallyImplyLeading,
          title: title ??
              syText(fontSize: 20, color: Colors.black, text: titleStr),
          flexibleSpace: flexibleSpace,
          bottom: bottom,
          elevation: elevation,
          shadowColor: shadowColor,
    shape: shape ??
        Border(
            bottom: BorderSide(color: Color(0xffF6F6F6), width: 0.5)),
    backgroundColor: backgroundColor ?? Colors.white,
          foregroundColor: foregroundColor,
          // brightness: brightness,
          iconTheme: iconTheme,
          actions: actions,
          actionsIconTheme: actionsIconTheme,
          // textTheme: textTheme,
          primary: primary,
          centerTitle: centerTitle,
          excludeHeaderSemantics: excludeHeaderSemantics,
          titleSpacing: titleSpacing,
          toolbarOpacity: toolbarOpacity,
          bottomOpacity: bottomOpacity,
          toolbarHeight: toolbarHeight,
          leadingWidth: leadingWidth,
          // backwardsCompatibility: backwardsCompatibility,
          toolbarTextStyle: toolbarTextStyle,
          titleTextStyle: titleTextStyle,
          // systemOverlayStyle: systemOverlayStyle
        );
}
