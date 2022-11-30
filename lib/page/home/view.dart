import 'dart:async';
import 'dart:math';
import 'package:extended_image/extended_image.dart';
import 'package:flex_grid/flex_grid.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:high_chart/high_chart.dart';
import 'SearchPage.dart';
import '/util/CitySelectPage.dart';
import 'package:marquee/marquee.dart';
import 'package:scroll_to_index/scroll_to_index.dart';
import 'package:flutter_swiper_view/flutter_swiper_view.dart';
import 'package:infinite_listview/infinite_listview.dart';
import '../../style/theme.dart';
import '../../util/FlexGrid/flex_grid_source.dart';
import '../../util/FlexGrid/flex_grid_utils.dart';
import '../../util/HorizontalCardPager/card_item.dart';
import '../../util/HorizontalCardPager/horizontal_card_pager.dart';
import '../../util/CustomTagWidget.dart';
import '../../widgets/helpTools.dart';
import '../../util/HorScrollTxtWidget.dart';
import 'logic.dart';
import '/widgets/noData_Widget.dart';
import '/widgets/sizebox_widget.dart';
import '/widgets/image_widget.dart';
import '/widgets/button_widget.dart';
import '/widgets/text_widget.dart';


class HomePage extends StatefulWidget {
  int type;

  HomePage({
    Key? key,
    this.type = 0,
  }) : super(key: key);

  @override
  createState() => HomePageState();
}

class HomePageState extends State<HomePage>
    with TickerProviderStateMixin, AutomaticKeepAliveClientMixin {
// class HomePage extends StatelessWidget {

  final logic = Get.put(HomeLogic());

  PreferredSize buildAppBar() {
    return PreferredSize(
      preferredSize: Size.fromHeight(49),
      child: AppBar(
        backgroundColor: Colors.transparent,
        automaticallyImplyLeading: false,
        centerTitle: false,
        title: Container(
          color: Colors.transparent,
          child: Row(
            children: [
              buttonImage(
                  w: 170, h: 30, imageName: "", text: "", onPressed: () {}),
              Expanded(child: SizedBox()),
              buttonImage(
                  w: 25, h: 25, imageName: "", text: "", onPressed: () {})
            ],
          ),
        ),
      ),
    );
  }

  SliverAppBar buildSliverAppBar() {
    return SliverAppBar(
      automaticallyImplyLeading: false,
      pinned: false,
      // snap: true,
      floating: false,
      expandedHeight: 200,
      flexibleSpace: FlexibleSpaceBar(
        title: const Text('home'),
        background: Image.network(
          '',
          width: ScreenUtil().setWidth(375),
          height: ScreenUtil().setHeight(171),
          fit: BoxFit.fill,
        ),
      ),

      // flexibleSpace: SingleChildScrollView(
      //   physics: NeverScrollableScrollPhysics(),
      //   child: Container(),
      // ),
    );
  }

  SliverPersistentHeader buildSliverPersistentHeaderInNSV() {
    return SliverPersistentHeader(
      pinned: true,
      delegate: SliverSectionHeaderDelegate(
        DecoratedBox(
          decoration: BoxDecoration(
            color: Colors.white,
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 0.0),
            child: buildSPHInNSV(),
          ),
        ),
        120.0,
      ),
    );
  }

  buildSPHInNSV() {
    return Container(
        height: 120,
        // padding: EdgeInsets.only(bottom: 20),
        alignment: Alignment.center,
        // color: Colors.transparent,
        decoration: const BoxDecoration(
          color: Colors.transparent,
          // AppTheme.themeHightColor,
          borderRadius: BorderRadius.all(
            Radius.circular(0),
          ),
          // image: DecorationImage(
          //   image: AssetImage("assets/images/home/naviBarBg.png"),
          //   fit: BoxFit.cover,
          // ),
        ),
        child: Obx(
          () => Container(
            padding: EdgeInsets.only(left: 15, right: 15),
            margin: EdgeInsets.only(top: 35),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                    height: 44,
                    width: 44,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 0.5, vertical: 0.5),
                    decoration: BoxDecoration(
                        border: Border.all(
                            color: const Color(0xffffffff), width: 2),
                        borderRadius: BorderRadius.circular(40)),
                    child: ClipOval(
                      child: logic.barDatas['avatar'] == ''
                          ? imageCircular(
                              w: 44,
                              h: 44,
                              radius: 22,
                              image: 'assets/images/public/avatar.png',
                              fit: BoxFit.fitHeight)
                          : ExtendedImage.network(
                              '${logic.barDatas['avatar']}',
                              fit: BoxFit.cover,
                              height: 44,
                              width: 44,
                              shape: BoxShape.rectangle,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(22.0)),
                            ),
                    )),
                sizeBoxPadding(w: 10, h: 0),
                Expanded(
                    child: syText(
                        fontSize: 16,
                        color: Colors.black,
                        text: '${logic.barDatas['name']}',
                        textAlign: TextAlign.start)),
                buttonImage(
                    w: 25,
                    h: 25,
                    imageName: "",
                    text: "",
                    onPressed: () {

                      pushCityPage(Get.context!, (value) {
                        print(value);
                        logic.barDatas['name']=value;
                        logic.update();
                      }, () { });

                    }),
                SizedBox(
                  width: 10,
                ),
                buttonImage(
                    w: 25, h: 25, imageName: "", text: "", onPressed: () {
                  // Get.toNamed('/index');
                  openPage(SearchPage(), Get.context!);
                })
              ],
            ),
          ),
        ));
  }

  NestedScrollView buildNestedScrollView() {
    return NestedScrollView(
      controller: scrollController,
      key: const Key('category'),
      physics: const ClampingScrollPhysics(),
      headerSliverBuilder: (context, innerScrolled) {
        return [
          buildSliverPersistentHeaderInNSV(),
        ];
      },
      body: buildCustomScrollView(),
    )
        // ),
        ;
  }

  CustomScrollView buildCustomScrollView() {
    return CustomScrollView(
      controller: scrollController,
      //The Scrollbar's ScrollController has no ScrollPosition attached.
      // physics: BouncingScrollPhysics(),
      physics: const AlwaysScrollableScrollPhysics(
        parent: BouncingScrollPhysics(),
      ),
      // shrinkWrap: true,//晃，Lis need
      scrollDirection: Axis.vertical,
      slivers: <Widget>[
        buildSliverAppBar(),
        // HomeBanner(
        //   isSliver: true,
        // ),
        // const SliverPadding(padding: EdgeInsets.all(5)),

        SliverToBoxAdapter(child:
    Container(
    height:50,
    child: CustomTagWidget(
          tabTitleList: logic.tags,
          select: logic.tagsCurrentIndex,
          onTap: (int index) {
            setState(() {
              logic.tagsCurrentIndex = index;
              print("当前选中 $logic.tagsCurrentIndex");
            });
          },
        ),),),

        // HomeAnnounce(
        //   isSliver: true,
        // ),
        // const SliverPadding(padding: EdgeInsets.all(10)),
        HomeTool(
          isSliver: true,
        ),
        // SliverPadding(padding: EdgeInsets.all(5)),
        // Chart(),
        // sliverSectionHeadAction('ProgressHeader'.tr, () {
        //   Get.offNamed('/index');
        //   final logic = Get.put(BottomLogic());
        //   logic.changePage(1);
        // }),
        SliverPadding(padding: EdgeInsets.all(5)),
        const HomeRecList(),
        // sliverSectionHead('Horizontal'.tr),
        // SliverPadding(padding: EdgeInsets.all(5)),
        // HorizontalDataList(),
        // sliverSectionHead('Excel'.tr),
        // const FrozenedRowColumn(),
        // sliverSectionHead('EndlessList'.tr),
        // SliverPadding(padding: EdgeInsets.all(5)),
        // const HomeEndlessList(),
        SliverPadding(padding: EdgeInsets.all(5)),
        sliverSectionHead(''),
      ],
    );
  }

  buildEasyRefresh() {
    return EasyRefresh(
      scrollController: scrollController,
      controller: easyRefreshController,
      key: const PageStorageKey<int>(0),
      enableControlFinishRefresh: false,
      enableControlFinishLoad: true,
      // emptyWidget: logic.listDataFirst.isEmpty? noDataWidget(mainAxisAlignment: MainAxisAlignment.start, topPadding: 30):null,
      // header: ClassicalHeader(
      //   infoText: '下拉刷新'.tr,
      //   refreshedText: '刷新完成'.tr,
      //   refreshText: '刷新中...'.tr,
      //   noMoreText: '',
      // ),
      footer: ClassicalFooter(
        infoText: '上拉加载'.tr,
        loadingText: '加载中...'.tr,
        loadedText: '加载完毕'.tr,
        noMoreText: '没有更多'.tr,
      ),
      // onRefresh: () async {
      //   await logic.dataRefresh();
      //   logic.easyRefreshController.finishLoad(success: true,noMore:false);
      // },
      onLoad: () async {
        await logic.loadMore();
        easyRefreshController.finishLoad(
            success: true, noMore: logic.hasMoreData ? false : true);
      },

      child: ListView(
        children: [
          // SliverPadding(padding: EdgeInsets.all(8)),
          // SliverToBoxAdapter(child: Container(height: 8,color: Colors.white,),),
          HomeBanner(),
          const SizedBox(
            height: 5,
          ),
          HomeAnnounce(),
          const SizedBox(height: 15),
          const HomeToolSwiper(),

          const SizedBox(height: 5),

          const HomeGridSwiper(),

          const SizedBox(height: 5),

          const HomeHorScrollList1(),

          const SizedBox(height: 5),

          const HomeHorScrollList2(),

          const SizedBox(height: 5),

          const HomeMultiGrids(),

          const SizedBox(height: 5),

          const HomeGrid2InRow(),

          const SizedBox(
            height: 5,
          ),
        ],
      ),
    );
  }

  late ScrollController scrollController;
  late EasyRefreshController easyRefreshController;
  bool isScroll = true;

  Offset offset =
  Offset(
      MediaQuery.of(Get.context!).size.width -
      Theme.of(Get.context!).buttonTheme.minWidth ,

      MediaQuery.of(Get.context!).size.height -
          kToolbarHeight -
          MediaQuery.of(Get.context!).padding.top -
          MediaQuery.of(Get.context!).padding.bottom -
          Theme.of(Get.context!).buttonTheme.height
          );

  final double height = 80;

  OverlayEntry? overlayEntry;
  ///显示悬浮控件
  _showFloating(bool isRemove) {
    var overlayState = Overlay.of(context)!;

    overlayEntry = new OverlayEntry(builder: (context) {
      return Stack(
        children: <Widget>[
          new Positioned(
            left: offset.dx,
            top: offset.dy,
            child: _buildFloating(overlayEntry),
          ),
        ],
      );
    });

    ///插入全局悬浮控件
    overlayState.insert(overlayEntry!);
    // if(isRemove)overlayEntry?.remove();
  }

  ///绘制悬浮控件
  _buildFloating(OverlayEntry? overlayEntry) {
    return GestureDetector(
      behavior: HitTestBehavior.deferToChild,
      onPanDown: (details) {
        offset = details.globalPosition - Offset(height / 2, height / 2);
        overlayEntry!.markNeedsBuild();
      },
      onPanUpdate: (DragUpdateDetails details) {
        ///根据触摸修改悬浮控件偏移
        offset = offset + details.delta;
        overlayEntry!.markNeedsBuild();
      },
      onLongPress: () {
        overlayEntry!.remove();
      },
      child: new Material(
        color: Colors.transparent,
        child: Container(
          height: height,
          width: height,
          alignment: Alignment.center,
          decoration: BoxDecoration(
              color: Colors.redAccent,
              borderRadius: BorderRadius.all(Radius.circular(height / 2))),
          child: new Text(
            "长按\n移除",
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }
  @override
  void deactivate() {
    super.deactivate();
    overlayEntry?.remove();
  }
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 1)).then((value) => setState(() {_showFloating(false);}));

    scrollController = ScrollController();
    easyRefreshController = EasyRefreshController();

    // scrollController.addListener(() {
    //   ///如果滑动的偏移量超出了自己设定的值，tab栏就进行透明化操作
    //   double t = scrollController.offset / 180;
    //   if (t < 0.0) {
    //     t = 0.0;
    //   } else if (t > 1.0) {
    //     t = 1.0;
    //   }
    //   if (mounted) {
    //     setState(() {
    //       isScroll = t==1.0?true:false;
    //     });
    //   }
    //   ///如果滑动偏移量大于商品页高度，tab就切换到详情页
    //
    //   isScroll = scrollController.offset >= 0?true:false;
    //
    // });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final logic = Get.put(HomeLogic());
    // logic.up(context);//everytime
    return WillPopScope(
        onWillPop: () async {
          // Get.offNamed("/");
          return false;
        },
        child: Scaffold(
          resizeToAvoidBottomInset: false, //解决键盘导致溢出页面
          backgroundColor: Colors.transparent,
          appBar: buildAppBar(),
          body: SafeArea(
            child:
                // buildEasyRefresh(),
                buildNestedScrollView(),
            //     buildCustomScrollView(),
          ),
        ));
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}



class HomeToolSwiper extends StatefulWidget {
  const HomeToolSwiper({Key? key}) : super(key: key);

  @override
  HomeToolSwiperState createState() => HomeToolSwiperState();
}

class HomeToolSwiperState extends State<HomeToolSwiper> {
  late List<ToolGrid> lists = <ToolGrid>[];

  @override
  void initState() {
    super.initState();
    requestData();
  }

  @override
  void deactivate() {
    super.deactivate();
  }

  @override
  void dispose() {
    super.dispose();
  }

  requestData() async {
    lists = getToolGrid();

    if (mounted) {
      setState(() {});
    }
  }

  itemClick(ToolGrid model) {
    switch (model.index) {
      case 0:
        return Get.toNamed(
          '/index',
        );
      case 1:
        return Get.toNamed('/index');
      case 2:
        return Get.toNamed('/index');
      case 3:
        return Get.toNamed('/index');
      case 4:
        return Get.toNamed(
          '/index',
        );
      case 5:
        return Get.toNamed('/index');
      case 6:
        return Get.toNamed('/index');
      case 7:
        return Get.toNamed('/index');

      case 8:
        return Get.toNamed(
          '/index',
        );
      case 9:
        return Get.toNamed('/index');
      case 10:
        return Get.toNamed('/index');
      case 11:
        return Get.toNamed('/index');
      default:
    }
  }

  @override
  Widget build(BuildContext context) {
    int count = lists.length;
    int aver = 8;
    int oddaver = lists.length % aver > 0 ? 1 : 0;
    int pageCount = lists.length ~/ aver + oddaver;
    var spls = splitList(lists, aver);

    // int pageCount = 2;

    var size = MediaQuery.of(context).size;
    double itemHeight = 40.0;
    double itemWidth = size.width / count;
    return

        // SliverToBoxAdapter(
        //
        //   child:
        Container(
            //ConstrainedBox
            alignment: Alignment.center,
            // color: Colors.white,
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(
                Radius.circular(4),
              ),
            ),
            margin: EdgeInsets.only(left: 15, right: 15),
            padding: EdgeInsets.only(top: 15),
            child: Swiper(
              // autoplay:pageCount>1?true:false,
              outer: false,
              itemBuilder: (c, i) {
                var avaLists = spls[i];
                return Wrap(
                  crossAxisAlignment: WrapCrossAlignment.center,
                  alignment: WrapAlignment.start,
                  runAlignment: WrapAlignment.start,
                  runSpacing: 16.0,
                  children: avaLists.map((b) {
                    ToolGrid data = b;
                    return GestureDetector(
                      child: SizedBox(
                        width: (MediaQuery.of(context).size.width - 40) / 4,
                        child: Column(
                          // mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            imageCircular(
                                fit: BoxFit.fitWidth,
                                w: 30,
                                h: 30,
                                // MediaQuery.of(context).size.width * 0.12,
                                radius: 0,
                                image: data.img),
                            sizeBoxPadding(w: 0, h: 5),
                            syText(
                                height: 20,
                                text: data.title.tr, //"$i$b"
                                fontSize: 12,
                                // color: Colors.black,
                                fontWeight: FontWeight.normal),
                          ],
                        ),
                      ),
                      onTap: () {
                        itemClick(data);
                      },
                    );
                  }).toList(),
                );
              },
              pagination: SwiperPagination(
                  margin: EdgeInsets.all(pageCount > 1 ? 5.0 : 0.0)),
              itemCount: pageCount,
            ),
            constraints: BoxConstraints.loose(Size(
                MediaQuery.of(context).size.width - 30,
                pageCount > 1 ? 165 : 145)) //20
            )
        // ,)
        ;
  }
}

class HomeGridSwiper extends StatefulWidget {
  const HomeGridSwiper({Key? key}) : super(key: key);

  @override
  HomeGridSwiperState createState() => HomeGridSwiperState();
}

class HomeGridSwiperState extends State<HomeGridSwiper> {
  final logic = Get.put(HomeLogic());

  @override
  void initState() {
    super.initState();
    // requestData();
  }

  Widget cellForRow(var listModel, int type, int index) {
    var size = MediaQuery.of(Get.context!).size;
    double itemWidth =
        // (size.width-3*15)/2;
        (size.width - 6 * 15) / 3;
    // itemWidth = 170;

    return
        // InkWell(
        // onTap: () => itemClick(listModel),
        // child:
        Container(
            // height: 380,
            width: itemWidth,
            padding:
                const EdgeInsets.only(left: 0, right: 0, top: 0, bottom: 0),
            margin: const EdgeInsets.only(top: 0),
            child: GestureDetector(
                onTap: () {},
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
                            height: 45,
                            alignment: Alignment.topLeft,
                            child: RichText(
                              maxLines: 2,
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
                                text:
                                    '${listModel['prize'].toStringAsFixed(0)}',
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

  @override
  Widget build(BuildContext context) {
    return Obx(
      () =>
          //     SliverToBoxAdapter(
          // child:
          buildListViewBuilder(),
      // )
    );
  }

  buildListViewBuilder() {
    // int count = lists.length;
    int count = logic.gridsSwiper.length;
    int aver = 6;
    int oddaver = logic.gridsSwiper.length % aver > 0 ? 1 : 0;
    int pageCount = logic.gridsSwiper.length ~/ aver + oddaver;
    var spls = splitList(logic.gridsSwiper, aver);

    var size = MediaQuery.of(context).size;
    double itemHeight = 40.0;
    double itemWidth = size.width / count;
    return

        // SliverToBoxAdapter(
        //
        //   child:

        Obx(() => logic.gridsSwiper.isEmpty
            ? noDataWidget()
            : Container(
                //ConstrainedBox

                alignment: Alignment.center,
                // color: Colors.white,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(
                    Radius.circular(4),
                  ),
                ),
                margin: EdgeInsets.only(left: 15, right: 15),
                padding: EdgeInsets.only(top: 15, left: 15, right: 15),
                child: Swiper(
                  // loop:false,
                  // autoplayDelay:5,
                  // autoplay:false,
                  outer: false,
                  itemBuilder: (c, i) {
                    var avaLists = spls[i];
                    return Wrap(
                      crossAxisAlignment: WrapCrossAlignment.center,
                      alignment: WrapAlignment.start,
                      runAlignment: WrapAlignment.start,
                      runSpacing: 15.0,
                      spacing: 15,
                      children: avaLists.asMap().keys.toList().map((index) {
                        var listModel = avaLists[index];
                        return cellForRow(listModel, avaLists.length, index);
                      }).toList(),

                      // avaLists.map((b){
                      //   var listModel = b;
                      //   return
                      //     cellForRow(listModel, avaLists.length, 0);
                      //
                      // }).toList(),
                    );
                  },
                  pagination: SwiperPagination(
                      margin: EdgeInsets.all(pageCount > 1 ? 5.0 : 0.0) //
                      ),
                  itemCount: pageCount,
                ),
                constraints: BoxConstraints.loose(Size(
                    MediaQuery.of(context).size.width - 30,
                    pageCount > 1 ? 450 : 440)) //10
                ))

        // ,)
        ;
  }
}

class HomeHorScrollList1 extends StatefulWidget {
  const HomeHorScrollList1({Key? key}) : super(key: key);

  @override
  HomeHorScrollList1State createState() => HomeHorScrollList1State();
}

class HomeHorScrollList1State extends State<HomeHorScrollList1> {
  final logic = Get.put(HomeLogic());

  AutoScrollController? controller;

  final scrollDirection = Axis.horizontal;

  @override
  void initState() {
    super.initState();

    controller = AutoScrollController(
        viewportBoundaryGetter: () =>
            Rect.fromLTRB(0, 0, 0, MediaQuery.of(context).padding.bottom),
        axis: scrollDirection);

    scrollToPosition();
  }

  scrollToPosition() async {
    await controller!
        .scrollToIndex(0, preferPosition: AutoScrollPosition.begin);
    controller!.highlight(0);
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () =>
          //     SliverToBoxAdapter(
          // child:
          // logic.comHor.isEmpty?noDataWidget():
          buildListViewBuilder(),
      // )
    );
  }

  Widget cellForRow(var listModel, int type, int index) {
    bool isLast = (index == type - 1) ? true : false;
    var size = MediaQuery.of(Get.context!).size;
    double itemWidth = 210;
    // (size.width-3*15)/2;
    double itemHeight = 311;
    // itemWidth = 170;

    return
        // InkWell(
        // onTap: () => itemClick(listModel),
        // child:
        Container(
            height: itemHeight,
            width: itemWidth,
            decoration: BoxDecoration(
                color: Colors.white,
                border: Border(
                    right: BorderSide(
                        width: 0.5,
                        color: isLast ? Colors.transparent : Colors.black12))),

            // padding:  EdgeInsets.only(left: 15, right: (index == type-1)?15:0,top: (index == type-1)?0:0,bottom: (index == type-1)?0:0),
            margin: EdgeInsets.only(
                left: 0, right: isLast ? 15 : 0, bottom: 0, top: 0),
            child: GestureDetector(
                onTap: () {},
                child: Container(
                  margin: EdgeInsets.only(
                      left: 15, right: isLast ? 0 : 0, bottom: 15, top: 15),
                  // decoration:BoxDecoration(
                  //     color:Colors.white,
                  //     border:Border(
                  //         right: BorderSide(width:0.5,color:isLast?Colors.transparent:Colors.black12)
                  //     )),

                  // decoration: const BoxDecoration(
                  //   // color: Colors.white,
                  //   borderRadius: BorderRadius.all(
                  //     Radius.circular(4),
                  //   ),
                  //   // image: DecorationImage(
                  //   //   image: AssetImage("images/game1.png"),
                  //   //   fit: BoxFit.cover,
                  //   // ),
                  // ),

                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      // sizeBoxPadding(w: 0, h: 10),

                      ExtendedImage.network(
                        '${listModel['iconBig']}',
                        fit: BoxFit.fill,
                        // height: itemHeight,
                        height: itemWidth,
                        width: itemWidth,
                        shape: BoxShape.rectangle,
                        borderRadius: BorderRadius.all(Radius.circular(4.0)),
                      ),

                      sizeBoxPadding(w: 0, h: 10),
                      Container(
                        width: itemWidth,
                        padding: EdgeInsets.only(left: 0, right: 0),
                        height: 45,
                        alignment: Alignment.topLeft,
                        child: RichText(
                          maxLines: 2,
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
                        // height: 15,
                        alignment: Alignment.topLeft,
                        child: RichText(
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.left,
                          text: TextSpan(
                            text: '${listModel['prize'].toStringAsFixed(0)}',
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
                      sizeBoxPadding(w: 0, h: 10),
                    ],
                  ),
                )))
        // )
        ;
  }

  Widget _wrapScrollTag({required int index, required Widget child}) =>
      AutoScrollTag(
        key: ValueKey(index),
        controller: controller!,
        index: index,
        child: child,
        highlightColor: Colors.black.withOpacity(0.1),
      );

  Widget buildListViewBuilder() {
    int count = 0;
    count = (logic.horScrollList1.isEmpty) ? 0 : logic.horScrollList1.length;

    if (count == 0) {
      return noDataWidget();
    }

    return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
              height: 321,
              // padding: EdgeInsets.only(left: 15,right: 15),
              // width: double.infinity,
              alignment: Alignment.centerLeft,
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(0.0))
                  // BorderRadius.only(
                  //     bottomRight: Radius.circular(20.0),
                  //     bottomLeft: Radius.circular(20.0)),
                  ),
              // child: ClipRRect(
              //   borderRadius: const BorderRadius.all(Radius.circular(20)),
              child:

                  // Stack(
                  //   fit: StackFit.loose,
                  //   textDirection: TextDirection.ltr,
                  //   children: [
                  //
                  //   IgnorePointer(child:
                  //   Opacity(child: SizedBox(width: double.infinity,height: 311,),opacity: 0.0,) ,),
                  //   SizedBox(width:double.infinity ,),
                  //
                  //   Positioned.fill(child:

                  // ListView.custom(
                  //   physics: AlwaysScrollableScrollPhysics(
                  //     parent: BouncingScrollPhysics(),
                  //   ),
                  //   scrollDirection: scrollDirection,
                  //   controller: controller,
                  //   childrenDelegate: SliverChildBuilderDelegate(
                  //         (BuildContext, index) {
                  //           var listModel = logic.comHor[index];
                  //           return _wrapScrollTag(index: index,
                  //               child:cellForRow(listModel,count,index));
                  //           // return cellForRow(listModel,count,index);
                  //
                  //     },
                  //     childCount: logic.comHor.length
                  //     ,
                  //   ),
                  //
                  // )

                  ListView.builder(
                padding: EdgeInsets.only(top: 0),
                physics: AlwaysScrollableScrollPhysics(
                  parent: BouncingScrollPhysics(),
                ),
                shrinkWrap: true,
                // physics:const NeverScrollableScrollPhysics(),
                scrollDirection: scrollDirection,
                controller: controller,
                itemCount: logic.horScrollList1.length,
                itemBuilder: (context, index) {
                  var listModel = logic.horScrollList1[index];
                  return _wrapScrollTag(
                      index: index, child: cellForRow(listModel, count, index));
                },
              )

              //     ,left: 0,)
              // ],)

              )

          // )
        ]);

    // ),
  }
}

class HomeHorScrollList2 extends StatefulWidget {
  const HomeHorScrollList2({Key? key}) : super(key: key);

  @override
  HomeHorScrollList2State createState() => HomeHorScrollList2State();
}

class HomeHorScrollList2State extends State<HomeHorScrollList2> {
  final logic = Get.put(HomeLogic());

  AutoScrollController? controller;

  final scrollDirection = Axis.horizontal;

  @override
  void initState() {
    super.initState();

    // controller = AutoScrollController(
    //     viewportBoundaryGetter: () =>
    //         Rect.fromLTRB(0, 0, 0, MediaQuery.of(context).padding.bottom),
    //     axis: scrollDirection);
    //
    // scrollToPosition();
  }

  scrollToPosition() async {
    await controller!
        .scrollToIndex(0, preferPosition: AutoScrollPosition.begin);
    controller!.highlight(0);
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() =>
            //   SliverToBoxAdapter(
            // child:
            // logic.horScrollList2.isEmpty?noDataWidget():
            buildListViewBuilder()
        //   ,
        // )
        );
  }

  Widget cellForRow(var listModel, int type, int index) {
    bool isLast = (index == type - 1) ? true : false;
    var size = MediaQuery.of(Get.context!).size;
    double itemWidth = 120;
    // (size.width-3*15)/2;
    double itemHeight = 150;
    // itemWidth = 170;

    return Container(
        height: itemHeight,
        width: itemWidth,

        // padding:  EdgeInsets.only(left: 15, right: (index == type-1)?15:0,top: (index == type-1)?0:0,bottom: (index == type-1)?0:0),
        margin: EdgeInsets.only(
            left: index == 0 ? 15 : 0, right: 15, bottom: 0, top: 0),
        child: GestureDetector(
            onTap: () {},
            child: Container(
                // margin:  EdgeInsets.only(left: 0,right: 0,bottom: 0,top: 0),

                child: Stack(
              alignment: AlignmentDirectional.center,
              fit: StackFit.expand,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    ExtendedImage.network(
                      '${listModel['iconBig']}',
                      // RequestConfig.baseUrl+RequestConfig.imagePath+listModel['iconImg'],
                      fit: BoxFit.cover,
                      height: itemHeight,
                      width: itemWidth,
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.all(Radius.circular(4.0)),
                    ),
                  ],
                ),
                Positioned(
                  child: Container(
                    width: itemWidth,
                    padding: EdgeInsets.only(left: 0, right: 0),
                    height: 45,
                    alignment: Alignment.center,
                    child: RichText(
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        text: '${listModel['name']}',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                        ),
                        children: <TextSpan>[
                          TextSpan(
                            text: '\n' + '(' '${listModel['prize']}' ')',
                            style: TextStyle(fontSize: 12, color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ))));
  }

  Widget _wrapScrollTag({required int index, required Widget child}) =>
      AutoScrollTag(
        key: ValueKey(index),
        controller: controller!,
        index: index,
        child: child,
        highlightColor: Colors.black.withOpacity(0.1),
      );

  Widget buildListViewBuilder() {
    int count = 0;
    count = (logic.horScrollList2.isEmpty) ? 0 : logic.horScrollList2.length;

    if (count == 0) {
      return noDataWidget();
    }

    return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
              height: 150,
              child: ListView.builder(
                padding: EdgeInsets.only(top: 0),
                physics: AlwaysScrollableScrollPhysics(
                  parent: BouncingScrollPhysics(),
                ),
                // shrinkWrap: true,
                // physics:const NeverScrollableScrollPhysics(),
                scrollDirection: scrollDirection,
                controller: controller,
                itemCount: logic.horScrollList2.length,
                itemBuilder: (context, index) {
                  var listModel = logic.horScrollList2[index];
                  return
                      // _wrapScrollTag(index: index,
                      //   child:
                      cellForRow(listModel, count, index)
                      // )
                      ;
                },
              ))

          // )
        ]);

    // ),
  }
}

class HomeMultiGrids extends StatefulWidget {
  const HomeMultiGrids({Key? key}) : super(key: key);

  @override
  HomeMultiGridsState createState() => HomeMultiGridsState();
}

class HomeMultiGridsState extends State<HomeMultiGrids> {
  final logic = Get.put(HomeLogic());
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () =>
          //     SliverToBoxAdapter(
          // child:
          buildListViewBuilder(),
      // )
    );
  }

  Widget buildListViewBuilder() {
    int count = 0;
    count = (logic.multiGrids.isEmpty) ? 0 : logic.multiGrids.length;

    if (count == 0) {
      return noDataListWidget();
    }

    return Container(
      width: double.infinity,
      alignment: Alignment.topCenter,
      decoration: const BoxDecoration(
          // color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(0.0))
          // BorderRadius.only(
          //     bottomRight: Radius.circular(20.0),
          //     bottomLeft: Radius.circular(20.0)),
          ),
      // child: ClipRRect(
      //   borderRadius: const BorderRadius.all(Radius.circular(20)),
      child: Column(
        children: <Widget>[
          Row(
            // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            // mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Expanded(
                  flex: 1,
                  child: Container(
                      height: 180,
                      child: ListView(
                        physics: const NeverScrollableScrollPhysics(),
                        children: <Widget>[
                          Container(
                              height: 90,
                              child: ExtendedImage.network(
                                '${logic.multiGrids[0]['iconBig']}',
                                fit: BoxFit.cover,
                                // height: itemWidth,
                                // width: itemWidth,
                                shape: BoxShape.rectangle,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(4.0)),
                              )),
                          SizedBox(height: 10),
                          Container(
                              height: 90,
                              child: ExtendedImage.network(
                                '${logic.multiGrids[1]['iconBig']}',
                                fit: BoxFit.cover,
                                // height: itemWidth,
                                // width: itemWidth,
                                shape: BoxShape.rectangle,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(4.0)),
                              )),
                        ],
                      ))),
              SizedBox(width: 10),
              Expanded(
                  flex: 1,
                  child: Container(
                      height: 180,
                      child: ListView(
                        physics: const NeverScrollableScrollPhysics(),
                        children: <Widget>[
                          Container(
                              height: 60,
                              child: ExtendedImage.network(
                                '${logic.multiGrids[1]['iconBig']}',
                                fit: BoxFit.cover,
                                // height: itemWidth,
                                // width: itemWidth,
                                shape: BoxShape.rectangle,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(4.0)),
                              )),
                          SizedBox(height: 10),
                          Container(
                              height: 60,
                              child: ExtendedImage.network(
                                '${logic.multiGrids[2]['iconBig']}',
                                fit: BoxFit.cover,
                                // height: itemWidth,
                                // width: itemWidth,
                                shape: BoxShape.rectangle,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(4.0)),
                              )),
                          SizedBox(height: 10),
                          Container(
                              height: 60,
                              child: ExtendedImage.network(
                                '${logic.multiGrids[3]['iconBig']}',
                                fit: BoxFit.cover,
                                // height: itemWidth,
                                // width: itemWidth,
                                shape: BoxShape.rectangle,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(4.0)),
                              )),
                        ],
                      ))),
            ],
          ),
          SizedBox(height: 10),
          Row(
            children: <Widget>[
              Expanded(
                  flex: 2,
                  child: Container(
                    height: 180,
                    child: ExtendedImage.network(
                      '${logic.multiGrids[0]['iconBig']}',
                      fit: BoxFit.fill,
                      // height: itemWidth,
                      // width: itemWidth,
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.all(Radius.circular(4.0)),
                    ),
                  )),
              SizedBox(width: 10),
              Expanded(
                  flex: 1,
                  child: Container(
                      height: 180,
                      child: ListView(
                        physics: const NeverScrollableScrollPhysics(),
                        children: <Widget>[
                          Container(
                              height: 85,
                              child: ExtendedImage.network(
                                '${logic.multiGrids[1]['iconBig']}',
                                fit: BoxFit.cover,
                                // height: itemWidth,
                                // width: itemWidth,
                                shape: BoxShape.rectangle,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(4.0)),
                              )),
                          SizedBox(height: 10),
                          Container(
                              height: 85,
                              child: ExtendedImage.network(
                                '${logic.multiGrids[2]['iconBig']}',
                                fit: BoxFit.cover,
                                // height: itemWidth,
                                // width: itemWidth,
                                shape: BoxShape.rectangle,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(4.0)),
                              ))
                        ],
                      )))
            ],
          )
        ],
      ),
    );

    // ),
  }
}

class HomeGrid2InRow extends StatefulWidget {
  const HomeGrid2InRow({Key? key}) : super(key: key);

  @override
  HomeGrid2InRowState createState() => HomeGrid2InRowState();
}

class HomeGrid2InRowState extends State<HomeGrid2InRow> {
  final logic = Get.put(HomeLogic());
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () =>
          //     SliverToBoxAdapter(
          // child:
          buildListViewBuilder(),
      // )
    );
  }

  Widget cellForRow(var listModel, int type, int index) {
    var size = MediaQuery.of(Get.context!).size;
    double itemWidth = (size.width - 3 * 15) / 2;
    // itemWidth = 170;

    return
        // InkWell(
        // onTap: () => itemClick(listModel),
        // child:
        Container(
            // height: 180,
            width: itemWidth,
            padding:
                const EdgeInsets.only(left: 0, right: 0, top: 0, bottom: 0),
            margin: const EdgeInsets.only(top: 0),
            child: GestureDetector(
                onTap: () {},
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
                            height: 45,
                            alignment: Alignment.topLeft,
                            child: RichText(
                              maxLines: 2,
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
                                text:
                                    '${listModel['prize'].toStringAsFixed(0)}',
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

  List<Widget> getGridList() {
    var size = MediaQuery.of(Get.context!).size;
    double itemWidth = (size.width - 3 * 15) / 2;
    var tem = logic.listDataFirst.map((listModel) {
      return cellForRow(listModel, 0, 0);
      // return InkWell(
      //     onTap:(){print('点击了火爆商品');},
      //     child:
      //     Container(
      //       width: itemWidth,
      //       color:Colors.white,
      //       // padding: EdgeInsets.all(5.0),
      //       margin:EdgeInsets.only(bottom:10.0),
      //       child: Column(
      //         children: <Widget>[
      //           ExtendedImage.network(
      //             RequestConfig.baseUrl+RequestConfig.imagePath+listModel['iconImg'],
      //             fit: BoxFit.fill,
      //             height: itemWidth,
      //             width: itemWidth,
      //             shape: BoxShape.rectangle,
      //             borderRadius: BorderRadius.all(Radius.circular(4.0)),
      //           ),
      //           Text(
      //             listModel['name'],
      //             maxLines: 1,
      //             overflow:TextOverflow.ellipsis ,
      //             style: TextStyle(color:Colors.pink,fontSize: ScreenUtil().setSp(26)),
      //           ),
      //           Row(
      //             children: <Widget>[
      //               Text(
      //                 '\$''${listModel['prize']}',
      //                 style: TextStyle(color:Colors.black,),
      //
      //               ),
      //               Text(
      //                 '\$''${listModel['prize']}',
      //                 style: TextStyle(color:Colors.black26,decoration: TextDecoration.lineThrough),
      //
      //               )
      //             ],
      //           )
      //         ],
      //       ),
      //     )
      //
      // );
    });
    return tem.toList();
  }

  Widget buildListViewBuilder() {
    int count = 0;
    count = (logic.listDataFirst.isEmpty) ? 0 : logic.listDataFirst.length;

    if (count == 0) {
      return noDataListWidget();
    }

    return Container(
      width: double.infinity,
      alignment: Alignment.topCenter,
      decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(0.0))
          // BorderRadius.only(
          //     bottomRight: Radius.circular(20.0),
          //     bottomLeft: Radius.circular(20.0)),
          ),
      // child: ClipRRect(
      //   borderRadius: const BorderRadius.all(Radius.circular(20)),
      child: Column(
        children: <Widget>[
          Wrap(
            runSpacing: 15, //ver
            spacing: 15, //hor
            children: getGridList(),
          )
          // GridView.count(crossAxisCount: 2,childAspectRatio: .65,
          //   mainAxisSpacing: 15,
          //   crossAxisSpacing: 15,padding: EdgeInsets.only(left:15,right: 15,bottom: 15),children:getGridList(),)
        ],
      ),
    );

    // ),
  }
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
  @override
  void initState() {
    super.initState();
    // isSliver = widget.isSliver;
  }

  @override
  Widget build(BuildContext context) {
    final logic = Get.put(HomeLogic());
    return widget.isSliver
        ? Obx(() => SliverToBoxAdapter(child: buildBasicView()))
        : Obx(() => buildBasicView());
  }

  Widget buildBasicView() {
    final logic = Get.put(HomeLogic());
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
              // gradient: LinearGradient(colors: [
              //   Color(0xffffffff),
              //   Color(0xffffffff),
              //   Color(0xffffffff),
              //   Color(0xffffffff),
              // ]), // 渐变色
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
                    // Container(
                    //     decoration: BoxDecoration(
                    //     boxShadow: <BoxShadow>[
                    //       BoxShadow(
                    //           color: Colors.grey.withOpacity(0.2),
                    //           blurRadius: 1.0,
                    //           spreadRadius: 2,
                    //           offset: Offset(0.0, 6.0)
                    //       )
                    //     ],
                    //     // color: Colors.grey
                    // ),child:
                    logic.banners.isNotEmpty
                        ? ExtendedImage.network(
                            logic.banners[index],
                            fit: BoxFit.fill,
                            cache: false,
                            // border: Border.all(color: Colors.red, width: 1.0),
                            shape: BoxShape.rectangle,
                            borderRadius:
                                BorderRadius.all(Radius.circular(4.0)),

                            // height: 74,
                            // width: 74,
                          )
                        : Image.asset(
                            ('assets/images/home/banner0.png'), //$index
                            fit: BoxFit.fill,
                          )

                    // )
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

  @override
  void initState() {
    super.initState();
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
      'woaisdfdsfdsfdsfdsfdfds',
      'nimmererererererererwerew',
      'andyouxzvxczvcxbcxvcxbxcbcxbxcbcxbcxbcx'
    ];

    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    final logic = Get.put(HomeLogic());
    return widget.isSliver
        ? SliverToBoxAdapter(child: buildBasicView())
        : buildBasicView();
  }

  Widget buildBasicView() {
    final logic = Get.put(HomeLogic());
    return Container(
        // padding: EdgeInsets.only(top: 10),
        margin: const EdgeInsets.only(left: 15, right: 15, top: 10),
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
                () => Marquee(text: convertStrArrToString(logic.texts)),
              ),

              // MarqueeVertical(
              //   itemCount: texts.length,
              //   lineHeight: 20,
              //   marqueeLine: 1,
              //   direction: MarqueeVerticalDirection.moveDown,
              //   itemBuilder: (index) {
              //     return InkWell(
              //         child: Align(
              //             alignment: Alignment.centerLeft,
              //             child: Text(
              //               texts[index],
              //               overflow: TextOverflow.ellipsis,
              //             )),
              //         onTap: () {
              //           print(texts[index]);
              //         });
              //   },
              //   scrollDuration: const Duration(milliseconds: 300),
              //   stopDuration: const Duration(seconds: 3),
              // ),

              // HorScrollTxtWidget(
              //   count: texts.isEmpty ? 2 : texts.length,
              //   itemBuilder: (content, index) {
              //     return Container(
              //       alignment: Alignment.centerLeft,
              //       child: syText(
              //           fontSize: 12,
              //           text: texts.isEmpty
              //               ? "STEPEN (GMT) Trade has completed"
              //               : texts[index],//['title']
              //           color: Colors.black,
              //           textAlign: TextAlign.start),
              //     );
              //   },
              // ),
            ),
            SizedBox(
              width: 15,
            ),
          ],
        ));
  }
}

class HomeTool extends StatefulWidget {
  int type;
  String typeStr;
  bool isSliver;
  HomeTool({
    Key? key,
    this.type = 0,
    this.typeStr = '',
    this.isSliver = false,
  }) : super(key: key);

  @override
  HomeToolState createState() => HomeToolState();
}

class HomeToolState extends State<HomeTool> {
  late List<ToolGrid> lists = <ToolGrid>[];

  @override
  void initState() {
    super.initState();
    requestData();
  }

  @override
  void deactivate() {
    super.deactivate();
  }

  @override
  void dispose() {
    super.dispose();
  }

  requestData() async {
    lists = getToolGrid();

    if (mounted) {
      setState(() {});
    }
  }

  itemClick(ToolGrid model) {
    switch (model.index) {
      case 0:
        return Get.toNamed('/index',);
      case 1:
        return Get.toNamed('/index');
      case 2:
        return Get.toNamed('/index');
      case 3:
        return Get.toNamed('/index');
      case 4:
        return Get.toNamed('/index');
      case 5:
        return Get.toNamed('/index');
      case 6:
        return Get.toNamed('/index');
      case 7:
        return Get.toNamed('/index');

      default:
    }
  }

  @override
  Widget build(BuildContext context) {
    final logic = Get.put(HomeLogic());
    return widget.isSliver
        ? SliverToBoxAdapter(child: buildBasicView())
        : buildBasicView();
  }

  Widget buildBasicView() {
    final logic = Get.put(HomeLogic());

    int count = lists.length;
    var size = MediaQuery.of(context).size;
    double itemHeight = 40.0;
    double itemWidth = size.width / count;
    return

        // SliverGrid(
        //   delegate: SliverChildBuilderDelegate((_, index) {
        //     ToolGrid data = lists[index];
        //
        //     return GestureDetector(
        //       onTap: () => itemClick(data),
        //       child: Container(
        //         // height: 180,
        //         // padding: const EdgeInsets.only(
        //         //   left: 20,
        //         //   right: 20,
        //         // ),
        //         decoration: const BoxDecoration(
        //             // borderRadius: BorderRadius.all(Radius.circular(8.0)),
        //             // color: Colors.white,
        //             ),
        //         child:
        //             // Stack(
        //             //   alignment: Alignment.center,
        //             //   children: <Widget>[
        //             Column(
        //           crossAxisAlignment: CrossAxisAlignment.center,
        //           mainAxisAlignment: MainAxisAlignment.center,
        //           children: <Widget>[
        //             sizeBoxPadding(w: 0, h: 10),
        //             imageCircular(
        //                 fit: BoxFit.fitWidth,
        //                 w: 30,
        //                 h: 30,
        //                 radius: 0,
        //                 image: data.img),
        //             sizeBoxPadding(w: 0, h: 5),
        //             syText(
        //                 height: 20,
        //                 text: data.title.tr,//no model.tr
        //                 fontSize: 12,
        //                 // color: Colors.black,
        //                 fontWeight: FontWeight.normal),
        //             sizeBoxPadding(w: 0, h: 10),
        //           ],
        //         ),
        //         // ],
        //       ),
        //       // ),
        //     );
        //   }, childCount: count),
        //   gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        //       childAspectRatio: (itemWidth / itemHeight),
        //       crossAxisCount: 4,
        //       mainAxisSpacing: 0,
        //       crossAxisSpacing: 0))
        //   ;

        ClipRRect(
      borderRadius: const BorderRadius.all(Radius.circular(8)),
      child: Column(children: <Widget>[
        Container(
          // height: 180,
          margin: EdgeInsets.only(left: 15, right: 15),
          // color: Colors.white,
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(4.0)),
            color: Colors.white,
          ),
          child: GridView.builder(
            shrinkWrap: true,
            padding: EdgeInsets.only(top: 5), //用 Nest的时候
            // padding: EdgeInsets.symmetric(vertical: 6),
            physics: const NeverScrollableScrollPhysics(),
            //Grids
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4, //Grid按两列显示
              // crossAxisCount: count,
              childAspectRatio: (itemWidth / itemHeight),
              crossAxisSpacing: 0,
              mainAxisSpacing: 0,
            ),
            itemBuilder: (context, index) {
              ToolGrid data = lists[index];

              return GestureDetector(
                onTap: () => itemClick(data),
                child: Container(
                  // height: 180,
                  // padding: const EdgeInsets.only(
                  //   left: 20,
                  //   right: 20,
                  // ),
                  decoration: const BoxDecoration(
                      // borderRadius: BorderRadius.all(Radius.circular(8.0)),
                      // color: Colors.white,
                      ),
                  child:
                      // Stack(
                      //   alignment: Alignment.center,
                      //   children: <Widget>[
                      Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      sizeBoxPadding(w: 0, h: 10),
                      // imageCircular(
                      //     fit: BoxFit.fitWidth,
                      //     w: 30,
                      //     h: 30,
                      //     radius: 0,
                      //     image: data.img),
                      sizeBoxPadding(w: 0, h: 5),
                      syText(
                          height: 20,
                          text: data.title.tr,
                          fontSize: 12,
                          // color: Colors.black,
                          fontWeight: FontWeight.normal),
                      sizeBoxPadding(w: 0, h: 10),
                    ],
                  ),
                  // ],
                ),
                // ),
              );
            },
            itemCount: count,
          ),
        )
      ]),
    );
  }
}

class Chart extends StatefulWidget {
  const Chart({Key? key}) : super(key: key);

  @override
  ChartState createState() => ChartState();
}

class ChartState extends State<Chart> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() => SliverToBoxAdapter(child: buildListViewBuilder()
        // ,
        ));
  }

  Widget buildListViewBuilder() {
    final logic = Get.put(HomeLogic());
    int count = 0;
    count = (logic.finalChartString.isEmpty) ? 0 : 1;

    if (count == 0) {
      return noDataWidget();
    }

    return Container(
        width: 500,
        height: 500,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
          color: Colors.white,
        ),
        margin: EdgeInsets.all(15),
        padding: EdgeInsets.only(left: 8, right: 8, bottom: 15, top: 15),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.only(
                left: 5,
                right: 5,
              ),
              child: Row(
                children: [
                  Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: AppTheme.themeHightColor,
                        ),
                        width: 10,
                        height: 4,
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      syText(
                          fontSize: 12,
                          text: 'a'.tr,
                          textAlign: TextAlign.start),
                      SizedBox(
                        width: 14,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: Colors.green,
                        ),
                        width: 10,
                        height: 4,
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      syText(
                          fontSize: 12,
                          text: 'b'.tr,
                          textAlign: TextAlign.start),
                    ],
                  ),
                  Expanded(child: SizedBox()),
                  Container(
                    alignment: Alignment.topRight,
                    child: Wrap(
                      alignment: WrapAlignment.start,
                      spacing: 10,
                      runSpacing: 10,
                      children: List.generate(logic.choseTypes.length, (i) {
                        return
                            // Obx(() =>
                            Container(
                          margin: EdgeInsets.only(top: 0),
                          child: Container(
                              width: 50,
                              height: 26,
                              margin: EdgeInsets.only(right: 0),
                              child: GestureDetector(
                                onTap: () {
                                  logic.choseId.value = i;

                                  logic.choseChartTypeData();

                                  // logic.postChoseChart();
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: logic.choseId.value == i
                                        ? AppTheme.themeHightColor
                                        : Color(0xffEEEEEE),
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                  child: Stack(
                                    children: [
                                      Positioned(
                                          // red box
                                          right: -1,
                                          bottom: -1,
                                          child: Container()),
                                      Center(
                                          child: Text(
                                        '${logic.choseTypes[i]}'.tr,
                                        style: TextStyle(
                                            color: logic.choseId.value == i
                                                ? Colors.white
                                                : Color(0xff333333),
                                            fontSize: 12),
                                      )),
                                    ],
                                  ),
                                ),
                              )),
                        )
                            // )
                            ;
                      }),
                    ),
                  )
                ],
              ),
            ),

            // Obx(() =>
            HighCharts(
              loader: SizedBox(
                child: LinearProgressIndicator(),
                width: 100,
              ),
              size: Size(400, 400),
              data: logic.finalChartString.value,
              //           '''{
              //   // title: {
              //   //     text: 'Combination chart'
              //   // },
              //   xAxis: {
              //       categories: ['iii', 'Oranges', 'Pears', 'Bananas', 'Plums']
              //   },
              //   labels: {
              //       items: [{
              //           html: 'Total fruit consumption',
              //           style: {
              //               left: '50px',
              //               top: '18px',
              //               color: ( // theme
              //                   Highcharts.defaultOptions.title.style &&
              //                   Highcharts.defaultOptions.title.style.color
              //               ) || 'black'
              //           }
              //       }]
              //   },
              //   series: [
              //
              //   // {
              //   //     type: 'column',
              //   //     name: 'Jane',
              //   //     data: [3, 2, 1, 3, 3]
              //   // }, {
              //   //     type: 'column',
              //   //     name: 'John',
              //   //     data: [2, 4, 5, 7, 6]
              //   // }, {
              //   //     type: 'column',
              //   //     name: 'Joe',
              //   //     data: [4, 3, 3, 5, 0]
              //   // },
              //
              //   {
              //       type: 'spline',
              //       name: 'Average',
              //       data: [8, 8.67, 5, 16.33, 13.33],
              //       marker: {
              //           lineWidth: 2,
              //           lineColor: Highcharts.getOptions().colors[3],
              //           fillColor: 'white'
              //       }
              //   },
              //   {
              //       type: 'spline',
              //       name: 'Average',
              //       data: [3, 2.67, 3, 6.33, 3.33],
              //       marker: {
              //           lineWidth: 2,
              //           lineColor: Highcharts.getOptions().colors[3],
              //           fillColor: 'white'
              //       }
              //   },
              //
              //   // {
              //   //     type: 'pie',
              //   //     name: 'Total consumption',
              //   //     data: [{
              //   //         name: 'Jane',
              //   //         y: 13,
              //   //         color: Highcharts.getOptions().colors[0] // Jane's color
              //   //     }, {
              //   //         name: 'John',
              //   //         y: 23,
              //   //         color: Highcharts.getOptions().colors[1] // John's color
              //   //     }, {
              //   //         name: 'Joe',
              //   //         y: 19,
              //   //         color: Highcharts.getOptions().colors[2] // Joe's color
              //   //     }
              //   //     ],
              //   //     center: [100, 80],
              //   //     size: 100,
              //   //     showInLegend: false,
              //   //     dataLabels: {
              //   //         enabled: false
              //   //     }
              //   //   }
              //
              //
              //
              //     ]
              // }''',
              scripts: [
                "https://code.highcharts.com/highcharts.js",
                'https://code.highcharts.com/modules/networkgraph.js',
                'https://code.highcharts.com/modules/exporting.js',
              ],
            )
            // ),
          ],
        ));
    // ),
  }
}

class HomeRecList extends StatefulWidget {
  const HomeRecList({Key? key}) : super(key: key);

  @override
  HomeRecListState createState() => HomeRecListState();
}

class HomeRecListState extends State<HomeRecList> {
  late List lists = [];

  @override
  void initState() {
    super.initState();
    // requestData();
  }


  Widget cellForRow(var listModel) {
    var size = MediaQuery.of(Get.context!).size;
    double itemWidth = (size.width - 4 * 15) / 3;

    final logic = Get.put(HomeLogic());

    bool unLock = listModel['un_lock'];
    return
        // InkWell(
        // onTap: () => itemClick(listModel),
        // child:
        Container(
            // height: 182,
            width: double.infinity,
            padding: const EdgeInsets.only(left: 15, right: 15),
            margin: const EdgeInsets.only(bottom: 15),
            child: GestureDetector(
                onTap: () {
                },
                child: Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(
                      Radius.circular(4),
                    ),
                    // image: DecorationImage(
                    //   image: AssetImage(""),
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
                                      width: 140,
                                      height: 36,
                                      color: Colors.transparent,
                                    ),
                                    Expanded(child: SizedBox()),
                                    Container(
                                      width: 96,
                                      height: 36,
                                      child: OutlinedButton(
                                        style: ButtonStyle(
                                            backgroundColor:
                                                MaterialStateProperty.all(
                                                    Colors.transparent),
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
                                           'Join'.tr ,
                                          style: TextStyle(
                                              fontSize: 14,
                                              color: Colors.transparent),
                                        ),
                                        onPressed: () {
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

  @override
  Widget build(BuildContext context) {
    return Obx(() => SliverToBoxAdapter(
          child: buildListViewBuilder(),
        ));
  }

  Widget buildListViewBuilder() {
    final logic = Get.put(HomeLogic());

    int count = 0;
    count = (logic.lists.isEmpty) ? 0 : logic.lists.length;

    if (count == 0) {
      //   return noDataWidget(
      //       mainAxisAlignment: MainAxisAlignment.start, topPadding: 30);
      // } else {
      return noDataListWidget();
    }

    return Container(
      //WarmingS contain as Column tags
      // color: Colors.white,//BoxDecoration col
      width: double.infinity,
      // height: 50,
      alignment: Alignment.topCenter,
      // padding: const EdgeInsets.only(left: 10, right: 10),
      // padding: EdgeInsets.only(left: padding(), right: padding()),
      decoration: const BoxDecoration(
        // color: Colors.white,
        borderRadius: BorderRadius.only(
            bottomRight: Radius.circular(20.0),
            bottomLeft: Radius.circular(20.0)),
      ),
      // child: ClipRRect(
      //   borderRadius: const BorderRadius.all(Radius.circular(20)),
      child: Column(
        children: <Widget>[
          ListView.builder(
            //  padding: EdgeInsets.all(5),
            physics: const NeverScrollableScrollPhysics(),
            // itemExtent: 180,
            shrinkWrap: true,
            itemCount: logic.lists.length,
            itemBuilder: (BuildContext context, int index) {
              var data = logic.lists[index];
              return cellForRow(data);
            },
          ),
        ],
      ),
    );
    // ),
  }
}

class HorizontalDataList extends StatefulWidget {
  @override
  HorizontalDataListState createState() => HorizontalDataListState();
}

class HorizontalDataListState extends State<HorizontalDataList> {
  String champion = "ava";

  int currentSkinIndex = 2;
  int nextSkinIndex = 2;

  double currentSkinOpacity = 1.0;
  double nextSkinOpacity = 1.0;

  List skinNames = ["0", "1", "2", "3", "4", "5"];

  final logic = Get.put(HomeLogic());

  Widget buildHorizontalListView() {
    return

        //   ListView.separated(
        //   padding: EdgeInsets.all(16),
        //   scrollDirection: Axis.horizontal,
        //   separatorBuilder: (context, index) => Divider(
        //     color: Colors.black,
        //   ),
        //   itemCount: items.length,
        //   itemBuilder: (context, index) {
        //     return Container(
        //       width: 100,
        //       height: 50,
        //       child: ListTile(
        //         title: Text(items[index]),
        //       ),
        //     );
        //   },
        // )
        Container(
      padding: EdgeInsets.only(left: 30, right: 30),
      width: double.infinity,
      height: 250,
      child: ListView.custom(
        //controller: _scrollController,
        childrenDelegate: SliverChildBuilderDelegate(
          (BuildContext, index) {
            // var model =logic.listDataFirst[index];

            // return cellForRow(model,type,index);
            return Container(
              width: index == 0 ? 50 : 100,
              height: index == 0 ? 5 : 50,
              child: Container(
                alignment: Alignment.topCenter,
                // width: index==0?50: 100,
                // height:index==0?5: 50,
                color: Colors.red,
                child: Text(skinNames[index]),
              ),
            );
          },
          childCount: skinNames.length,
        ),
        shrinkWrap: true,
        // padding: EdgeInsets.all(5),
        scrollDirection: Axis.horizontal,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return

        // buildHorizontalListView()

        ///
        SliverToBoxAdapter(
      child: Container(
        child: Stack(
          children: [
            // //Current Image
            // Opacity(
            //   opacity: currentSkinOpacity,
            //   child: Image.asset(
            //     "images/home/avators/${champion.toLowerCase()}_$currentSkinIndex.jpg",
            //     fit: BoxFit.fitWidth,
            //     width: double.infinity,
            //   ),
            // ),
            //
            // //Next Image
            // Opacity(
            //   opacity: nextSkinOpacity,
            //   child: Image.asset(
            //     "images/home/avators/${champion.toLowerCase()}_$nextSkinIndex.jpg",
            //     fit: BoxFit.fitWidth,
            //     width: double.infinity,
            //   ),
            // ),
            //

            Align(
              alignment: Alignment.topCenter,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Obx(() => HorizontalCardPager(
                        initialPage: currentSkinIndex,

                        items: getSkinImageItems(
                            champion.toLowerCase(), logic.hdls.length),
                        onSelectedItem: (page) {
                          // print(nextSkinIndex);
                          // print(page);
                        },
                        // getSkinImageItems(champion.toLowerCase(), skinNames.length),
                        // onSelectedItem: (page) {
                        //   // p./..//brint(nextSkinIndex);
                        //   // print(page);
                        // },
                        onPageChanged: (page) {
                          setState(() {
                            if ((page - currentSkinIndex.toDouble()).abs() >=
                                1) {
                              currentSkinIndex = nextSkinIndex;
                              currentSkinOpacity = 1.0;
                              nextSkinOpacity = 0;
                            } else if (page > currentSkinIndex) {
                              nextSkinIndex = currentSkinIndex + 1;
                              nextSkinOpacity =
                                  page - currentSkinIndex.toDouble();
                              currentSkinOpacity = 1 - nextSkinOpacity;
                            } else if (page < currentSkinIndex) {
                              nextSkinIndex = currentSkinIndex - 1;
                              nextSkinOpacity =
                                  currentSkinIndex.toDouble() - page;
                              currentSkinOpacity = 1.0 - nextSkinOpacity;
                            }
                          });

                          // print(nextSkinIndex);
                        },
                      )),
                  // SizedBox(height: 10,),

                  Obx(() => Container(
                        width: double.infinity,
                        height: 155,
                        margin: EdgeInsets.only(
                            left: 15, right: 15, top: 10, bottom: 23),
                        // padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            // image: DecorationImage(
                            //   image: AssetImage("images/scrBgSelected.png"),
                            //   fit: BoxFit.cover,
                            // ),

                            //   boxShadow: [
                            //     BoxShadow(
                            //         color: Colors.black26,
                            //         offset: Offset(0, 4),
                            //         blurRadius: 6)
                            //   ],
                            color: Colors.white,
                            borderRadius: BorderRadius.all(Radius.circular(4))),
                        child: Stack(
                          children: [
                            Container(
                              padding: EdgeInsets.all(15),
                              alignment: Alignment.topLeft,
                              child: Opacity(
                                  opacity: currentSkinOpacity,
                                  child: Text(
                                    logic.hdls.length == 1
                                        ? '${logic.hdls[0]['id']}'
                                        : '${logic.hdls[currentSkinIndex]['id']}', //skinNames[currentSkinIndex]
                                    textAlign: TextAlign.left,
                                    // style: textTheme.headline1
                                    style: TextStyle(color: Colors.black),
                                  )),
                            ),
                            Container(
                              padding: EdgeInsets.all(15),
                              alignment: Alignment.topLeft,
                              child: Opacity(
                                  opacity: nextSkinOpacity,
                                  child: Text(
                                    logic.hdls.length == 1
                                        ? '${logic.hdls[0]['id']}'
                                        : '${logic.hdls[nextSkinIndex]['id']}', //skinNames[nextSkinIndex]
                                    // style: textTheme.headline1,
                                    style: TextStyle(color: Colors.black),
                                    textAlign: TextAlign.left,
                                  )),
                            ),
                          ],
                        ),
                      )),

                  SizedBox(
                    height: 5,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<CardItem> getSkinImageItems(String name, int length) {
    List<CardItem> items = [];

    // for (int i = 0; i < length; i++) {
    //   items.add(ImageCarditem(
    //     image: Image.asset(
    //
    //
    //       "images/${name.toLowerCase()}/$i.jpg",
    //       fit: BoxFit.cover,
    //     ),
    //   ));
    for (int i = 0; i < logic.hdls.length; i++) {
      var listModel = logic.hdls[i];
      int startI = 8;
      String name = 'nameeee${listModel['id']}';
      int substartI = 12;
      String subName = '${listModel['prize']}';
      //skinNames[i]+'ttttsfsdfsdfs',
      items.add(ImageTitleSubTitleCardItem(
          iconData: Icons.wifi,
          text: name.length > startI ? '${name.substring(0, startI)}...' : name,
          subTitle: subName.length > substartI
              ? '${subName.substring(0, substartI)}...'
              : subName,
          imageWidget: ExtendedImage.network(
            listModel['iconBig'],
            shape: BoxShape.circle,
            fit: BoxFit.cover,
            height: 55,
            width: 55,
          )
          // Image.asset(
          //   "images/home/avators/${name.toLowerCase()}_$i.jpg",
          //   width: 50,
          //   height: 50,
          //   fit: BoxFit.fill,
          // ),

          ));
    }

    return items;
  }
}

class FrozenedRowColumn extends StatefulWidget {
  // const FrozenedRowColumn({
  //   this.link = false,
  // });
  // final bool link;
  const FrozenedRowColumn({Key? key}) : super(key: key);

  @override
  FrozenedRowColumnState createState() => FrozenedRowColumnState();
}

class FrozenedRowColumnState extends State<FrozenedRowColumn> {
  FlexGridSource source = FlexGridSource();
  final logic = Get.put(HomeLogic());

  // List texts1 = [];

  @override
  void initState() {
    super.initState();
    // for(int i=0;i<logic.excels.length;i++){
    //   texts1.add(logic.excels[i]['validDay']);
    //   print('texts1');
    //   print(texts1);
    // }
  }

  @override
  List<Object> get columns => List<String>.generate(6, (int index) => '--'
      // 'Column:$index'
      );
  List<Object> get columns2 =>
      List<String>.generate(6, (int index) => 'Column2:$index');

  @override
  Widget build(BuildContext context) {
    // const int sourceLength  = 11;
    //source.length.toInt();
    final Color borderColor = Colors.grey.withOpacity(0.5);
    final MyCellStyle style = MyCellStyle(
      frozenedColumnsCount: 1,
      frozenedRowsCount: 10,
    );

    return SliverToBoxAdapter(
      child: Container(
        height: 60 * (style.frozenedRowsCount).toDouble(),
        decoration: BoxDecoration(
          border: Border.all(
            color: borderColor,
          ),
        ),
        margin: const EdgeInsets.all(15),
        child: FlexGrid<GridRow>(
          frozenedColumnsCount: style.frozenedColumnsCount,
          frozenedRowsCount: style.frozenedRowsCount, //add header
          cellStyle: style,
          headerStyle: style,

          // frozenedColumnsCount: 1,
          // frozenedRowsCount: 1,//11 last row no scroll
          verticalHighPerformance: true,
          horizontalHighPerformance: true,
          columnsCount: GridRow.cloumnNames.length,
          //horizontalPhysics: NeverScrollableScrollPhysics(),
          // link: widget.link,
          physics:
              // const ClampingScrollPhysics(),
              const NeverScrollableClampingScrollPhysics(),
          cellBuilder:
              (BuildContext context, GridRow data, int row, int column) {
            // var listModel = logic.excels.isNotEmpty?logic.excels[row]:columns[column];

            return Obx(() => Text(
                // column == 0 ? row == 0?'0':''+'$row' :

                // column ==1?columns[column].toString():
                // column ==2?columns2[column].toString():
                // data.columns[column].toString()

                logic.excels.isNotEmpty
                    ? column == 0
                        ? row == 0
                            ? '0'.tr
                            : '${logic.excels[row]['id']}'
                        : column == 1
                            ? '${logic.excels[row]['validDay']}'
                            : column == 2
                                ? '${logic.excels[row]['prize']}'
                                : column == 3
                                    ? row == 0
                                        ? '${(logic.excels[row]['rebateOdd'] * 100).toStringAsFixed(1)}%'
                                        : '+' +
                                            '${(logic.excels[row]['rebateOdd'] * 100).toStringAsFixed(1)}%'
                                    : column == 4
                                        ? '${((1 - logic.excels[row]['rebateOdd']) * 100).toStringAsFixed(1)}%'
                                        : '${(logic.excels[row]['rebateOdd'] * 100).toStringAsFixed(1)}%'
                    : columns[column].toString()));
          },
          headerBuilder: (BuildContext context, int index) {
            return
                // Container(height: 60,width: 100,
                //   alignment: Alignment.center,
                //   child: Text(GridRow.cloumnNames[index]),color: Colors.white,);

                Text(GridRow.cloumnNames[index]);
          },
          source: source,
        ),
      ),
    );
  }
}

class HomeEndlessList extends StatefulWidget {
  const HomeEndlessList({Key? key}) : super(key: key);

  @override
  HomeEndlessListState createState() => HomeEndlessListState();
}

class HomeEndlessListState extends State<HomeEndlessList>
    with TickerProviderStateMixin {
  late Timer timer;
  int currentIndex = 0;
  final InfiniteScrollController infiniteController = InfiniteScrollController(
    initialScrollOffset: 0.0,
  );
  late List<ToolGrid> lists = [];

  @override
  void initState() {
    super.initState();
    requestData();

    timer = Timer.periodic(const Duration(milliseconds: 300), (timer) {
      infiniteController.animateTo(infiniteController.offset + 33.0,
          duration: const Duration(milliseconds: 1000), curve: Curves.linear);
    });
  }

  requestData() async {
    // lists = await listRequest();
    lists = getHomeEndLessLists();
    if (mounted) {
      setState(() {});
    }
  }

  @override
  void deactivate() {
    super.deactivate();
    timer.cancel();
  }

  @override
  void dispose() {
    super.dispose();
    timer.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: EdgeInsets.only(left: 15, right: 15, bottom: 15),
        child: Column(
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(4),
                // borderRadius: BorderRadius.only(
                // bottomRight: Radius.circular(10),
                // bottomLeft: Radius.circular(10)),
              ),
              // padding: const EdgeInsets.only(left: 15, right: 15),
              padding: const EdgeInsets.all(15),
              height: 334,
              child: AbsorbPointer(
                child: InfiniteListView.separated(
                  padding: EdgeInsets.only(top: 1),
                  controller: infiniteController,
                  itemBuilder: (BuildContext context, int index) {
                    ToolGrid listModel = lists[currentIndex];
                    currentIndex++;
                    if (currentIndex >= lists.length) currentIndex = 0;
                    return SizedBox(
                        height: 45,
                        child: Row(
                          children: <Widget>[
                            // imageCircular(
                            //     w: 34, h: 34, radius: 17, image: ''),
                            SizedBox(
                              width: 10,
                            ),
                            syText(text: ''),
                            const Expanded(child: SizedBox()),

                            Container(
                                alignment: Alignment.centerRight,
                                // margin: const EdgeInsets.only(top: 23, right: 18),
                                // width: 170,
                                // height: 40,
                                child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    // crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        alignment: Alignment.centerRight,
                                        child: RichText(
                                          textAlign: TextAlign.right,
                                          text: TextSpan(
                                            text: '',
                                            style: TextStyle(
                                                height: 1.5,
                                                //  color: ColorPlate.btnColor,
                                                //   decoration: TextDecoration.underline
                                                fontSize: 12,
                                                color: Color(0xff2DBD85)),
                                            children: <TextSpan>[
                                              TextSpan(
                                                text: '\n' + '',
                                                style: TextStyle(
                                                    fontSize: 12,
                                                    color: Colors.black),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ])),
                            //data.money ??
                          ],
                        ));
                  },
                  separatorBuilder: (BuildContext context, int index) =>
                      const Divider(
                    height: 0.0,
                    color: Colors.white,
                  ),
                  anchor: 0.0,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
