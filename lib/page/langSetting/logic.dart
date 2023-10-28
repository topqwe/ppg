import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../../services/responseHandle/request.dart';
import '../../store/AppCacheManager.dart';
import '../../lang/LanguageManager.dart';
import '../../store/EventBus.dart';

class HomeListItem {
  String title;
  String describe;
  String img;
  int index;
  bool isChecked;

  HomeListItem(this.title, this.describe, this.img, this.index, this.isChecked);
}

List<HomeListItem> getHomeLists() {
  List<HomeListItem> tradeList = <HomeListItem>[
    HomeListItem('English', "assets/images/english.png",
        "assets/images/public/correct.png", 0, false),
    HomeListItem('繁體中文', "assets/images/china.png", "assets/images/public/correct.png",
        1, false),
  ];
  return tradeList;
}

class LangSettingLogic extends GetxController {
  late ScrollController scrollController;
  var lang = 0.obs;
  var lists = [].obs;

  @override
  void onInit() {
    scrollController = ScrollController();
    postRequest();
    super.onInit();
  }

  void postRequest() => request(() async {

        lists.value = handleHomeLists(0);
        update();
      });

  void settingPostRequest(int index) => request(() async {
        print(index);
        List<String> langs =
            LanguageManager.instance.showLanguagesMap.values.toList();

        LanguageManager.instance.changeLanguage(langs[index]);

        lists.value = handleHomeLists(index);

        // if(index==0){
        //   var locale = Locale('en', 'US');
        //   Get.updateLocale(locale);
        //   lists.value = handleHomeLists(index).obs;
        // }else{
        //   var locale = Locale('zh', 'HK');
        //   Get.updateLocale(locale);
        //   lists.value = handleHomeLists(index).obs;
        // }

        if (AppCacheManager.instance.getUserToken().isNotEmpty) {
          //announce en
          mainEventBus.emit(
            EventBusConstants.grabRefreshHomeEvent,
            '1',
          );
        }


        update();
      });

  List handleHomeLists(int index) {
    List<HomeListItem> tradeList = <HomeListItem>[];
    List<HomeListItem> listModels = getHomeLists();
    List<String> langs =
        LanguageManager.instance.showLanguagesMap.values.toList();
    for (int i = 0; i < listModels.length; i++) {
      HomeListItem item = listModels[i];
      if (item.title == LanguageManager.instance.currentLanguageStr) {
        item.isChecked = true;
      }
      tradeList.add(item);
    }
    print('tradeList');
    print(tradeList);

    //
    // for(HomeListItem item in listModels){
    //   if(item.index == index){
    //     item.isChecked = true;
    //   }
    //   tradeList.add(item);
    // }
    return tradeList;
  }

  @override
  void onClose() {
    scrollController.dispose();
    super.onClose();
  }
}
