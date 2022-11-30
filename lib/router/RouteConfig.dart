import 'package:get/get.dart';
import '../page/home/chat/chatMessage/view.dart';
import '../page/home/chat/chatMessage/logic.dart';
import '../page/home/chat/logic.dart';
import '../page/home/chat/view.dart';
import '../page/me/statRecord/logic.dart';
import '../page/me/statRecord/view.dart';
import '../page/me/stickyRecord/logic.dart';
import '../page/me/stickyRecord/view.dart';
import '../page/topup/topupRecord/logic.dart';
import '../page/topup/topupRecord/view.dart';
import '../page/fPW/set/logic.dart';
import '../page/fPW/set/view.dart';
import '../page/fPW/reset/logic.dart';
import '../page/fPW/reset/view.dart';
import '../page/bottom/logic.dart';
import '../page/bottom/view.dart';
import '../page/home/onlineService/logic.dart';
import '../page/home/onlineService/view.dart';
import '../page/langSetting/logic.dart';
import '../page/langSetting/view.dart';
import '../page/login/login/logic.dart';
import '../page/login/login/view.dart';
import '../page/login/loginPWModify/logic.dart';
import '../page/login/loginPWModify/view.dart';
import '../page/login/register/logic.dart';
import '../page/login/register/view.dart';
import '../page/mall/mallDetail/logic.dart';
import '../page/mall/mallDetail/view.dart';
import '../page/mall/mallSure/logic.dart';
import '../page/mall/mallSure/view.dart';
import '../page/sell/logic.dart';
import '../page/sell/view.dart';
import '../page/setting/idVerify/logic.dart';
import '../page/setting/idVerify/view.dart';
import '../page/setting/addBank/logic.dart';
import '../page/setting/addBank/view.dart';
import '../page/setting/bankList/logic.dart';
import '../page/setting/bankList/view.dart';
import '../page/setting/logic.dart';
import '../page/setting/setAddAddr/logic.dart';
import '../page/setting/setAddAddr/view.dart';
import '../page/setting/setAddrList/logic.dart';
import '../page/setting/setAddrList/view.dart';
import '../page/setting/view.dart';
import '../page/succ/logic.dart';
import '../page/succ/view.dart';
import '../page/topup/submitSuccess/logic.dart';
import '../page/topup/submitSuccess/view.dart';
import '../page/topup/topup/logic.dart';
import '../page/topup/topup/view.dart';
import '../page/topup/topupDetail/logic.dart';
import '../page/topup/topupDetail/view.dart';


class RouteConfig {
  static const String login = "/login";
  static const String index = "/index";
  static const String register = "/register";
  static const String message = "/message";
  static const String setting = '/setting';
  static const String chatService = '/chatService';
  static const String chatMessage = '/chatMessage';
  static const String onlineService = '/onlineService';
  static const String langSetting = '/langSetting';
  static const String statRecord = '/statRecord';
  static const String stickyRecord = '/stickyRecord';
  static const String topup = "/topup";
  static const String topupRecord = "/topupRecord";
  static const String catDetail = "/catDetail";
  static const String catSure = "/catSure";
  static const String mallDetail = "/mallDetail";
  static const String mallSure = "/mallSure";
  static const String sell = "/sell";
  static const String bankList = "/bankList";
  static const String addBank = "/addBank";
  static const String idVerify = "/idVerify";
  static const String taskDetail = "/taskDetail";
  static const String taskAddrList = "/taskAddrList";
  static const String taskAddAddr = "/taskAddAddr";
  static const String setAddrList = "/setAddrList";
  static const String setAddAddr = "/setAddAddr";
  static const String succ = "/succ";
  static const String taskPaySucc = "/taskPaySucc";
  static const String setFPW = "/setFPW";
  static const String resetFPW = "/resetFPW";
  static const String topupDetail = "/topupDetail";
  static const String loginPWModify = "/loginPWModify";
  static const String submitSuccess = "/submitSuccess";

  ///别名映射页面
  static final List<GetPage> getPages = [
    GetPage(
        name: login,
        page: () => LoginPage(),
        binding: BindingsBuilder(() => {Get.lazyPut(() => LoginLogic())})),
    GetPage(
        name: register,
        page: () => RegisterPage(),
        binding: BindingsBuilder(() => {Get.lazyPut(() => RegisterLogic())})),
    GetPage(
        name: index,
        page: () => BottomPage(),
        // binding: BindingsBuilder(() => {
        //   //bcz 一进入就需要请求数据 所以直接初始化 不进行懒加载
        //   Get.put<BottomLogic>(BottomLogic())
        // })
      binding: BindingsBuilder(() => {Get.lazyPut(() => BottomLogic())})
    ),
    GetPage(
        name: topup,
        page: () => TopupPage(),
        binding: BindingsBuilder(() => {Get.lazyPut(() => TopupLogic())})),
    GetPage(
        name: topupRecord,
        page: () => TopupRecordPage(),
        binding:
            BindingsBuilder(() => {Get.lazyPut(() => TopupRecordLogic())})),
    GetPage(
        name: topupDetail,
        page: () => TopupDetailPage(),
        binding:
            BindingsBuilder(() => {Get.lazyPut(() => TopupDetailLogic())})),
    GetPage(
        name: mallDetail,
        page: () => MallDetailPage(),
        binding: BindingsBuilder(() => {Get.lazyPut(() => MallDetailLogic())})),
    GetPage(
        name: mallSure,
        page: () => MallSurePage(),
        binding: BindingsBuilder(() => {Get.lazyPut(() => MallSureLogic())})),
    GetPage(
        name: sell,
        page: () => SellPage(),
        binding: BindingsBuilder(() => {Get.lazyPut(() => SellLogic())})),
    GetPage(
        name: bankList,
        page: () => BankListPage(),
        binding: BindingsBuilder(() => {Get.lazyPut(() => BankListLogic())})),
    GetPage(
        name: addBank,
        page: () => AddBankPage(),
        binding: BindingsBuilder(() => {Get.lazyPut(() => AddBankLogic())})),
    GetPage(
        name: idVerify,
        page: () => IdVerifyPage(),
        binding: BindingsBuilder(() => {Get.lazyPut(() => IdVerifyLogic())})),

    GetPage(
        name: setAddrList,
        page: () => SetAddrListPage(),
        binding:
            BindingsBuilder(() => {Get.lazyPut(() => SetAddrListLogic())})),
    GetPage(
        name: setAddAddr,
        page: () => SetAddAddrPage(),
        binding: BindingsBuilder(() => {Get.lazyPut(() => SetAddAddrLogic())})),
    GetPage(
        name: succ,
        page: () => SuccPage(),
        binding: BindingsBuilder(() => {Get.lazyPut(() => SuccLogic())})),

     GetPage(
        name: setting,
        page: () => SettingPage(),
        binding: BindingsBuilder(() => {Get.lazyPut(() => SettingLogic())})),

    GetPage(
        name: onlineService,
        page: () => OnlineServicePage(),
        binding:
            BindingsBuilder(() => {Get.lazyPut(() => OnlineServiceLogic())})),

    GetPage(
        name: chatService,
        page: () => ChatServicePage(),
        binding:
        BindingsBuilder(() => {Get.lazyPut(() => ChatServiceLogic())})),
    GetPage(
        name: chatMessage,
        page: () => ChatMessagePage(),
        binding:
        BindingsBuilder(() => {Get.lazyPut(() => ChatMessageLogic())})),

    GetPage(
        name: langSetting,
        page: () => LangSettingPage(),
        binding:
            BindingsBuilder(() => {Get.lazyPut(() => LangSettingLogic())})),
    GetPage(
        name: statRecord,
        page: () => StatRecordPage(),
        binding: BindingsBuilder(
            () => {Get.lazyPut(() => StatRecordLogic())})),
    GetPage(
        name: stickyRecord,
        page: () => StickyRecordPage(),
        binding: BindingsBuilder(
                () => {Get.lazyPut(() => StickyRecordLogic())})),

    GetPage(
        name: setFPW,
        page: () => SetFPWPage(),
        binding: BindingsBuilder(() => {Get.lazyPut(() => SetFPWLogic())})),
    GetPage(
        name: resetFPW,
        page: () => ResetFPWPage(),
        binding: BindingsBuilder(() => {Get.lazyPut(() => ResetFPWLogic())})),
    GetPage(
        name: loginPWModify,
        page: () => LoginPWModifyPage(),
        binding:
            BindingsBuilder(() => {Get.lazyPut(() => LoginPWModifyLogic())})),
    GetPage(
        name: submitSuccess,
        page: () => SubmitSuccessPage(),
        binding: BindingsBuilder(
            () => {Get.lazyPut(() => SubmitSuccessLogic())})),
  ];
}
