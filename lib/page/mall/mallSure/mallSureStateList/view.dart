import 'dart:async';
import 'dart:math';
import 'dart:core';
import 'package:container_tab_indicator/container_tab_indicator.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_timer_countdown/flutter_timer_countdown.dart';
import 'package:get/get.dart';
import '../../../../style/theme.dart';
import '../../../setting/setAddrList/view.dart';
import 'logic.dart';
import '/widgets/noData_Widget.dart';
import '/widgets/sizebox_widget.dart';
import '/widgets/button_widget.dart';
import '/widgets/text_widget.dart';

// class TaskStateListPage extends StatelessWidget {

class MallSureStateListPage extends StatefulWidget {
  int type;
  MallSureStateListPage({
    Key? key,
    this.type = 0,
  }) : super(key: key);

  @override
  createState() => _MallSureStateListPageState();

  // void requestListData(){///Out need
  //   print('page - logic refresh');
  //   TaskStateListLogic logic = Get.find<TaskStateListLogic>();
  //   logic.type = type;
  //   // logic.postRequestToken();
  //   logic.requestListData(true);
  // }
}

class _MallSureStateListPageState extends State<MallSureStateListPage>
    with AutomaticKeepAliveClientMixin {
  late final MallSureStateListLogic logic;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    logic = MallSureStateListLogic(widget.type);
    Get.put(logic, tag: widget.type.toString());
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    Get.delete<MallSureStateListLogic>(tag: widget.type.toString());
  }

  final tabNames = <String>[];

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return
        // KeyboardDismisser(// or no scroll
        //   gestures: [
        //   GestureType.onTap,
        //   GestureType.onPanUpdateDownDirection,
        //   ],child:
        Scaffold(
            backgroundColor: Colors.white,
            resizeToAvoidBottomInset: false, //解决键盘导致溢出页面
            body: SafeArea(
                child:


                    Stack(children: <Widget>[
              Column(children: <Widget>[
                Expanded(
                  flex: 1,
                  child: Obx(() => logic.listModel.isNotEmpty
                      ? Container(
                          width: double.infinity,
                          child: SingleChildScrollView(
                              child:
                                  cellForRow(logic.listModel, logic.type, 0)),
                        )
                      // ListView(
                      //     padding: EdgeInsets.only(left: 0, right: 0),
                      //     // physics: BouncingScrollPhysics(),
                      //     // shrinkWrap: true,
                      //     scrollDirection: Axis.vertical,
                      //     children: <Widget>[
                      //       cellForRow(logic.listModel,logic.type, 0),
                      //       SizedBox(height: 100,),
                      //       ])

                      // cellForRow(logic.listModel,logic.type, 0)
                      : noDataWidget(
                          mainAxisAlignment: MainAxisAlignment.start,
                          topPadding: 30)),
                  // Container(
                  //   padding: const EdgeInsets.only(left: 0, right: 0),
                  //   child:
                  //   EasyRefreshCustom(type: 0,),
                  // ),
                ),
                Column(children: [
                  Obx(
                    () => Visibility(
                      child: Column(
                        children: [
                          customFootFuncBtn('立即兑换'.tr, () {

                            logic.postUnlock();
                          }),
                          SizedBox(
                            height: 0,
                          ),
                        ],
                      ),
                      visible: logic.listModel.isNotEmpty,
                    ),
                  ),
                ]),
              ]),
            ])))
        // )
        ;
  }

  Widget cellForRow(var listModel, int type, int index) {
    String addr = '${listModel['name']}';
    String orderId = '${listModel['id']}';

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
          divideLine(),
          Padding(
            padding: const EdgeInsets.only(left: 15, right: 15),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                // divideLine(),
                // SizedBox(height: 5,),

                Visibility(
                  child: InkWell(
                    onTap: () async {
                      logic.result.value =
                          await Get.to(SetAddrListPage(), arguments: orderId);
                      if (logic.result.value.isNotEmpty) {
                        listModel['contacts'] = logic.result.value['contacts'];
                        listModel['phone'] = logic.result.value['phone'];
                        listModel['address'] = logic.result.value['address'];
                        listModel['use'] = logic.result.value['use'];
                      }
                    },
                    child: Container(
                        // height: 88,
                        alignment: Alignment.center,
                        margin: const EdgeInsets.only(top: 15, bottom: 15),
                        child: Row(children: [
                          // imageCircular(
                          //   w: 100,
                          //   h: 100,
                          //   radius: 0,
                          //   fit: BoxFit.cover,
                          //   image:'assets/images/home/homeTool0.png',),
                          //
                          //
                          // sizeBoxPadding(w: 10, h: 0),
                          Expanded(
                            flex: 1,
                            child: Container(
                              alignment: Alignment.topLeft,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  textContainer(
                                      text: '${listModel['contacts']}' +
                                          '  ' +
                                          '${listModel['phone']}',
                                      textAlign: TextAlign.left,
                                      continerAlign: Alignment.topLeft),
                                  SizedBox(
                                    height: 10,
                                  ),

                                  Container(
                                    height: 30,
                                    alignment: Alignment.bottomLeft,
                                    child: RichText(
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      textAlign: TextAlign.left,
                                      text: TextSpan(
                                        text: addr,
                                        style: TextStyle(
                                          color: AppTheme.themeGreyColor,
                                          fontSize: 14,
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

                                  // Row(
                                  //     crossAxisAlignment: CrossAxisAlignment.end,
                                  //     children: [
                                  //
                                  //       textContainer(
                                  //           color: AppTheme.themeHightColor,
                                  //           text: '\n' + '56.12',
                                  //           textAlign:TextAlign.left,
                                  //           continerAlign:Alignment.bottomLeft),
                                  //
                                  //       Expanded(child: SizedBox()),
                                  //
                                  //       textContainer(
                                  //           color: AppTheme.themeHightColor,
                                  //           text:   'x2',
                                  //           textAlign:TextAlign.right,
                                  //           continerAlign:Alignment.bottomRight),
                                  //
                                  //
                                  //     ]),
                                ],
                              ),
                            ),
                          ),

                          // Expanded(child: SizedBox()),

                          Visibility(
                            child: arrowForward(),
                            visible: type == 0,
                          ),
                        ])),
                  ),
                  visible: (addr.isNotEmpty && type == 0),
                ),

                Visibility(
                  child: InkWell(
                    onTap: () async {
                      logic.result.value =
                          await Get.to(SetAddrListPage(), arguments: orderId);
                      if (logic.result.value.isNotEmpty) {
                        listModel['contacts'] = logic.result.value['contacts'];
                        listModel['phone'] = logic.result.value['phone'];
                        listModel['address'] = logic.result.value['address'];
                        listModel['use'] = logic.result.value['use'];
                      }
                      //logic.addrList.isNotEmpty?'/setAddrList':
                      //                                 '/setAddAddr'
                    },
                    child: Container(
                      height: 48,
                      alignment: Alignment.center,
                      // margin: const EdgeInsets.only(left: 8, right: 8),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            textContainer(
                                text: '您尚未添加收货地址'.tr,
                                color: AppTheme.themeGreyColor,
                                textAlign: TextAlign.left,
                                continerAlign: Alignment.centerLeft),
                            Expanded(child: SizedBox()),
                            Visibility(
                              child: arrowForward(),
                              visible: 0 == 0,
                            ),
                          ]),
                    ),
                  ),
                  visible: (addr.isEmpty && type == 0),
                ),

                Visibility(
                  child: divideLine(),
                  visible: type == 0,
                ),

                sizeBoxPadding(w: 0, h: 15),

                Column(
                  children: [
                    Container(
                      // margin: const EdgeInsets.only(left: 8, right: 8,top: 8),
                        child: Row(children: [
                          ExtendedImage.network(
                                listModel['iconBig'],
                            fit: BoxFit.cover,
                            height: 100,
                            width: 100,
                          ),

                          // imageCircular(
                          //   w: 100,
                          //   h: 100,
                          //   radius: 0,
                          //   fit: BoxFit.cover,
                          //   image:'assets/images/bottom/Rectangle903.png',),

                          sizeBoxPadding(w: 10, h: 0),
                          Expanded(
                            flex: 1,
                            child: Container(
                              alignment: Alignment.topLeft,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment:
                                CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    height: 40,
                                    alignment: Alignment.topLeft,
                                    child: RichText(
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      textAlign: TextAlign.left,
                                      text: TextSpan(
                                        text: listModel['name'],
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 14,
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
                                  textContainer(
                                      color: Colors.grey,
                                      fontSize: 12,
                                      text: '\n' +

                                          '：' +
                                          '' +
                                          double.parse(listModel['prize']
                                              .toString())
                                              .toString() +
                                          '(' +
                                          '比例'.tr +
                                          '${(listModel['prize'] * 100).toStringAsFixed(1)}%' +
                                          ')',
                                      textAlign: TextAlign.left,
                                      continerAlign: Alignment.bottomLeft),
                                  Row(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.end,
                                      children: [
                                        textContainer(
                                            color: AppTheme.themeHightColor,
                                            text: '\n' +
                                                double.parse(listModel[
                                                'prize']
                                                    .toString())
                                                    .toString(),
                                            textAlign: TextAlign.left,
                                            continerAlign:
                                            Alignment.bottomLeft),
                                        Expanded(child: SizedBox()),
                                        textContainer(
                                            color: AppTheme.themeHightColor,
                                            text: 'x' +
                                                double.parse(listModel[
                                                'prize']
                                                    .toString())
                                                    .toString(),
                                            textAlign: TextAlign.right,
                                            continerAlign:
                                            Alignment.bottomRight),
                                      ]),
                                ],
                              ),
                            ),
                          ),
                        ])),
                    sizeBoxPadding(w: 0, h: 10),
                    Container(
                      // margin: const EdgeInsets.only(left: 8, right: 8),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              alignment: Alignment.centerLeft,
                              child: RichText(
                                textAlign: TextAlign.left,
                                text: TextSpan(
                                  text: '',
                                  style: TextStyle(
                                      fontSize: 18,
                                      color: Colors.transparent),
                                  children: <TextSpan>[
                                    TextSpan(
                                      text:
                                          '：' +
                                          listModel['name'],
                                      style: TextStyle(
                                          fontSize: 12,
                                          color: Colors.grey),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Expanded(child: SizedBox()),
                            Container(
                              alignment: Alignment.centerLeft,
                              child: RichText(
                                textAlign: TextAlign.left,
                                text: TextSpan(
                                  text: '需'.tr + '：',
                                  style: TextStyle(
                                      fontSize: 12, color: Colors.grey),
                                  children: <TextSpan>[
                                    TextSpan(
                                      text: double.parse(
                                          listModel['prize']
                                              .toString())
                                          .toString(),
                                      style: TextStyle(
                                          fontSize: 16,
                                          color:
                                          AppTheme.themeHightColor),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ]),
                    ),
                  ],
                ),
                sizeBoxPadding(w: 0, h: 15),
                divideLine(),
                const SizedBox(height: 20),
                Container(
                    alignment: Alignment.topLeft,
                    margin: EdgeInsets.only(bottom: 10),
                    child: Text(
                      '数量'.tr,
                      style: TextStyle(color: Colors.black, fontSize: 12),
                    )),

                Container(
                    height: 48,
                    child: TextField(
                      controller: logic.controller,
                      // keyboardType: TextInputType.number,
                      inputFormatters: [
                        // FilteringTextInputFormatter.allow(RegExp('[0-9]')),
                        FilteringTextInputFormatter.allow(RegExp(r'[0-9.]'
                            r'')),
                      ],
                      decoration: InputDecoration(
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 8, vertical: 10),
                        hintText: '请输入数量'.tr,
                        hintStyle: TextStyle(color: Color(0xff999999)),
                        counterText: '',
                        suffixIcon: IconButton(
                            icon: Icon(Icons.cancel,
                                size: 18,
                                color: logic.cTxt.value > 0.0
                                    ? Color(0xffCCCCCC)
                                    : Colors.transparent),
                            onPressed: () {
                              logic.cTxt.value = 0.0;
                              logic.controller.text = '';
                            }),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(5)),
                        ),

                        ///设置输入框可编辑时的边框样式
                        enabledBorder: OutlineInputBorder(
                          ///设置边框四个角的弧度
                          borderRadius: BorderRadius.all(Radius.circular(5)),

                          ///用来配置边框的样式
                          borderSide: BorderSide(
                            ///设置边框的颜色
                            color: Color(0xffDDDDDD),

                            ///设置边框的粗细
                            width: 1.0,
                          ),
                        ),

                        ///用来配置输入框获取焦点时的颜色
                        focusedBorder: OutlineInputBorder(
                          ///设置边框四个角的弧度
                          borderRadius: BorderRadius.all(Radius.circular(5)),

                          ///用来配置边框的样式
                          borderSide: BorderSide(
                            ///设置边框的颜色
                            color: AppTheme.themeHightColor,

                            ///设置边框的粗细
                            width: 1.0,
                          ),
                        ),
                      ),
                      style: const TextStyle(color: Colors.black, fontSize: 14),
                      maxLength: 12,
                      onChanged: logic.textFieldChanged,
                      autofocus: false,
                    )),

                const SizedBox(height: 30),

                Container(
                  // margin: const EdgeInsets.only(left: 8, right: 8),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        // sizeBoxPadding(w: 0, h: 20),

                        ultimatelyLRTxt(
                          textl:  '消耗'.tr,
                          textr:
                              '${(listModel['prize'] * (logic.cTxt.value)).toStringAsFixed(1)}',
                          textrColor: AppTheme.themeHightColor,
                        ),
                        sizeBoxPadding(w: 0, h: 20),
                        Visibility(
                          child: Container(
                            // margin: const EdgeInsets.only(left: 8, right: 8),
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  ultimatelyLRTxt(
                                      textl: '折算'.tr,
                                      textr:
                                          '${(listModel['prize'] * (logic.cTxt.value) / listModel['prize']).toStringAsFixed(1)}'),
                                  sizeBoxPadding(w: 0, h: 23),
                                  textContainer(
                                      textAlign: TextAlign.left,
                                      continerAlign: Alignment.topLeft,
                                      text: '比例'.tr +
                                          '：' +
                                          '${listModel['prize']}',
                                      fontSize: 12,
                                      color: AppTheme.themeHightColor),
                                  sizeBoxPadding(w: 0, h: 20),
                                ]),
                          ),
                          visible: type == 1,
                        ),
                      ]),
                ),

                const SizedBox(height: 1),

                Container(
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: Container(
                          //padding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                          child: textContainer(
                              text: type == 0
                                  ? '剩余时间'.tr
                                  : type == 1
                                  ? '返佣时间'.tr
                                  : type == 2
                                  ? '解冻时间'.tr
                                  : '剩余时间'.tr,
                              color: Colors.grey,
                              continerAlign: Alignment.centerLeft),
                        ),
                      ),
                      TimerCountdown(
                        format: CountDownTimerFormat
                            .daysHoursMinutesSeconds,
                        endTime: DateTime.now().add(
                          Duration(
                            days: 0,
                            hours: 0,
                            minutes: 0,
                            seconds: 13,//int
                          ),
                        ),
                        onEnd: () {
                          print("Timer finished");
                        },
                        timeTextStyle: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.normal,
                          fontSize: 14,
                        ),
                        // colonsTextStyle: TextStyle(
                        //   color: Colors.blue,
                        //   fontWeight: FontWeight.bold,
                        //   fontSize: 14,
                        // ),
                        descriptionTextStyle: TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                        ),
                        spacerWidth: 3,
                        enableDescriptions: false,
                        // daysDescription: "",
                        // hoursDescription: "",
                        // minutesDescription: "",
                        // secondsDescription: "",
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 20),
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
  late MallSureStateListLogic logic;

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
    logic = Get.find<MallSureStateListLogic>(tag: type.toString());
  }

  Widget buildEasyRefresh() {
    return Obx(() => EasyRefresh(
          key: PageStorageKey<int>(type),
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
    // final logic = Get.put(MallSureStateListLogic(type));
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
                  // Get.toNamed('/succ',arguments: listModel['orderId']);

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
                                '${listModel['iconBig']}',
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
                            height: 50,
                            alignment: Alignment.topLeft,
                            child: RichText(
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.left,
                              text: TextSpan(
                                text: listModel['name'],
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
                          sizeBoxPadding(w: 0, h: 12),
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
                                text: '${listModel['prize']}',
                                style: TextStyle(
                                  color: AppTheme.themeHightColor,
                                  fontSize: 14,
                                ),
                                children: <TextSpan>[
                                  TextSpan(
                                    text: ' P',
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
