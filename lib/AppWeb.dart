import 'dart:convert';
import 'dart:html' as html;

import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:liandan_flutter/router/RouteConfig.dart';
import 'package:liandan_flutter/services/api/Singleton.dart';
import 'package:liandan_flutter/services/cache/storage.dart';
import 'package:liandan_flutter/services/response/response_info_user.dart';
import 'package:liandan_flutter/store/AppCacheManager.dart';
import 'package:liandan_flutter/style/theme.dart';
import 'package:loggy/loggy.dart';
import 'AppController.dart';
import 'lang/LanguageManager.dart';
import 'lang/translation_service.dart';

String search = html.window.location.href; //window.location.search ?? "";

Future ensureApp() async {
  if (kDebugMode) {
    // search = '';
  }
  if (search.isNotEmpty) {
    search = Uri.decodeComponent(search).toString();
    if (search.contains("register") ) {
      SpUtil().clearUserData(closeWs: false);
    }
    Map<String, dynamic> data = {};
    List selecterfunf = search.split('?');
    Uri uri = Uri.parse(search);
    if (selecterfunf.length > 1) {
      data = uri.queryParameters;
      // logInfo(data);
      print('weeeeeeb');
      print(data);
      print(search);
      if (search.contains(RouteConfig.login)
      ) {
        String? token = data["token"] as String?;
        String? userInfo = data["userInfo"] as String?;
        logInfo(userInfo);
        if (token != null) {
          AppCacheManager.instance.setUserToken(token);
          SpUtil().saveToken(token);
        }
        if (userInfo != null) {
          userInfo = userInfo.replaceAll(" ", "+");
          String decodedData = utf8.decode(base64.decode(userInfo));
          Map<String, dynamic> decodedMap = json.decode(decodedData);
          ResInfoUser userInfoM = ResInfoUser.fromJson(decodedMap);
          AppCacheManager.instance.setValueForKey(kUserInfo, decodedMap);
          SpUtil().saveUserInfo(userInfoM);
          Future.delayed(const Duration(milliseconds: 300), () {
            Get.toNamed(RouteConfig.mallDetail) ;
          });
        }

      } else {
        Singleton.getInstance().data = data;
      }
    }
  }
  return null;
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  final LanguageManager languageManager = LanguageManager.instance;
  @override
  Widget build(BuildContext context) {

    String? getInitialRoute() {
      if (Singleton.getInstance().data.isEmpty) {
        if (search.contains(RouteConfig.register)) {
          return RouteConfig.register;
        }
      }
      return AppCacheManager.instance.getUserToken().isNotEmpty? RouteConfig.index:RouteConfig.login;
    }

    return ScreenUtilInit(
      designSize: const Size(375, 812),
      builder: (BuildContext context, Widget? child) {
        EasyRefresh.defaultHeaderBuilder = () => const CupertinoHeader();
        EasyRefresh.defaultFooterBuilder = () => const CupertinoFooter();
        return GetMaterialApp(
          title: 'AppName',
          debugShowCheckedModeBanner: false,

          initialBinding: AppBinding(),
          themeMode: ThemeMode.light,
          theme: AppTheme.theme(),
          darkTheme: AppTheme.darkTheme(),
          // theme: ThemeData(
          //   primaryColor: AppTheme.primary,
          //   pageTransitionsTheme: PageTransitionsTheme(
          //     builders:
          //         Map<TargetPlatform, PageTransitionsBuilder>.fromIterable(
          //       TargetPlatform.values,
          //       value: (dynamic _) =>
          //           const CupertinoPageTransitionsBuilder(), //applying old animation
          //     ),
          //   ),
          // ),
          supportedLocales: languageManager.supportedLocales,
          localizationsDelegates: [...GlobalMaterialLocalizations.delegates],
          //多语言
          locale: languageManager.currentLocale,
          fallbackLocale: languageManager.defaultLocal,
          translations: TranslationService(),
          initialRoute:
          getInitialRoute(),
          // AppCacheManager.instance.getUserToken().isNotEmpty? RouteConfig.index:RouteConfig.login,
          getPages: RouteConfig.getPages,
          builder: EasyLoading.init(),
          // builder: (context, child) {
          //   return MediaQuery(
          //     // 设置文字大小不随系统设置改变
          //     data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
          //     child: child ?? const SizedBox.shrink(),
          //   );
          // },
          // home: const LoginPage(),
        );
      },
    );
  }
}
