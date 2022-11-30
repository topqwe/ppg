import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppTheme {
  static const backBtnGreyColor  = Color(0xff333333);
  static const themeGreyColor  = Color(0xff999999);
  static const themeHightColor  = Color(0xff1552F0);
  static const darkBg = Color.fromRGBO(21, 22, 26, 1);
  static const primary =  Color(0xff1552F0);
  static const themebtnColor  = themeHightColor;
  static const ScaffoldBackgroundColor  =Color(0xffEFF2F6);
  // Color(0xfff3f5f9);
  //ThemeData.light().scaffoldBackgroundColor
  static ThemeData theme() {
    return ThemeData(
      primaryColor: themeHightColor,
      buttonColor: themeHightColor,
      brightness:  Brightness.light,
      hoverColor: Colors.transparent,
      highlightColor: Colors.transparent,
      splashColor: Colors.transparent,
      appBarTheme: AppBarTheme(
        systemOverlayStyle: SystemUiOverlayStyle.dark,
        elevation: 0,
        backgroundColor: ScaffoldBackgroundColor,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      scaffoldBackgroundColor: ScaffoldBackgroundColor,
      backgroundColor: Colors.white,
      iconTheme: const IconThemeData(
        color: Colors.black,
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          selectedItemColor: themeHightColor,
          unselectedItemColor: Color(0xffAAAAAA)
      ),


      bottomAppBarColor:themeHightColor,
      errorColor:Colors.red,
      textSelectionTheme: TextSelectionThemeData(selectionColor: themeHightColor,cursorColor:themeHightColor),
      colorScheme: ColorScheme.fromSwatch().copyWith(secondary: Colors.black),
      textTheme: TextTheme(
        headline1: TextStyle(color: Colors.black),
        headline2: TextStyle(color: Colors.black),
        bodyText1: TextStyle(color: Colors.black),
        bodyText2: TextStyle(color: Colors.black),
      ),
      // hoverColor:Color(0xffFF833E),
    );
  }

  static ThemeData darkTheme() {
    return ThemeData(
      appBarTheme: AppBarTheme(
        systemOverlayStyle: SystemUiOverlayStyle.light,
        elevation: 0,
        backgroundColor: ThemeData.dark().scaffoldBackgroundColor,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      scaffoldBackgroundColor: ThemeData.dark().scaffoldBackgroundColor,
      backgroundColor: Colors.black,
      iconTheme: const IconThemeData(
        color: themeHightColor,
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        selectedItemColor: themeHightColor,
        unselectedItemColor: Color(0xffAAAAAA),
        backgroundColor: Colors.black,
      ),
    );
  }
}
