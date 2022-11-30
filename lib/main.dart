import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../store/AppCacheManager.dart';
import '../router/RouteConfig.dart';
import 'style/theme.dart';
import 'lang/LanguageManager.dart';
import 'lang/translation_service.dart';

Future<void> main() async {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarIconBrightness: Brightness.light,
    // systemNavigationBarColor:Colors.green,//bottom safeArea
    // systemNavigationBarDividerColor:Colors.red,
    statusBarColor: Colors.white,
    statusBarBrightness: Brightness.light,
  ));
  await GetStorage.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final LanguageManager languageManager = LanguageManager.instance;

  // MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (BuildContext context, Widget? child) {
        return GetMaterialApp(
          defaultTransition:
              GetPlatform.isAndroid ? Transition.downToUp : Transition.native,
          debugShowCheckedModeBanner: false,
          //主题
          // themeMode: ThemeMode.system,
          themeMode: ThemeMode.light,
          theme: AppTheme.theme(),
          darkTheme: AppTheme.darkTheme(),
          supportedLocales: languageManager.supportedLocales,
          localizationsDelegates: [...GlobalMaterialLocalizations.delegates],
          //多语言
          locale: languageManager.currentLocale,
          fallbackLocale: languageManager.defaultLocal,
          translations: TranslationService(),

          initialRoute:RouteConfig.login,
          getPages: RouteConfig.getPages,
          builder: EasyLoading.init(),
        );
      },
    );
    //AppCacheManager.instance.getUserToken().isNotEmpty? RouteConfig.index:
    return GetMaterialApp(
      initialRoute: RouteConfig.index,
      getPages: RouteConfig.getPages,
    );
  }
}
