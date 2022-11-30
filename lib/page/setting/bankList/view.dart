import 'dart:async';
import 'dart:math';
import 'package:container_tab_indicator/container_tab_indicator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../util/DefaultAppBar.dart';
import '../../../style/theme.dart';

import 'logic.dart';
import '/widgets/noData_Widget.dart';
import '/widgets/text_widget.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class BankListPage extends StatelessWidget {
  var logic = Get.put(BankListLogic());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      appBar: DefaultAppBar(
        titleStr: Get.arguments == '0' ? '账户管理'.tr : '选择账户'.tr,
      ),
      body: SafeArea(
          child: Stack(children: <Widget>[
        Column(children: <Widget>[
          Expanded(
            flex: 1,
            child: Container(
              padding: const EdgeInsets.only(left: 0, right: 0),
              child: EasyRefreshCustom(
                type: 0,
              ),
            ),
          ),
          Column(children: [
            Container(
              // alignment: Alignment.center,
              // margin:
              // const EdgeInsets
              //     .only(
              //     right: 10),
              padding: const EdgeInsets.only(left: 15, right: 15),
              height: 44,
              child: GestureDetector(
                child: Container(
                  height: 44,
                  // color: AppTheme.themeHightColor,
                  padding: EdgeInsets.only(left: 15, right: 15),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    color: Colors.white,
                    border: Border.all(
                      style: BorderStyle.solid,
                      color: AppTheme.themeHightColor,
                      width: 1,
                    ),
                  ),

                  alignment: Alignment.center,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Icon(
                        Icons.add,
                        color: AppTheme.themeHightColor,
                        size: 15,
                      ),
                      syText(
                          text: ' ' + '新增账户'.tr,
                          color: AppTheme.themeHightColor,
                          fontSize: 16),
                    ],
                  ),
                ),
                onTap: () {
                  Get.toNamed('/addBank', arguments: '0');
                },
              ),
              // customFootFuncBtn('新增账户'.tr, (){
              //   Get.toNamed('/addBank',arguments: '0');
              // }),
            ),
            SizedBox(
              height: 15,
            ),
          ]),
        ]),
      ])),
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

  final logic = Get.put(BankListLogic());

  @override
  void initState() {
    super.initState();
    type = widget.type;
  }

  Widget buildEasyRefreshCustom() {
    return Obx(() => logic.listDataFirst.isEmpty
        ? noAddrDataWidget(
            mainAxisAlignment: MainAxisAlignment.start, topPadding: 30)
        : ListView.builder(
            key: UniqueKey(),
            itemBuilder: (BuildContext context, int index) {
              var model = logic.listDataFirst[index];

              return cellForRow(model, type, index);
            },
            itemCount: logic.listDataFirst.length,
          ));

    //     Obx(() =>
    //       EasyRefresh.custom(
    //         key: PageStorageKey<int>(type),
    //         controller: logic.easyRefreshController,
    //         emptyWidget:
    //        logic.listDataFirst.isEmpty? noAddrDataWidget(mainAxisAlignment: MainAxisAlignment.start, topPadding: 30):null,
    //
    //         header: ClassicalHeader(
    //           infoText: ('下拉刷新'.tr),
    //           refreshedText: ('刷新完成'.tr),
    //           refreshText: ('刷新中...'.tr),
    //           noMoreText: '',
    //         ),
    //         footer: ClassicalFooter(
    //           infoText: ('上拉加载'.tr),
    //           loadingText: ('加载中...'.tr),
    //           loadedText: ('加载完毕'.tr),
    //           noMoreText: ('没有更多啦'.tr),
    //         ),
    //         onRefresh: () async {
    //           await logic.dataRefresh();
    //           logic.easyRefreshController.finishLoad(success: true,noMore:true);
    //         },
    //         onLoad: () async {
    //           logic.hasMoreData?await logic.loadMore():logic.easyRefreshController.finishLoad(success: true,noMore: true);
    //           }
    //         ,
    //         slivers: [
    //
    //           // SliverOverlapInjector(
    //           //     handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context)),
    //
    //           SliverList(delegate: SliverChildBuilderDelegate(
    //                   (context, index) {
    //                 var model =
    //                 logic.listDataFirst[index];
    //
    //                 return cellForRow(model,type,index);
    //               },
    //               childCount:
    //               logic.listDataFirst.length
    //           ),
    //           ),
    //
    //
    //         ],)
    //   )
    //
    // ;
  }

  Color getRandomColor() {
    /// 生成的字符串固定长度

    List list = [
      Color(0xffFF5252),
      Color(0xff426AB0),
      Color(0xff19B092),
      Color(0xff4378FF),
    ];
    var element = list[Random().nextInt(list.length)];

    return element;
  }

  Widget cellForRow(var listModel, int type, int index) {
    var logic = Get.put(BankListLogic());
    String number = '${listModel['phone']}';
    return Slidable(
      child: Padding(
          padding: const EdgeInsets.only(left: 0, right: 0),
          child: Column(children: <Widget>[
            // Container(height: 10),

            Padding(
                padding: const EdgeInsets.only(left: 0, right: 0),
                child: Container(
                  // height: 90,
                  alignment: Alignment.center, //search has ed
                  padding: const EdgeInsets.only(left: 15, right: 15),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(0.0)),
                    color: Colors.white,
                  ),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.all(Radius.circular(6.0)),
                            color: getRandomColor(),
                          ),
                          padding: const EdgeInsets.only(left: 15, right: 15),
                          margin: const EdgeInsets.only(top: 15),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              // divideLine(),
                              // Container(height: 15,color: Colors.white,),

                              InkWell(
                                child: Column(
                                  children: [
                                    Container(
                                        margin: const EdgeInsets.only(
                                            bottom: 15, top: 15),
                                        child: Row(children: [
                                          Expanded(
                                            flex: 1,
                                            child: Container(
                                              alignment: Alignment.topLeft,
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Row(
                                                    children: [
                                                      Container(
                                                        alignment:
                                                            Alignment.topLeft,
                                                        child: RichText(
                                                          maxLines: 1,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          textAlign:
                                                              TextAlign.left,
                                                          text: TextSpan(
                                                            text: listModel[
                                                                'address'],
                                                            style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .normal,
                                                                fontSize: 14,
                                                                color: Colors
                                                                    .white),
                                                            children: <
                                                                TextSpan>[
                                                              TextSpan(
                                                                text: '',
                                                                style: TextStyle(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    fontSize:
                                                                        14,
                                                                    color: Colors
                                                                        .black),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                      Expanded(
                                                          child: SizedBox()),
                                                      Container(
                                                        alignment:
                                                            Alignment.topRight,
                                                        child: RichText(
                                                          maxLines: 1,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          textAlign:
                                                              TextAlign.right,
                                                          text: TextSpan(
                                                            text: int.parse(listModel[
                                                                            'use']
                                                                        .toString()) ==
                                                                    1
                                                                ? '  ' + '默认'.tr
                                                                : '',
                                                            style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontSize: 14,
                                                                color: Colors
                                                                    .white),
                                                            children: <
                                                                TextSpan>[
                                                              TextSpan(
                                                                text: '',
                                                                style: TextStyle(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    fontSize:
                                                                        14,
                                                                    color: Colors
                                                                        .black),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    height: 10,
                                                  ),
                                                  textContainer(
                                                      color: Colors.white,
                                                      fontSize: 20,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      continerAlign:
                                                          Alignment.centerLeft,
                                                      textAlign: TextAlign.left,
                                                      text: number.length < 4
                                                          ? number
                                                          : '****  ****  ****  ${number.substring(number.length - 4)}'),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ])),
                                  ],
                                ),
                                onTap: () {
                                  if (Get.arguments != '0')
                                    logic.selectRequest(context, listModel);
                                },
                              ),
                            ],
                          ),
                        ),
                      ]),
                )),
          ])),
      endActionPane: ActionPane(
        motion: DrawerMotion(),

        children: [
          SlidableAction(
            flex: 1,
            label: '编辑'.tr,
            foregroundColor: AppTheme.themeHightColor,
            icon: Icons.edit,
            onPressed: (_) => {
              // logic.listDataFirst.removeAt(index)
              Get.toNamed('/addBank', arguments: listModel)
            },
          ),
          SlidableAction(
            flex: 1,
            label: '删除'.tr,
            foregroundColor: Colors.red,
            icon: Icons.delete,
            onPressed: (_) => {
              logic.listDataFirst.removeAt(index),
              logic.delRequest(context, listModel),
            },
          ),
        ], // 'Archive' action
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return buildEasyRefreshCustom();
  }
}
