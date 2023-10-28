import 'dart:convert';
import 'dart:io';
import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:jpush_flutter/jpush_flutter.dart';
import 'package:liandan_flutter/router/RouteConfig.dart';
import 'package:liandan_flutter/services/response/ws_message.dart';
import 'package:liandan_flutter/store/AppCacheManager.dart';
import 'package:liandan_flutter/store/EventBus.dart';
import 'package:liandan_flutter/style/theme.dart';
import 'package:loggy/loggy.dart';

import 'AppController.dart';
import 'lang/LanguageManager.dart';
import 'lang/translation_service.dart';
import 'services/cache/storage.dart';

Future ensureApp() async {
  return null;
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  final LanguageManager languageManager = LanguageManager.instance;
  @override
  Widget build(BuildContext context) {
    if (Platform.isAndroid) {
      JPush().setup(appKey: "JPushKey", debug: true);
      JPush().addEventHandler(
        onOpenNotification: (event) async {
          dynamic extra = event["extras"];
          String? androidExtraJson = extra["cn.jpush.android.EXTRA"] as String?;
          Map<String, dynamic>? androidExtra =
              jsonDecode(androidExtraJson ?? "{}");
          logInfo(androidExtra);
          Map<String, dynamic> msg = {
            "msg": event["alert"],
            "notifyType": int.parse(androidExtra?["notifyType"] ?? "1000"),
            "orderId": androidExtra?["orderId"],
            "marketOrderId": androidExtra?["marketOrderId"],
          };
          WsMessage msgModel = WsMessage.fromJson(msg);
          mainEventBus.emit(
            EventBusConstants.handleNotificationTapEvent,
            msgModel,
          );
        },
      );
      JPush().getRegistrationID().then((value) {
        logInfo("pushID $value");
      });
    }

    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarIconBrightness: Brightness.light,
      // systemNavigationBarColor:Colors.green,//bottom safeArea
      // systemNavigationBarDividerColor:Colors.red,
      statusBarColor: Colors.transparent,
      statusBarBrightness: Brightness.light,
      // statusBarColor: Colors.transparent, // transparent status bar
      // statusBarBrightness: Brightness.dark,
      // statusBarIconBrightness: Brightness.dark,
      // systemNavigationBarColor: Colors.white,
      // systemNavigationBarIconBrightness: Brightness.dark,
    ));
    // if (Platform.isAndroid) {
    // } else {
    //   SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    //     statusBarColor: Colors.transparent, // transparent status bar
    //   ));
    // }

    return ScreenUtilInit(
      designSize: const Size(375, 812),
      builder: (BuildContext context, Widget? child) {
        EasyRefresh.defaultHeaderBuilder = () => const CupertinoHeader();
        EasyRefresh.defaultFooterBuilder = () => const CupertinoFooter();
        return GetMaterialApp(
          title: 'AppName',
          // navigatorKey: .navigatorKey,
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
          // onGenerateRoute: appRoute.generateRoute,
          initialRoute:AppCacheManager.instance.getUserToken().isNotEmpty? RouteConfig.index:RouteConfig.login,
          getPages: RouteConfig.getPages,
          builder: EasyLoading.init(),
          // builder: (context, child) {
            // return MediaQuery(
            //   // 设置文字大小不随系统设置改变
            //   data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
            //   child: child ?? const SizedBox.shrink(),
            // );
          // },
          // home: const LoginPage(),
        );
      },
    );
  }
}
