import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../util/DefaultAppBar.dart';
import '../../../../widgets/image_widget.dart';
import '../../../../widgets/sizebox_widget.dart';
import '../../../../widgets/text_widget.dart';
import 'logic.dart';


class ChatMessagePage extends GetView<ChatMessageLogic> {
  ChatMessagePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DefaultAppBar(titleStr: "消息".tr),
      body: ListView.builder(
        padding: const EdgeInsets.only(top: 0),
        shrinkWrap: false,
        itemCount: 1,
        itemBuilder: (BuildContext context, int index) {
          return listItem(context);
        },
      ),
    );
  }

  ///列表item
  listItem(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        decoration: const BoxDecoration(
            border:
                Border(bottom: BorderSide(width: .5, color: Colors.blueGrey))),
        padding: const EdgeInsets.all(15),
        child: Row(
          children: [
            imageCircular(
              w: 44,
              h: 44,
              radius: 22,
              image: "assets/images/chat/news.png",
            ),
            sizeBoxPadding(w: 10, h: 0),
            Expanded(child:
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(child:
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [csText(text: "title", maxLines: 1)],
                    )),
                    sizeBoxPadding(w: 20, h: 0),
                    Container(
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.red,
                      ),
                      padding: const EdgeInsets.only(
                          left: 4, right: 4, top: 1, bottom: 1),
                      child: csText(
                          text: "1", color: Colors.white, fontSize: 10),
                    )
                  ],
                ),
                sizeBoxPadding(w: 0, h: 8),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Expanded(child:
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        csText(
                            text: "subtitle",
                            maxLines: 1,
                            fontSize: 12,
                            color: Colors.grey),
                      ],
                    )),
                    sizeBoxPadding(w: 20, h: 0),
                    csText(text: "2016111", fontSize: 12, color:Colors.grey)
                  ],
                )
              ],
            )),
          ],
        ),
      ),
    );
  }
}
