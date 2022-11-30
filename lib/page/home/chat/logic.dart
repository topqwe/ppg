import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:ftoast/ftoast.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import '../../../api/request/apis.dart';
import '../../../api/request/request_client.dart';



class ChatServiceLogic extends GetxController  {

  var chatList = [].obs;

  late Timer _timer;
  bool isCreateTimer = true;

  ///输入框
  TextEditingController textController = TextEditingController();

  ///滚动监听
  ScrollController scrollController = ScrollController();

  @override
  void onInit() {
    super.onInit();
    // if (chatList.isEmpty) FToast.toast(Get.context!, msg: "加载中".tr);
    initTimer();
    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        requestChatList(false);
      }
      if (scrollController.position.pixels ==
          scrollController.position.minScrollExtent) {
        if (isCreateTimer = true) {
          initTimer();
        }
      }
      if (scrollController.position.pixels !=
          scrollController.position.minScrollExtent) {
        _timer.cancel();
        isCreateTimer = false;
      }
    });
  }

  @override
  void onClose() {
    super.onClose();
    _timer.cancel();
  }

  initTimer() {
    isCreateTimer = true;
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      requestChatList(true);
    });
  }

  requestChatList(bool isNew) async {
    String messageId = isNew == true ? "" : chatList.last.id ?? "";
    Map<String, dynamic> params = {'message_id': messageId, "show_img": true};

    var data = await requestClient.post(APIS.chatList,
        data:params);
    var list = [];
    list.addAll(data);
    if (isNew == true) {
      if (list.length > chatList.length) {
        chatList.value = list;
      } else {
        chatList.replaceRange(0, list.length, list);
      }
    } else {
      chatList.addAll(list);
    }

  }

  requestSendText(bool isText, String content) async {
    if (content.isEmpty) {
      FToast.toast(Get.context!, msg: isText ? "请输入消息".tr : "图片上传失败".tr);
      return;
    }
    // FToast.toast(Get.context!, msg: "发送中".tr);
    Map<String, dynamic> params = {
      'type': isText ? "text" : "img",
      "content": content
    };
    var data = await requestClient.post(APIS.chatSend,
        data:params);

    // chatList.insert(0, data);
    textController.text = "";
    scrollController
        .jumpTo(scrollController.position.minScrollExtent);


  }
}
