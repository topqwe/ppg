
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';
import '../../../style/theme.dart';

import '../../../util/DefaultAppBar.dart';
import '../../../widgets/button_widget.dart';
import '../../../widgets/image_widget.dart';
import '../../../widgets/sizebox_widget.dart';
import '../../../widgets/text_widget.dart';
import '../../../widgets/textfiled.dart';
import 'logic.dart';


class ChatServicePage extends GetView<ChatServiceLogic> {
  ChatServicePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return
      KeyboardDismisser(
        gestures: [
        GestureType.onTap,
        GestureType.onPanUpdateDownDirection,
        ],
        child:
      Scaffold(
      backgroundColor: Colors.white,
      appBar: DefaultAppBar(titleStr: "在线客服"),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Container(
                color: Color(0xffEEF0F3),
                child: Obx(() {
                  return
                    ListView.builder(
                    reverse: true,
                    controller: controller.scrollController,
                    shrinkWrap: true,
                    itemBuilder: (BuildContext context, int index) {
                      var model = controller.chatList[index];
                      if (model['deleteStatus'] == -1) return Container();
                      return (model['sendReceive']??"") == "send"
                          ? listMessageMineItem(model, index)
                          : listMessageServerItem(model, index);
                    },
                    itemCount: controller.chatList.length,
                  );
                }),
              ),
            ),
            bottom(),
          ],
        ),
      ),
    )
      );
  }

  Widget listMessageServerItem(var model, int index) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 10),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [csText(text: model['createtime'] ?? "")],
          ),
        ),
        Padding(
          padding:
              const EdgeInsets.only(left: 15, top: 36, right: 86, bottom: 10),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              imageCircular(
                  w: 44,
                  h: 44,
                  radius: 0,
                  image: "assets/images/chat/server.png"),
              sizeBoxPadding(w: 10, h: 0),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      decoration: const BoxDecoration(
                        color: Color(0xffD1E6FF),
                        borderRadius: BorderRadius.all(Radius.circular(5.0)),
                      ),
                      padding: const EdgeInsets.all(13),
                      child: content(model),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  ///自己发送的消息
  Widget listMessageMineItem(var model, int index) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 10),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [syText(text: model['createtime'] ?? "")],
          ),
        ),
        Padding(
          padding:
              const EdgeInsets.only(left: 86, top: 20, right: 15, bottom: 10),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      decoration: const BoxDecoration(
                        color: Color(0xffD1E6FF),
                        borderRadius: BorderRadius.all(Radius.circular(5.0)),
                      ),
                      padding: const EdgeInsets.all(13),
                      child: content(model),
                    ),
                  ],
                ),
              ),
              sizeBoxPadding(w: 10, h: 0),
              imageCircular(
                  w: 44,
                  h: 44,
                  radius: 0,
                  image: "assets/images/public/avatar.png"),
            ],
          ),
        ),
      ],
    );
  }

  ///图片和文本样式
  content(var model) {
    if (model['type'] == "text") {
      return syText(text: model['content'] ?? "", textAlign: TextAlign.start);
    }
    return InkWell(
      onTap: () {
        // showDialog(
        //   barrierColor: Colors.black,
        //   context: context,
        //   builder: (BuildContext context) {
        //     return ServiceImagePage(url: model['content'] ?? "");
        //   },
        // );
      },
      // child: ExtendedImage.network(
      //   model['content'] ?? "",
      //   fit: BoxFit.fill,
      //   cache: true,
      //   mode: ExtendedImageMode.gesture,
      //   initGestureConfigHandler: (state) {
      //     return GestureConfig(
      //       minScale: 0.9,
      //       animationMinScale: 0.7,
      //       maxScale: 3.0,
      //       animationMaxScale: 3.5,
      //       speed: 1.0,
      //       inertialSpeed: 100.0,
      //       initialScale: 1.0,
      //       inPageView: false,
      //       initialAlignment: InitialAlignment.center,
      //     );
      //   },
      // ),
    );
  }

  ///底部
  Widget bottom() {
    return Container(
      height: 70,
      alignment: Alignment.center,
      padding: const EdgeInsets.only(left: 15, right: 15),
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          buttonImage(
              w: 30,
              h: 30,
              imageName: "assets/images/chat/chatSelect.png",
              text: "",
              onPressed: () {
                // chooseImage();
              }),
          sizeBoxPadding(w: 10, h: 0),
          Expanded(
            child: textField(
                hintText: "请输入消息".tr,
                padding: const EdgeInsets.only(left: 12, right: 12),
                controller: controller.textController,
                backgroundColor: Color(0xffEEF0F3),
                radius: 22),
          ),
          sizeBoxPadding(w: 10, h: 0),
          buttonText(
            w: 74,
            h: 40,
            text: "发送".tr,
            backgroundColor: AppTheme.themeHightColor,
            textColor: Colors.white,
            radius: 22,
            onPressed: () {
              controller.requestSendText(true, controller.textController.text);
            },
          ),
        ],
      ),
    );
  }
}
