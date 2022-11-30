import 'dart:ui';
import 'package:get/get.dart';
import 'zh_HK.dart';
import 'en_US.dart';

class TranslationService extends Translations {
  static Locale? get locale => Get.deviceLocale;
  // final locale = Locale('en', 'US');
  static final fallbackLocale = Locale('en', 'US');
  @override
  Map<String, Map<String, String>> get keys => {
    'en_US': en_US,
    // 'zh_CN': zh_Hans,
    'zh_HK': zh_HK,
  };
}