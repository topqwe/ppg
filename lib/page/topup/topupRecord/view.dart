import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:ftoast/ftoast.dart';
import 'package:get/get.dart';

import '../../../util/DefaultAppBar.dart';
import 'logic.dart';
import '/widgets/noData_Widget.dart';
import '/widgets/sizebox_widget.dart';
import '/widgets/text_widget.dart';

class TopupRecordPage extends StatelessWidget {
  TopupRecordLogic logic = Get.put(TopupRecordLogic());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false, //解决键盘导致溢出页面
      appBar: DefaultAppBar(
        titleStr: '记录'.tr,
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

  final logic = Get.put(TopupRecordLogic());

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
              ? noDataWidget(
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
            noMoreText: '没有更多啦'.tr,
          ),
          onRefresh: () async {
            await logic.dataRefresh();
            logic.easyRefreshController
                .finishLoad(success: true, noMore: false);
          },
          onLoad: () async {
            await logic.loadMore();
            logic.easyRefreshController.finishLoad(
                success: true, noMore: logic.hasMoreData ? false : true);
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

  Widget cellForRow(var listModel, int type, int index) {
    String orderId = '${listModel['order_no']}';

    return
        // Padding(
        //     padding: const EdgeInsets.only(left: 0, right: 0),
        //     child:
        Column(children: <Widget>[
      // Container(height: 10),

      GestureDetector(
          onTap: () {
            Get.toNamed('/topupDetail', arguments: listModel['order_no']);
          },
          child: Container(
            // height: 150,
            margin: EdgeInsets.only(top: 10, left: 15, right: 15),
            alignment: Alignment.center, //search has ed
            // padding: const EdgeInsets.only(left: 15, right: 15),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
              color: Colors.white,
            ),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(left: 15, right: 15, top: 8),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          // margin: const EdgeInsets.only(left: 8, right: 8),
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                sizeBoxPadding(w: 0, h: 10),
                                ultimatelyLRCopyTxt(
                                    textl: '订单号'.tr,
                                    textr: orderId,
                                    onPressed: () {
                                      FToast.toast(context, msg: "复制成功".tr);
                                      Clipboard.setData(
                                          ClipboardData(text: orderId));
                                    }),

                                sizeBoxPadding(w: 0, h: 15),
                              ]),
                        ),
                      ],
                    ),
                  ),
                ]),
          ))
    ])
        // )
        ;
  }

  @override
  Widget build(BuildContext context) {
    return buildEasyRefreshCustom();
  }
}
