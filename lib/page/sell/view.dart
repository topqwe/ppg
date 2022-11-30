import 'dart:async';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:get/get.dart';
import '../../style/theme.dart';

import '../../../util/DefaultAppBar.dart';
import '../../api/request/config.dart';
import '../../util/FrequencyClick.dart';
import 'logic.dart';
import '/widgets/noData_Widget.dart';
import '/widgets/sizebox_widget.dart';
import '/widgets/button_widget.dart';

class SellPage extends StatelessWidget {
  final logic = Get.put(SellLogic());

  Widget headItemContainer(String txt0, String txt1) {
    return Container(
      alignment: Alignment.centerLeft,
      child: RichText(
        textAlign: TextAlign.left,
        text: TextSpan(
          text: txt0,
          style: TextStyle(fontSize: 20, color: Colors.black),
          children: <TextSpan>[
            TextSpan(
              text: '\n' + txt1,
              style: TextStyle(fontSize: 12, color: Colors.black),
            ),
          ],
        ),
      ),
    );
  }


  NestedScrollView buildNestedScrollView() {
    return NestedScrollView(
      controller: logic.scrollController,
      key: const Key('category'),
      physics: const ClampingScrollPhysics(),
      headerSliverBuilder: (context, innerScrolled) {
        return [
          SliverToBoxAdapter(
            child: Container(
              height: 1,
            ),
          ),
        ];
      },
      body: EasyRefreshCustom(
        type: 0,
      ),

    )
        // ),
        ;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: DefaultAppBar(titleStr: ''.tr, actions: [
        buttonText(
            w: 100,
            h: 50,
            text: ''.tr,
            textColor: Color(0xff999999),
            textSize: 16,
            onPressed: () {
            }),
      ]),
      body: SafeArea(
        child: buildNestedScrollView(),
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

  final logic = Get.put(SellLogic());

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
    return
        // Padding(
        //     padding: const EdgeInsets.only(left: 0, right: 0),
        //     child:
        Column(children: <Widget>[
      // Container(height: 10),
      GestureDetector(
          onTap: () {
            if (logic.timer_fun2 != null) {
              return;
            }
            logic.timer_fun2 = Timer(
              Duration(milliseconds: Frequency.frequencyCount),
              () {
                logic.timer_fun2 = null;
              },
            );
            logic.handleAlert(context, listModel);
          },
          child: Container(
              height: 80,
              // margin: EdgeInsets.only(top: 10, left: 15, right: 15),
              alignment: Alignment.center,
              //search has ed
              // padding: const EdgeInsets.only(left: 15, right: 15),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(0.0)),
                color: Colors.white,
              ),
              child: Container(
                padding: EdgeInsets.all(15),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ExtendedImage.network(
                      RequestConfig.baseUrl +
                          RequestConfig.imagePath +
                          listModel['iconImg'],
                      fit: BoxFit.fill,
                      width: 40,
                      height: 40,
                      shape: BoxShape.circle,
                    ),
                    SizedBox(
                      width: 14,
                    ),

                    Container(
                        margin: EdgeInsets.only(right: 15),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                  child: Text(
                                'Y'
                                            'L'
                                        .tr +
                                    ':￥' +
                                    '${listModel['rebate']}',
                                style: TextStyle(fontSize: 14),
                                textAlign: TextAlign.left,
                              )),
                              Container(
                                  margin: EdgeInsets.only(top: 8),
                                  child: Text(
                                          ':'
                                              '${listModel['goodsPrize']}'
                                              '-'
                                              '${listModel['prizeReal']}'
                                              'CNY',
                                      style: TextStyle(
                                          fontSize: 12,
                                          color: Color(0xff999999))))
                            ])),
                    Expanded(child: SizedBox()),
                    Container(
                      width: 62,
                      height: 28,
                      child: OutlinedButton(
                        style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(
                                AppTheme.themeHightColor),
                            shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(4))),
                            side: MaterialStateProperty.all(
                                BorderSide(color: Colors.transparent))),
                        child: Text(
                          '出售'.tr,
                          style:
                              TextStyle(fontSize: 12, color: Color(0xffffffff)),
                        ),
                        onPressed: () {
                          if (logic.timer_fun2 != null) {
                            return;
                          }
                          logic.timer_fun2 = Timer(
                            Duration(milliseconds: Frequency.frequencyCount),
                            () {
                              logic.timer_fun2 = null;
                            },
                          );
                          logic.handleAlert(context, listModel);
                        },
                      ),
                    )

                  ],
                ),
              ))),
      divideLine(),
    ])
        // )
        ;
  }

  @override
  Widget build(BuildContext context) {
    return buildEasyRefreshCustom();
  }
}
