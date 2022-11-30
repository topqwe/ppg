import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../util/DefaultAppBar.dart';
import '../../../style/theme.dart';

import 'logic.dart';
import '/widgets/noData_Widget.dart';
import '/widgets/sizebox_widget.dart';
import '/widgets/button_widget.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class SetAddrListPage extends StatelessWidget {
  var logic = Get.put(SetAddrListLogic());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      appBar: DefaultAppBar(
        titleStr: Get.arguments == '0' ? '收货地址管理'.tr : '选择收货地址'.tr,
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
            customFootFuncBtn('新增地址'.tr, () {
              Get.toNamed('/setAddAddr', arguments: '0');
            }),
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

  final logic = Get.put(SetAddrListLogic());

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
    //   Obx(() =>
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

  Widget cellForRow(var listModel, int type, int index) {
    var logic = Get.put(SetAddrListLogic());
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
                  // padding: const EdgeInsets.only(left: 15, right: 15),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(0.0)),
                    color: Colors.white,
                  ),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(left: 15, right: 15),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              divideLine(),
                              // SizedBox(height: 5,),

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
                                                  Container(
                                                    alignment:
                                                        Alignment.topLeft,
                                                    child: RichText(
                                                      textAlign: TextAlign.left,
                                                      text: TextSpan(
                                                        text: listModel[
                                                                'contacts'] +
                                                            '  ' +
                                                            listModel['phone'],
                                                        style: TextStyle(
                                                            //  color: ColorPlate.btnColor,
                                                            //   decoration: TextDecoration.underline
                                                            fontWeight:
                                                                FontWeight
                                                                    .normal,
                                                            fontSize: 14,
                                                            color:
                                                                Colors.black),
                                                        children: <TextSpan>[
                                                          TextSpan(
                                                            text: int.parse(listModel[
                                                                            'use']
                                                                        .toString()) ==
                                                                    1
                                                                ? '  ' + '默认'.tr
                                                                : '',
                                                            style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .normal,
                                                                fontSize: 14,
                                                                color: AppTheme
                                                                    .themeHightColor),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 3,
                                                  ),
                                                  Container(
                                                    height: 30,
                                                    alignment:
                                                        Alignment.bottomLeft,
                                                    child: RichText(
                                                      maxLines: 2,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      textAlign: TextAlign.left,
                                                      text: TextSpan(
                                                        text: listModel[
                                                            'address'],
                                                        style: TextStyle(
                                                          color: AppTheme
                                                              .themeGreyColor,
                                                          fontSize: 14,
                                                        ),
                                                        children: <TextSpan>[
                                                          TextSpan(
                                                            text: '',
                                                            style: TextStyle(
                                                                fontSize: 12,
                                                                color: Colors
                                                                    .grey),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ])),
                                  ],
                                ),
                                onTap: () {
                                  // if(Get.arguments != '0')logic.selectRequest(context, listModel);
                                  if (Get.arguments != '0')
                                    logic.selectResult(context, listModel);
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
              Get.toNamed('/setAddAddr', arguments: listModel)
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
