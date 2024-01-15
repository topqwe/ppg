import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:liandan_flutter/MainApp.dart';
import 'package:liandan_flutter/services/cache/storage.dart';
import 'package:liandan_flutter/services/env/configEnv.dart';
import 'package:liandan_flutter/services/newReq/http.dart';
import 'package:liandan_flutter/services/request/http_utils.dart';
import 'package:liandan_flutter/widgets/helpTools.dart';
import 'package:loggy/loggy.dart';
import 'package:yaml/yaml.dart';
import '../store/AppCacheManager.dart';
import '../router/RouteConfig.dart';
import 'style/theme.dart';
import 'lang/LanguageManager.dart';
import 'lang/translation_service.dart';
import 'package:platform_device_id/platform_device_id.dart';
import '../vendor/platform/platform_universial.dart'
if (dart.library.io) '../vendor/platform/platform_native.dart'
if (dart.library.html) '../vendor/platform/platform_web.dart'
as platformutil;

const bool currentEnvIsProd = true;
ConfigEnv configEnv = currentEnvIsProd ? ConfigEnv() : ConfigEnv.dev();
String? latestServerTime;
// class MyHttpOverrides extends HttpOverrides {
//   @override
//   HttpClient createHttpClient(SecurityContext? context) {
//     var http = super.createHttpClient(context);
//     http.findProxy = (uri) {
//       return 'PROXY ';
//     };
//     http.badCertificateCallback =
//         (X509Certificate cert, String host, int port) => true;
//     return http;
//   }
// }
Future<void> main() async {
  // HttpOverrides.global = MyHttpOverrides();
  WidgetsFlutterBinding.ensureInitialized();
  Loggy.initLoggy(
    logPrinter: const PrettyPrinter(showColors: true),
    logOptions: const LogOptions(kDebugMode ? LogLevel.all : LogLevel.off),
  );
  // SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
  //   statusBarIconBrightness: Brightness.light,
  //   // systemNavigationBarColor:Colors.green,//bottom safeArea
  //   // systemNavigationBarDividerColor:Colors.red,
  //   statusBarColor: Colors.white,
  //   statusBarBrightness: Brightness.light,
  // ));


  String yamlInfo = await rootBundle.loadString("pubspec.yaml");
  var yaml = loadYaml(yamlInfo);
  String yamlVersion = yaml["version"];
  List<String> res = yamlVersion.split("+");
  yamlVersion = res.first;
  configEnv.localversion = yamlVersion;
  print(configEnv.localversion);

  await GetStorage.init();
  await SpUtil().init();
  SpUtil().getLocalStorage();
  String? result = await PlatformDeviceId.getDeviceId;
  SpUtil().setString(kDeviceId, result.toString());
  if (configEnv.autoChangeDomain) {
    String? localUrl = AppCacheManager.instance.getCurrentDomainKey();
    SpUtil().getString(currentDomainKey);
    if ((localUrl ?? "").isNotEmpty) {
      configEnv.appBaseUrl = localUrl ?? configEnv.appBaseUrl;
    }
  }
  // HttpUtil.init(baseUrl: configEnv.appBaseUrl);
  HttpV1().init(baseUrl: configEnv.appBaseUrl);


  platformutil.PlatformUtils.configServiceAfterAppLaunch();
  // Future.delayed(const Duration(milliseconds: 200), () {
  //   fetchOSSDomainList();
  // });


  // runApp(MyApp());
  mainApp();
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

          initialRoute:AppCacheManager.instance.getUserToken().isNotEmpty? RouteConfig.index:RouteConfig.login,
          getPages: RouteConfig.getPages,
          builder: EasyLoading.init(),
        );
      },
    );
    //AppCacheManager.instance.getUserToken().isNotEmpty? RouteConfig.index:
    // return GetMaterialApp(
    //   initialRoute: RouteConfig.index,
    //   getPages: RouteConfig.getPages,
    // );
  }
}
