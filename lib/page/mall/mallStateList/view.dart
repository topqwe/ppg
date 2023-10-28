import 'dart:core';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_swiper_view/flutter_swiper_view.dart';
import 'package:get/get.dart';
import 'package:marquee/marquee.dart';
import '../../../style/theme.dart';
import '../../../util/CustomTagWidget.dart';
import '../../bottom/logic.dart';
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
  late ScrollController scrollController;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    scrollController= ScrollController();
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
        body: Scaffold(
            backgroundColor: Colors.white,
            resizeToAvoidBottomInset: false, //解决键盘导致溢出页面
            body: SafeArea(
                child:
                buildNestedScrollView()

              // Column(children: [//freeze
              //   Container(color: Colors.red,width: 99,height: 120,),
              //
              //   Expanded(child:
              //   EasyRefreshCustom(
              //     type: widget.type,
              //     isCustom: false,
              //   ),
              //   ),
              // ],)


            )));
  }

  NestedScrollView buildNestedScrollView() {
    return

      NestedScrollView(
        //1.head top
        controller: scrollController,
        key: const Key('mallstate'),
        physics: const ClampingScrollPhysics(),
        headerSliverBuilder: (context, innerScrolled) {
          return [
            SliverToBoxAdapter(
              child: Container(
                  margin: EdgeInsets.only(top: 10, bottom: 15),
                  child:
                  Column(children: [
                    // SizedBox(width: 0,height: 10,),
                    //
                    // SearchTextComponent(),

                    // SizedBox(width: 0,height: 0,),
                    HomeAnnounce(type: widget.type,),

                    const SizedBox(
                      height: 5,
                    ),
                    HomeBanner(type: widget.type,),
                    Row(children: [
                      SizedBox(width: 10,),
                      Text(
                        '类别'.tr,
                        style:  TextStyle(fontSize: 15,color: Colors.black),
                      ),
                    ],),

                    Obx(() => SizedBox(
                        height: 50,
                        child:
                        //   GridView.builder(
                        //   shrinkWrap: true,
                        //   padding: EdgeInsets.only(left: 10, right: 10, bottom: 0), //用 Nest的时候
                        //   // padding: EdgeInsets.symmetric(vertical: 6),
                        //   physics: const NeverScrollableScrollPhysics(),
                        //   //Grids
                        //   gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        //     crossAxisCount: logic.tagsModel.length, //Grid按两列显示
                        //     // crossAxisCount: count,
                        //     childAspectRatio: .8,
                        //     crossAxisSpacing: 10,
                        //     mainAxisSpacing: 10,
                        //   ),
                        //   itemBuilder: (context, index) {
                        //     var data = logic.tagsModel[index];
                        //     return _buildGridItem(data,selectId: logic.tagsCurrentIndex);
                        //   },
                        //   itemCount: logic.tagsModel.length,
                        // )

                        ListView.builder(
                          // padding: EdgeInsets.only(left: 5, right: 0, bottom: 0),
                          scrollDirection: Axis.horizontal,
                          itemCount: logic.tagsModel.length,
                          shrinkWrap: true, itemBuilder: (BuildContext context, int index) {
                          var item = logic.tagsModel[index];
                          return  _buildGridItem(item,selectId: logic.tagsCurrentIndex);

                        },
                        )

                    ),),


                    const SizedBox(height: 15),
                    Obx(() => Container(
                      height:50,
                      child:CustomTagWidget(
                        selectedBgColor: AppTheme.themeHightColor,
                        selectedTextColor:Colors.white ,
                        textColor: Colors.black,
                        tabTitleList: logic.sectags.value,
                        select: logic.sectagsCurrentIndex,
                        setradius: 5,
                        onTap: (int index) {
                          setState(() {
                            logic.sectagsCurrentIndex = index;
                            // print("当前选中 $logic.tagsCurrentIndex");
                            if(logic.sectagsCurrentIndex ==3) {
                              Get.offNamed('/index');
                              final logicb = Get.put(BottomLogic());
                              logicb.changePage(1);
                            }
                          }
                          );
                        },
                      ),
                    ),),

                    // const SizedBox(height: 5),
                  ],)

              ),
            ),

          ];
        },
        body: EasyRefreshCustom(
          type: widget.type,
          isCustom: false,
        )
        ,
      )
    // ),
        ;
  }
  _buildGridItem(var item,{required int selectId}) {
    var itemId = int.parse(item['id']);
    return GestureDetector(
      onTap: () {
        setState(() {
          logic.tagsCurrentIndex = itemId;
        });
        //
      },
      child:
      // Row(children: [
      Container(
        margin: const EdgeInsets.symmetric(horizontal: 5),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25.0),
            color: selectId == itemId? AppTheme.themeHightColor:Colors.white),
        width: 50,
        height: 50,
        child: Column(
          children: [
            const SizedBox(height: 7,),
            ExtendedImage.network(
              item['iconBig'],
              width: ScreenUtil().setWidth(24),
              height: ScreenUtil().setWidth(24),
              fit: BoxFit.fill,
              cache: true,
              shape: BoxShape.circle,
              borderRadius: const BorderRadius.all(Radius.circular(12.0)),
              //cancelToken: cancellationToken,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 2),
              child: Text(
                item['name'],
                style:   TextStyle(fontSize: 11,color: selectId == itemId? Colors.white:AppTheme.hintColor),
              ),
            ),
          ],
        ),
      ),
      // ],),

    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}

class HomeBanner extends StatefulWidget {
  int type;
  String typeStr;
  bool isSliver;
  HomeBanner({
    Key? key,
    this.type = 0,
    this.typeStr = '',
    this.isSliver = false,
  }) : super(key: key);

  @override
  HomeBannerState createState() => HomeBannerState();
}

class HomeBannerState extends State<HomeBanner> {
  // late bool isSliver;
  late MallStateListLogic logic;
  @override
  void initState() {
    super.initState();
    logic = Get.find<MallStateListLogic>(tag: widget.type.toString());
    // isSliver = widget.isSliver;
  }

  @override
  Widget build(BuildContext context) {
    return widget.isSliver
        ? Obx(() => SliverToBoxAdapter(child: buildBasicView()))
        : Obx(() => buildBasicView());
  }

  Widget buildBasicView() {
    return Row(children: [
      Expanded(flex: 1, child: Container()),
      Container(
          color: Colors.transparent,
          // padding: EdgeInsets.only(left: 15,right: 15),
          // padding: const EdgeInsets.only(left: 15, right: 15),
          width: ScreenUtil().setWidth(345),
          height: ScreenUtil().setHeight(170), //
          child: Container(
            width: ScreenUtil().setWidth(345),
            decoration: const BoxDecoration(

              borderRadius: BorderRadius.all(
                Radius.circular(6),
              ),
              boxShadow: [
                BoxShadow(
                  blurRadius: 20,
                  //阴影范围
                  spreadRadius: 1,
                  //阴影浓度
                  offset: Offset(0.0, 5.0),
                  //阴影y轴偏移量
                  color: Color.fromRGBO(55, 63, 69, 0.1), //阴影颜色
                ),
              ],
            ),
            child: Swiper(
              itemBuilder: (BuildContext context, int index) {
                return

                  logic.banners.isNotEmpty
                      ?
                  // (logic.banners[index]['isJump']==1)?
                  // InkWell(onTap: (){
                  //   openInAppWebView(Get.context!, [
                  //     logic.banners[index]['name'],
                  //     logic.banners[index]['link'],
                  //   ]);
                  // },child:
                  // ExtendedImage.network(
                  //   logic.banners[index]['bannerImg'],
                  //   fit: BoxFit.fill,
                  //   cache: false,
                  //   // border: Border.all(color: Colors.red, width: 1.0),
                  //   shape: BoxShape.rectangle,
                  //   borderRadius:
                  //   BorderRadius.all(Radius.circular(4.0)),
                  //
                  //   // height: 74,
                  //   // width: 74,
                  // )
                  // )
                  //     :
                  ExtendedImage.network(
                    logic.banners[index]['bannerImg'],
                    fit: BoxFit.fill,
                    cache: false,
                    // border: Border.all(color: Colors.red, width: 1.0),
                    shape: BoxShape.rectangle,
                    borderRadius:
                    BorderRadius.all(Radius.circular(4.0)),

                    // height: 74,
                    // width: 74,
                  )
                      :
                  Image.asset(
                    ('assets/images/home/banner0.png'), //$index
                    fit: BoxFit.fill,
                  )


                ;
              },
              duration: 1000,
              scale: 1.00,
              autoplay: true,
              itemCount: logic.banners.isNotEmpty ? logic.banners.length : 2,
            ),
          )),
      Expanded(flex: 1, child: Container()),
    ]);
  }
}


class HomeAnnounce extends StatefulWidget {
  int type;
  String typeStr;
  bool isSliver;
  HomeAnnounce({
    Key? key,
    this.type = 0,
    this.typeStr = '',
    this.isSliver = false,
  }) : super(key: key);

  @override
  HomeAnnounceState createState() => HomeAnnounceState();
}

class HomeAnnounceState extends State<HomeAnnounce> {
  List texts = [];
  late MallStateListLogic logic;
  @override
  void initState() {
    super.initState();
    logic = Get.find<MallStateListLogic>(tag: widget.type.toString());
    // requestData();
  }

  String convertStrArrToString(List list) {
    List tempList = [];
    String str = '';
    for (var f in list) {
      tempList.add(f); //.title
    }

    for (var f in tempList) {
      if (str == '') {
        str = "$f";
      } else {
        str = "$str" "  " "$f";
      }
    }
    return str;
  }

  requestData() async {
    texts = [
    ];

    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return widget.isSliver
        ? SliverToBoxAdapter(child: buildBasicView())
        : buildBasicView();
  }

  Widget buildBasicView() {
    return Container(
      // padding: EdgeInsets.only(top: 10),
        margin: const EdgeInsets.only(left: 15, right: 15, top: 0),
        height: 36,
        decoration: const BoxDecoration(
          color: Color(0xffffffff),
          borderRadius: BorderRadius.all(
            Radius.circular(23),
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: 5,
            ),
            SizedBox(
                width: 32,
                height: 32,
                child: Center(
                    child: Image.asset('assets/images/home/homeAnn.png',
                        width: 17, height: 17))),
            Expanded(
              flex: 1,
              child: Obx(
                    () => Marquee(text: logic.texts.first),
              ),


            ),
            SizedBox(
              width: 15,
            ),
          ],
        ));
  }
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
            childAspectRatio: .65,//越大越小
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
                    childAspectRatio: .8,//越大越小
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
                  logic.pushNextPage(listModel);

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
                            height: 58,
                            alignment: Alignment.topLeft,
                            child: RichText(
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.left,
                              text: TextSpan(
                                text: '${listModel['name']}',
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
                                text: '${listModel['prize']}',
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
