import 'package:ftoast/ftoast.dart';
import 'package:get/get.dart';
import 'package:package_info/package_info.dart';
import '../../services/api/api_basic.dart';
import '../../services/responseHandle/request.dart';
import '../../store/AppCacheManager.dart';
import '../../store/CacheUtil.dart';
import '../../util/UpdateVersion.dart';
import '../../widgets/helpTools.dart';
class SettingLogic extends GetxController {
  var cacheSize = '0.00'.obs;
  var version = '1.0.0'.obs;
  var phoneNum = ''.obs;
  var introduce = ''.obs;

  var boolSafeword = 0.obs;
  var boolId = 0.obs;
  var boolBank = 0.obs;

  Future<void> initCache() async {
    double value = await CacheUtil.loadApplicationCache();
    cacheSize.value = CacheUtil.formatSize(value);
    print(cacheSize.value);
    update();
  }


  Future<void> handleClearCache() async {
    try {
      // if (cacheSize <= 0) throw '没有缓存可清理';

      /// 执行清除缓存
      CacheUtil.clearApplicationCache();
      // CacheUtil.clear();

      /// 更新缓存
      await initCache();
      if(cacheSize == '0.00B')FToast.toast(Get.context!, msg: '缓存清空'.tr);

    } catch (e) {
        FToast.toast(Get.context!, msg: e.toString());
    }
  }

  Future<void> postCheckInfosStatus()=> request(() async {
    var user = await ApiBasic().home({});
    boolSafeword.value = user['safeword'];
    if(boolSafeword.value==0){

    }else{

    }

    boolId.value = user['safeword'];
    if(boolId.value==0){

    }else{

    }
    boolBank.value = user['safeword'];
    if(boolBank.value==0){

    }else{

    }
    update();
    return;
  });

  void onInit() {
    super.onInit();
    // initCache();
    getCacheSize();
    postCheckInfosStatus();
  }

  Future getVersion() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    version.value = packageInfo.version;

    UpdateVersion().getConfigData();
  }

  Future getCacheSize() async{
    var cache = await AppCacheManager.instance.loadCacheSize();
    cacheSize.value = "${toDouble(cache.cacheSize/1024/1024,defaultValue: 0,scale: 2)}MB";
  }

  void checkFPW() async {
    if(boolSafeword.value==0){
      Get.toNamed("/setFPW");
    }else{
      Get.toNamed("/resetFPW");
    }
    return;
  }

  logout(){
    // final prefs = await SharedPreferences.getInstance();
    //
    // await prefs.remove('token');
    AppCacheManager.instance.setUserToken('');
    Get.offAllNamed('/login');
  }
  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
  }
}
