import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_pickers/pickers.dart';
import 'package:get/get.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

import '../../../util/DefaultAppBar.dart';
import '../../../style/theme.dart';
import '../../../widgets/text_widget.dart';
import 'logic.dart';
import '/widgets/noData_Widget.dart';
import '/widgets/sizebox_widget.dart';

class StatRecordPage extends StatelessWidget {
  final logic = Get.put(StatRecordLogic());

  Widget headItemContainer(String txt0, String txt1) {
    return Container(
      alignment: Alignment.center,
      child: RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
          text: txt0,
          style: TextStyle(fontSize: 20, height: 1.5, color: Colors.black),
          children: [
            TextSpan(
              text: '\n' + txt1,
              style: TextStyle(fontSize: 14, color: AppTheme.themeGreyColor),
            ),

          ],
        ),
      ),
    );
  }

  Widget buildHeadTabView() {
    var size = MediaQuery.of(Get.context!).size;
    double itemWidth = (size.width - 4 * 15 - 1) / 2;
    return Obx(() => Container(
        alignment: Alignment.center,
        // width: size.width - 2*15,
        padding: const EdgeInsets.only(left: 15, right: 15),
        child: Column(children: <Widget>[
          Container(
            height: 86,
            alignment: Alignment.center, //search has ed
            padding: const EdgeInsets.only(left: 15, right: 15),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(8.0)),
              color: Colors.white,
            ),
            child: Padding(
              padding:
              const EdgeInsets.only(left: 0, right: 0, top: 0, bottom: 0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    // margin: const EdgeInsets.only(left: 15, right: 15),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          GestureDetector(
                            onTap: () {},
                            child: Container(
                              width: itemWidth,
                              child: headItemContainer(
                                  logic.headDatas['A'].toString(),
                                  'A'.tr),
                            ),
                          ),

                          Container(
                            height: 27,
                            width: 1,
                            color: Color(0xffEEEEEE),
                          ),

                          // Expanded(child: SizedBox()),
                          GestureDetector(
                            onTap: () {},
                            child: Container(
                              width: itemWidth,
                              child: headItemContainer(
                                  logic.headDatas['B'].toString(),
                                  'B'.tr),
                            ),
                          ),

                        ]),
                  )
                ],
              ),
            ),
          )
        ])));
  }

  NestedScrollView buildNestedScrollView() {
    return NestedScrollView(
      controller: logic.scrollController,
      key: const Key('stat'),
      physics: const ClampingScrollPhysics(),
      headerSliverBuilder: (context, innerScrolled) {
        return [
          SliverToBoxAdapter(
            child: Container(
              margin: EdgeInsets.only(top: 10, bottom: 15),
              child: buildHeadTabView(),
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
      resizeToAvoidBottomInset: false, //解决键盘导致溢出页面
      appBar: DefaultAppBar(titleStr: '记录'.tr, actions: [
        IconButton(
          // 左边图标
          icon: Icon(Icons.filter_alt),
          onPressed: () {
            Pickers.showSinglePicker(context,
                data: logic.showTypes,
                selectData: logic.initData.value,
                onConfirm: (p, position) {
                  logic.initData.value = p;
                  logic.choseType.value = logic.choseTypes[position].tr;
                  logic.dataRefresh();
                },
                onChanged: (p, e) => print('chose：$p$e'));
          },
        )
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

  final logic = Get.put(StatRecordLogic());

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

                return cellForRowPro(model, type, index);
              }, childCount: logic.listDataFirst.length),
            ),
          ],
        ));
  }

  Widget headItemContainer(String txt0, String txt1, int i) {
    return Container(
      alignment: i == 0
          ? Alignment.centerLeft
          : i == 1
          ? Alignment.center
          : Alignment.centerRight,
      child: RichText(
        textAlign: TextAlign.left,
        text: TextSpan(
          text: txt0,
          style: TextStyle(fontSize: 18, height: 2, color: Colors.black),
          children: <TextSpan>[
            TextSpan(
              text: '\n' + txt1,
              style: TextStyle(fontSize: 12, color: AppTheme.themeGreyColor),
            ),
          ],
        ),
      ),
    );
  }

  Widget cellForRowPro(var listModel, int type, int index) {
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
                Get.toNamed('/',
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
                          Container(
                            // margin: const EdgeInsets.only(left: 8, right: 8),
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  Container(
                                    width: itemWidth,
                                    child: headItemContainer(
                                        '${listModel['prize']}', 'a'.tr, 0),
                                  ),
                                  // Expanded(child: SizedBox()),

                                  Container(
                                    width: itemWidth,
                                    child: headItemContainer(
                                        '${(0.2229).toStringAsFixed(1)}%',
                                        'b'.tr,
                                        1),
                                  ),
                                  // Expanded(child: SizedBox()),
                                  Container(
                                    width: itemWidth,
                                    child: headItemContainer(
                                        '${listModel['validDay']}',
                                        'c'.tr,
                                        2),
                                  ),
                                ]),
                          ),
                          sizeBoxPadding(w: 0, h: 20),
                          Container(
                            // margin: const EdgeInsets.only(left: 8, right: 8),
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  Container(
                                    width: 140,
                                    height: 36,
                                    color: Colors.transparent,
                                    child: Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                      MainAxisAlignment.start,
                                      children: [
                                        Container(
                                            alignment: Alignment.center,
                                            decoration: const BoxDecoration(
                                              color: AppTheme.themeHightColor,
                                              borderRadius: BorderRadius.all(
                                                Radius.circular(10.0),
                                              ),
                                            ),
                                            child: StepProgressIndicator(
                                              fallbackLength: 140,
                                              crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                              MainAxisAlignment.start,
                                              totalSteps: 100,
                                              currentStep: 70,
                                              //double valProgress = double.parse(listModel['prog'].toString()) ;
                                              // (valProgress * 100)<1?1: (valProgress * 100).toInt(),
                                              size: 8,
                                              padding: 0,
                                              selectedColor:
                                              // listModel['progress']==1? Colors.transparent:
                                              AppTheme.themeHightColor,
                                              unselectedColor:
                                              Color(0xffEEEEEE),
                                              roundedEdges:
                                              Radius.circular(10),
                                              // Radius.circular(listModel['progress']==1?0:10),

                                              // selectedGradientColor: LinearGradient(
                                              //   begin: Alignment.topLeft,
                                              //   end: Alignment.bottomRight,
                                              //   colors: [Colors.yellowAccent, Colors.deepOrange],
                                              // ),
                                              // unselectedGradientColor: LinearGradient(
                                              //   begin: Alignment.topLeft,
                                              //   end: Alignment.bottomRight,
                                              //   colors: [Colors.black, Colors.blue],
                                              // ),
                                            )),
                                        Expanded(child: SizedBox()),
                                        ultimatelyLRTxt(
                                            textl: 'Progress'.tr,
                                            textlColor: Colors.black,
                                            textr:
                                            '${(0.22229).toStringAsFixed(1)}%'),
                                      ],
                                    ),
                                  ),
                                  Expanded(child: SizedBox()),
                                  Container(
                                    width: 96,
                                    height: 36,
                                    child: OutlinedButton(
                                      style: ButtonStyle(
                                          backgroundColor:
                                          MaterialStateProperty.all(
                                              !unLock
                                                  ? AppTheme
                                                  .themeGreyColor
                                                  : AppTheme
                                                  .themeHightColor),
                                          shape: MaterialStateProperty.all(
                                              RoundedRectangleBorder(
                                                  borderRadius:
                                                  BorderRadius.circular(
                                                      4))),
                                          side: MaterialStateProperty.all(
                                              BorderSide(
                                                  color:
                                                  Colors.transparent))),
                                      child: Text(
                                        unLock ? 'Join'.tr : 'Off'.tr,
                                        style: TextStyle(
                                            fontSize: 14,
                                            color: Color(0xffffffff)),
                                      ),
                                      onPressed: () {
                                        // logic.handleAlert(
                                        //     context, listModel);
                                      },
                                    ),
                                  ),
                                ]),
                          ),
                        ])),
              )))
    // )
        ;
  }

  Widget cellForRow(var listModel, int type, int index) {
    return
        Column(children: <Widget>[
      GestureDetector(
          onTap: () {},
          child: Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(0.0)),
                color: Colors.white,
              ),
              child: Container(
                padding: EdgeInsets.all(15),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                          Container(
                              child: Text(
                            'bb',

                            style: TextStyle(fontSize: 14),
                            textAlign: TextAlign.left,
                          )),
                          Container(
                              margin: EdgeInsets.only(top: 8),
                              child: Text(listModel['createTimeStr'],
                                  style: TextStyle(
                                      fontSize: 12, color: Color(0xff999999))))
                        ])),
                    Expanded(
                        flex: 1,
                        child: Container(
                          child: Text(
                            '${listModel['amount']}',
                            style: TextStyle(
                                color:  Color(0xff0F4141)),
                            textAlign: TextAlign.right,
                          ),
                        ))
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
