
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
 import 'package:ftoast/ftoast.dart';
import 'package:get/get.dart';
import 'package:qr_flutter/qr_flutter.dart';
import '../../../style/theme.dart';

import '../../../api/request/config.dart';
import '../../../util/DefaultAppBar.dart';
import '../../../util/FadeRoute.dart';
import '../../../util/PhotoViewGalleryScreen.dart';
import '../../../widgets/button_widget.dart';
import 'logic.dart';
import '/widgets/noData_Widget.dart';
import '/widgets/sizebox_widget.dart';
import '/widgets/text_widget.dart';

class TopupDetailPage extends StatelessWidget {
  var logic = Get.put(TopupDetailLogic());

  @override
  Widget build(BuildContext context) {
    // int type =
    // Get.arguments['status'];
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false, //解决键盘导致溢出页面
      appBar: DefaultAppBar(
        titleStr: '详情'.tr,
      ),
      body: SafeArea(
        child: EasyRefreshCustom(
          type: 0,
        ),
      ),
    );
  }
}

class EasyRefreshCustom extends StatefulWidget {
  int type;
  EasyRefreshCustom({
    Key? key,
    this.type = 0,
  }) : super(key: key);

  @override
  EasyRefreshCustomState createState() => EasyRefreshCustomState();
}

class EasyRefreshCustomState extends State<EasyRefreshCustom> {
  late int type;

  final logic = Get.put(TopupDetailLogic());

  @override
  void initState() {
    super.initState();
    type = widget.type;
  }

  Widget buildEasyRefreshCustom() {
    return Obx(() => EasyRefresh.custom(
          key: PageStorageKey<int>(type),
          controller: logic.easyRefreshController,
          emptyWidget: logic.listDataFirst.isEmpty
              ? noAddrDataWidget(
                  mainAxisAlignment: MainAxisAlignment.start, topPadding: 30)
              : null,
          header: ClassicalHeader(
            infoText: ('下拉刷新'.tr),
            refreshedText: ('刷新完成'.tr),
            refreshText: ('刷新中...'.tr),
            noMoreText: '',
          ),
          footer: ClassicalFooter(
            infoText: ('上拉加载'.tr),
            loadingText: ('加载中...'.tr),
            loadedText: ('加载完毕'.tr),
            noMoreText: ('没有更多啦'.tr),
          ),
          onRefresh: () async {
            await logic.dataRefresh();
            logic.easyRefreshController.finishLoad(success: true, noMore: true);
          },
          onLoad: () async {
            logic.hasMoreData
                ? await logic.loadMore()
                : logic.easyRefreshController
                    .finishLoad(success: true, noMore: true);
          },
          slivers: [
            // SliverOverlapInjector(
            //     handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context)),

            SliverList(
              delegate: SliverChildBuilderDelegate((context, index) {
                var model = logic.listDataFirst[index];

                return cellForRow(model, type, index);
              }, childCount: logic.listDataFirst.length),
            ),
          ],
        ));
  }

  Widget imgButton(BuildContext context, String txt, Function cb) {
    return Container(
        child: Container(
            width: double.infinity,
            alignment: Alignment.center,
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  RepaintBoundary(
                      key: logic.repaintKey,
                      child: Container(
                        height: 150,
                        width: 150,
                        color: Colors.white,
                        child: QrImage(
                          data: txt,
                          foregroundColor: Colors.black,
                          size: 132,
                        ),
                      )),

                  Container(height: 9),
                  // Text(address, style: StandardTextStyle.small),

                  Container(height: 9),
                  ButtonBordor(
                      text: ("保存二维码".tr),
                      onPressed: () {
                        logic.getPerm(context);
                      },
                      w: 114,
                      h: 40,
                      bordercolor: Color(0xffDDDDDD)),
                ])));
  }

  Widget cellForRow(var listModel, int type, int index) {
    String orderId = '${listModel['order_no']}';


    String imgStr =
        RequestConfig.baseUrl + RequestConfig.imagePath + listModel['img'];

    return
        // Padding(
        //     padding: const EdgeInsets.only(left: 0, right: 0),
        //     child:
        Column(children: <Widget>[
      // Container(height: 10),

      // Padding(
      // padding: const EdgeInsets.only(left: 0, right: 0),
      // child:

      Container(
        // height: 300,
        alignment: Alignment.center, //search has ed
        // padding: const EdgeInsets.only(left: 15, right: 15),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(0.0)),
          color: Colors.white,
        ),
        child: Column(mainAxisAlignment: MainAxisAlignment.start, children: <
            Widget>[
          Padding(
            padding: const EdgeInsets.only(left: 15, right: 15),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                divideLine(),
                SizedBox(
                  height: 15,
                ),

                syText(
                    text: '数量'.tr + '(' + '${listModel['coin']}' + ')',
                    fontSize: 12,
                    color: Colors.black),
                SizedBox(
                  height: 10,
                ),
                syText(
                    text:
                        double.parse(listModel['volume'].toString()).toString(),
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Color(0xff2DBD85)),
                SizedBox(
                  height: 10,
                ),

                // Visibility(child:
                imgButton(context, listModel['coin_blockchain'], () {}),
                // visible: 1==1,),

                sizeBoxPadding(w: 0, h: 25),

                Container(
                  // margin: const EdgeInsets.only(left: 8, right: 8),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        // sizeBoxPadding(w: 0, h: 20),
                        ultimatelyLRCopyTxt(
                            textl: '订单号'.tr,
                            textr: orderId,
                            onPressed: () {
                              FToast.toast(context, msg: "复制成功".tr);
                              Clipboard.setData(ClipboardData(text: orderId));
                            }),

                        sizeBoxPadding(w: 0, h: 20),
                        Container(
                          child: Row(
                            children: <Widget>[
                              Expanded(
                                child: Container(
                                  //padding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                                  child: textContainer(
                                      text: '付款凭证'.tr,
                                      color: Colors.grey,
                                      continerAlign: Alignment.centerLeft),
                                ),
                              ),
                              GestureDetector(
                                child: Image.network(
                                  imgStr,
                                  height: 105,
                                  width: 105,
                                  fit: BoxFit.fill,
                                ),

                                // ExtendedImage.network(
                                //
                                //   imgStr,
                                //   fit: BoxFit.fill,
                                //   height: 105,
                                //   width: 105,
                                // ),
                                onTap: () {
                                  Navigator.of(context).push(new FadeRoute(
                                      page: PhotoViewGalleryScreen(
                                    images: [imgStr], //传入图片list
                                    index: index, //传入当前点击的图片的index
                                    heroTag:
                                        '{$index}', //传入当前点击的图片的hero tag （可选）
                                  )));

                                  // Navigator.push(context,MaterialPageRoute(builder:(_)=>PhotoPreview(
                                  //   galleryItems:[imgStr],
                                  //   defaultImage: index, pageChanged: (int index) {
                                  //
                                  // },
                                  // )));
                                },
                              ),
                            ],
                          ),
                        ),
                        sizeBoxPadding(w: 0, h: 20),
                      ]),
                ),
              ],
            ),
          ),
        ]),
      )

      // ),
    ])
        // )
        ;
  }

  @override
  Widget build(BuildContext context) {
    return buildEasyRefreshCustom();
  }
}
