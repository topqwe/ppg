
import 'dart:core';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:get/get.dart';
import '../../../style/theme.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

import 'logic.dart';
import '/widgets/noData_Widget.dart';
import '/widgets/sizebox_widget.dart';
import '/widgets/text_widget.dart';

// class TaskStateListPage extends StatelessWidget {

class CatStateListPage extends StatefulWidget {
  String type;
  CatStateListPage({
    Key? key,
    this.type = '',
  }) : super(key: key);

  @override
  createState() => _CatStateListPageState();

  // void requestListData(){///Out need
  //   print('page - logic refresh');
  //   TaskStateListLogic logic = Get.find<TaskStateListLogic>();
  //   logic.type = type;
  //   // logic.postRequestToken();
  //   logic.requestListData(true);
  // }
}

class _CatStateListPageState extends State<CatStateListPage>
    with AutomaticKeepAliveClientMixin {
  late final CatStateListLogic logic;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    logic = CatStateListLogic(widget.type);
    Get.put(logic, tag: widget.type.toString());
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    Get.delete<CatStateListLogic>(tag: widget.type.toString());
  }

  final tabNames = <String>[

  ];

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
        resizeToAvoidBottomInset: false, //解决键盘导致溢出页面
        body: SafeArea(
          child: EasyRefreshCustom(type: widget.type),
        ));
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}

class EasyRefreshCustom extends StatefulWidget {
  String type;
  String typeStr;
  bool isCustom;
  EasyRefreshCustom({
    Key? key,
    this.type = '',
    this.typeStr = '',
    this.isCustom = true,
  }) : super(key: key);

  @override
  EasyRefreshCustomState createState() => EasyRefreshCustomState();
}

class EasyRefreshCustomState extends State<EasyRefreshCustom> {
  late String type;
  late bool isCustom;
  late String typeStr;
  late CatStateListLogic logic;

  @override
  Widget build(BuildContext context) {
    return isCustom ? buildEasyRefreshCustom() : buildEasyRefresh();
  }

  @override
  void initState() {
    super.initState();
    type = widget.type;
    isCustom = widget.isCustom;
    typeStr = widget.typeStr;
    logic = Get.find<CatStateListLogic>(tag: type);
  }

  Widget buildEasyRefresh() {
    return Obx(() => EasyRefresh(
          key: PageStorageKey(type),
          emptyWidget: logic.listDataFirst.isEmpty
              ? noDataWidget(
                  mainAxisAlignment: MainAxisAlignment.start, topPadding: 30)
              : null,
          header: ClassicalHeader(
            infoText: ('下拉刷新'),
            refreshedText: ('刷新完成'),
            refreshText: ('刷新中...'),
            noMoreText: '',
          ),
          footer: ClassicalFooter(
            infoText: ('上拉加载'),
            loadingText: ('加载中...'),
            loadedText: ('加载完毕'),
            noMoreText: '没有更多',
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
          child: ListView.custom(
            //controller: _scrollController,
            childrenDelegate: SliverChildBuilderDelegate(
              (BuildContext, index) {
                var model = logic.listDataFirst[index];

                return cellForRow(model, type, index);
              },
              childCount: logic.listDataFirst.length,
            ),
            shrinkWrap: true,
            // padding: EdgeInsets.all(5),
            scrollDirection: Axis.vertical,
          )
          // [
          //   SliverList(delegate: SliverChildBuilderDelegate(
          //           (context, index) {
          //         var model = type ==0? listDataFirst[index]:
          //         type ==1?listDataSec[index]:listDataThird[index];
          //         return cellForRow(model,type,index);
          //       },
          //       childCount: type ==0? listDataFirst.length:
          //       type ==1?listDataSec.length:listDataThird.length
          //   ),
          //   ),
          //
          // ]
          ,
        ));
  }

  Widget buildEasyRefreshCustom() {
    return Obx(() => EasyRefresh.custom(
          key: PageStorageKey(type),
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

  Widget cellForRow(var listModel, String type, int index) {
    var size = MediaQuery.of(Get.context!).size;
    double itemWidth = (size.width - 4 * 15) / 3;

    bool unLock = true;
    //listModel['un_lock'];
    return
        // InkWell(
        // onTap: () => itemClick(listModel),
        // child:
        Container(
            // height: 180,
            width: double.infinity,
            padding: const EdgeInsets.only(left: 15, right: 15),
            margin: const EdgeInsets.only(top: 15),
            child: GestureDetector(
                onTap: () {
                  Get.toNamed('/catDetail',
                      arguments: listModel['orderId'],
                      preventDuplicates: false);
                  // if (timer_fun != null) {
                  //   return;
                  // }
                  // timer_fun = Timer(
                  //   Duration(milliseconds: FANGDOU.fangdoushu),
                  //       () {
                  //     timer_fun = null;
                  //   },
                  // );
                  // logic.getUserWallet(context,listModel);
                  // logic.handleAlert(context, listModel);
                  // Navigator.of(context)
                  //     .pushReplacementNamed("/hash");
                },
                child: Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(
                      Radius.circular(4),
                    ),
                    // image: DecorationImage(
                    //   image: AssetImage("images/game1.png"),
                    //   fit: BoxFit.cover,
                    // ),
                  ),
                  child: Container(
                      margin: const EdgeInsets.all(15),
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              alignment: Alignment.topLeft,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    // height: 40,
                                    alignment: Alignment.topLeft,
                                    child: RichText(
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      textAlign: TextAlign.left,
                                      text: TextSpan(
                                        text: listModel['id'],
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                        ),
                                        children: <TextSpan>[
                                          TextSpan(
                                            text: '',
                                            style: TextStyle(
                                                fontSize: 12,
                                                color: Colors.grey),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            sizeBoxPadding(w: 0, h: 15),


                          ])),
                )))
        // )
        ;
  }
}
