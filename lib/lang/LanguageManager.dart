
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../store/AppCacheManager.dart';

class LanguageManager  {

  static LanguageManager? _instance;
  static LanguageManager get instance => _instance ?? _getInstance();

  LanguageManager._(){
    String? local = AppCacheManager.instance.getAppLanguage();
    print("${local.toString()}");
    if(local != null){
      currentLocale = getLocaleByLanguageCode(local);
    }else{
      Locale? locale = Get.deviceLocale;
      if(locale != null && showLanguagesMap.containsKey(locale.countryCode)){

        currentLocale = locale;
      }else{
        currentLocale = defaultLocal;
      }
    }
  }

  static LanguageManager _getInstance(){
    _instance = LanguageManager._();
    return _instance!;
  }

  late Locale currentLocale = Locale("en","US");

  Locale defaultLocal = Locale("en","US");

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en',countryCode: "US"),
      // Locale.fromSubtags(languageCode: 'zh',countryCode: "CN"),
      Locale.fromSubtags(languageCode: 'zh',countryCode: "HK"),
    ];
  }

  final Map<String,String> showLanguagesMap = {
    "US":"English",
    // "CN":"中文",
    "HK":"繁體中文"
  };


  void changeLanguage(String countryStr){


    //先获取countryCode
    String? countryCode;
    List<MapEntry<String, String>> iterableList = showLanguagesMap.entries.toList();
    for(MapEntry<String, String> map in iterableList){
      if(map.value == countryStr){
        countryCode = map.key;
        break;
      }
    }
    if(countryCode == null){
      return;
    }

    print("type:"+countryCode.toString());
    List<Locale>  locales = supportedLocales;
    for(Locale locale in locales){
      print("locale.countryCode==="+locale.countryCode.toString());
      if(locale.countryCode == countryCode){
        print("locale.countryCode1==="+locale.countryCode.toString());
        print("locale.languageCode==="+locale.languageCode.toString());

        Get.updateLocale(locale);
        currentLocale = getLocaleByLanguageCode(locale.toString());

        // currentLocale.refresh();

        // print("locale.toString()===="+locale.toString());
        AppCacheManager.instance.setAppLanguage(locale.toString());

        break;
      }

    }
    //刷新页面语言
    // _language.refresh();


  }

  Locale getLocaleByLanguageCode(String languageCode) {
    for(Locale locale in supportedLocales){
      if(languageCode.contains(locale.toString())){
        return locale;
      }
    }
    return defaultLocal;
  }


  String? get currentLanguageStr {
    return showLanguagesMap[currentLocale.countryCode];
  }

  String? get currentLanguageRequestParam {
    String lang = 'en';
    if(
    '${LanguageManager.instance.currentLocale}'.contains('en_')
// '${Get.locale}'.contains('en_')
    ){
      lang = 'en';
    }else{
      lang = 'zh-CN';
    }
    return lang;
  }


}