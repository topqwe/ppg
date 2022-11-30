import 'dart:core';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:get/get.dart';
import '../../../style/theme.dart';
import '../../../api/request/config.dart';
import 'logic.dart';
import '/widgets/noData_Widget.dart';
import '/widgets/sizebox_widget.dart';
// class TaskStateListPage extends StatelessWidget {

class MallStateListPage extends StatefulWidget {
  int type;
  MallStateListPage({
    Key? key,
    this.type = 0,
  }) : super(key: key);

  @override
  createState() => _MallStateListPageState();

  // void requestListData(){///Out need
  //   print('page - logic refresh');
  //   TaskStateListLogic logic = Get.find<TaskStateListLogic>();
  //   logic.type = type;
  //   // logic.postRequestToken();
  //   logic.requestListData(true);
  // }
}

class _MallStateListPageState extends State<MallStateListPage>
    with AutomaticKeepAliveClientMixin {
  late final MallStateListLogic logic;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    logic = MallStateListLogic(widget.type);
    Get.put(logic, tag: widget.type.toString());
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    Get.delete<MallStateListLogic>(tag: widget.type.toString());
  }

  final tabNames = <String>[];

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
        backgroundColor: Colors.white,
        resizeToAvoidBottomInset: false, //解决键盘导致溢出页面
        body: SafeArea(
          child: EasyRefreshCustom(
            type: widget.type,
            isCustom: false,
          ),
        ));
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}

class EasyRefreshCustom extends StatefulWidget {
  int type;
  String typeStr;
  bool isCustom;
  EasyRefreshCustom({
    Key? key,
    this.type = 0,
    this.typeStr = '',
    this.isCustom = true,
  }) : super(key: key);

  @override
  EasyRefreshCustomState createState() => EasyRefreshCustomState();
}

class EasyRefreshCustomState extends State<EasyRefreshCustom> {
  late int type;
  late bool isCustom;
  late String typeStr;
  late MallStateListLogic logic;

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
    logic = Get.find<MallStateListLogic>(tag: type.toString());
  }

  Widget buildEasyRefresh() {
    return Obx(() => EasyRefresh(
          key: PageStorageKey<int>(type),
          emptyWidget: logic.listDataFirst.isEmpty
              ? noDataWidget(
                  mainAxisAlignment: MainAxisAlignment.start, topPadding: 30)
              : null,
          header: ClassicalHeader(
            infoText: '下拉刷新'.tr,
            refreshedText: '刷新完成'.tr,
            refreshText: '刷新中...'.tr,
            noMoreText: '',
          ),
          footer: ClassicalFooter(
            infoText: '上拉加载'.tr,
            loadingText: '加载中...'.tr,
            loadedText: '加载完毕'.tr,
            noMoreText: '没有更多'.tr,
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
          child:
              //       GridView.builder(
              //       // 定义网格相关样式
              //       gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              //       // 定义列
              //       crossAxisCount: 2,
              //         childAspectRatio: .65,
              //   // 横向间隙
              //   mainAxisSpacing: 15.0,
              //   // 纵向间隙
              //   crossAxisSpacing: 15.0,
              // ),
              //     // 数据数量
              //     itemCount: logic.listDataFirst.length,
              //     // 所有数据
              //     itemBuilder:getGrid,
              // )

              GridView.count(
            crossAxisCount: 2,
            childAspectRatio: .65,
            mainAxisSpacing: 15,
            crossAxisSpacing: 15,
            padding: EdgeInsets.only(left: 15, right: 15, bottom: 15),
            children: getGridList(),
          )

          // ListView.custom(
          //   //controller: _scrollController,
          //   childrenDelegate: SliverChildBuilderDelegate(
          //         (BuildContext, index) {
          //           var model =logic.listDataFirst[index];
          //
          //           return cellForRow(model,type,index);
          //     },
          //     childCount: logic.listDataFirst.length
          //     ,
          //   ),
          //   shrinkWrap: true,
          //   // padding: EdgeInsets.all(5),
          //   scrollDirection: Axis.vertical,
          // )

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

  List<Widget> getGridList() {
    var tem = logic.listDataFirst.map((listModel) {
      return cellForRow(listModel, 0, 0);
    });
    return tem.toList();
  }

  Widget getGrid(context, index) {
    return cellForRow(logic.listDataFirst[index], 0, 0);
  }

  Widget buildEasyRefreshCustom() {
    // int count = lists.length;
    // var size = MediaQuery.of(context).size;
    // double itemHeight = 40.0;
    // double itemWidth = size.width / count;
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
            SliverGrid(
                delegate: SliverChildBuilderDelegate((_, index) {
                  var model = logic.listDataFirst[index];

                  return cellForRow(model, type, index);
                }, childCount: logic.listDataFirst.length),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    childAspectRatio: .8,
                    crossAxisCount: 2,
                    mainAxisSpacing: 35,
                    crossAxisSpacing: 0)),

            // SliverList(delegate: SliverChildBuilderDelegate(
            //         (context, index) {
            //       var model = logic.listDataFirst[index];
            //       return cellForRow(model,type,index);
            //     },
            //     childCount: logic.listDataFirst.length
            // ),
            // ),
            SliverToBoxAdapter(
              child: SizedBox(
                height: 20,
              ),
            )
          ],
        ));
  }

  Widget cellForRow(var listModel, int type, int index) {
    final logic = Get.put(MallStateListLogic(type));
    var size = MediaQuery.of(Get.context!).size;
    double itemHeight = 40.0;
    double itemWidth = (size.width - 3 * 15) / 2;
    // itemWidth = 170;

    bool unLock = true;
    //listModel['un_lock'];
    return
        // InkWell(
        // onTap: () => itemClick(listModel),
        // child:
        Container(
            // height: 180,
            width: itemWidth,
            padding:
                const EdgeInsets.only(left: 0, right: 0, top: 15, bottom: 15),
            margin: const EdgeInsets.only(top: 0),
            child: GestureDetector(
                onTap: () {
                  // Get.toNamed('/mallSure',arguments: listModel['orderId']);
                  // Get.toNamed('/catSure',arguments: listModel['orderId']);

                  Get.toNamed('/mallDetail',
                      parameters:
                          // {'url':''},
                          {
                        'url':
                            '<style>img {width: 100%}</style><p><img src="https://img10.360buyimg.com/cms/jfs/t1/182872/6/133/795112/607f3495Ea178190e/01c683a879c788c5.jpg"></p>'
                      },
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
                    // color: Colors.white,
                    borderRadius: BorderRadius.all(
                      Radius.circular(4),
                    ),
                    // image: DecorationImage(
                    //   image: AssetImage("images/game1.png"),
                    //   fit: BoxFit.cover,
                    // ),
                  ),
                  child: Container(
                      margin: const EdgeInsets.all(0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          // sizeBoxPadding(w: 0, h: 10),

                          ExtendedImage.network(
                            RequestConfig.baseUrl +
                                RequestConfig.imagePath +
                                listModel['iconImg'],
                            fit: BoxFit.fill,
                            height: itemWidth,
                            width: itemWidth,
                            shape: BoxShape.rectangle,
                            borderRadius:
                                BorderRadius.all(Radius.circular(4.0)),
                          ),

                          sizeBoxPadding(w: 0, h: 12),
                          Container(
                            width: itemWidth,
                            padding: EdgeInsets.only(left: 0, right: 0),
                            height: 58,
                            alignment: Alignment.topLeft,
                            child: RichText(
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.left,
                              text: TextSpan(
                                text: listModel['goodsName'],
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 14,
                                ),
                                children: <TextSpan>[
                                  TextSpan(
                                    text: '',
                                    style: TextStyle(
                                        fontSize: 14,
                                        color: AppTheme.themeHightColor),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          sizeBoxPadding(w: 0, h: 10),
                          Container(
                            width: itemWidth,
                            padding: EdgeInsets.only(left: 0, right: 0),
                            // height: 40,
                            alignment: Alignment.topLeft,
                            child: RichText(
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.left,
                              text: TextSpan(
                                text: '${listModel['goodsPrize']}',
                                style: TextStyle(
                                  color: AppTheme.themeHightColor,
                                  fontSize: 14,
                                ),
                                children: <TextSpan>[
                                  TextSpan(
                                    text: '',
                                    style: TextStyle(
                                        fontSize: 14, color: Colors.black),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          // sizeBoxPadding(w: 0, h: 10),
                        ],
                      )),
                )))
        // )
        ;
  }
}
