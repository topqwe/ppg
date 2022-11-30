
import 'dart:core';
import 'package:container_tab_indicator/container_tab_indicator.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:ftoast/ftoast.dart';
import 'package:get/get.dart';
import '../../style/theme.dart';

import '../../../api/request/config.dart';
import '../../api/request/apis.dart';
import '../../api/request/request.dart';
import '../../api/request/request_client.dart';
import '../../store/AppCacheManager.dart';
import 'logic.dart';
import '/widgets/noData_Widget.dart';
import '/widgets/sizebox_widget.dart';
import '/widgets/button_widget.dart';
import '/widgets/text_widget.dart';
import 'mallStateList/view.dart';

class SliverSectionHeaderDelegate extends SliverPersistentHeaderDelegate {
  SliverSectionHeaderDelegate(this.widget, this.height);
  final Widget widget;
  final double height;
  // minHeight 和 maxHeight 的值设置为相同时，header就不会收缩了
  @override
  double get minExtent => height;

  @override
  double get maxExtent => height;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return widget;
  }

  @override
  bool shouldRebuild(SliverSectionHeaderDelegate oldDelegate) {
    return true;
  }
}

class SliverTabBarDelegate extends SliverPersistentHeaderDelegate {
  final TabBar widget;
  final Color color;
  const SliverTabBarDelegate(this.widget, {required this.color})
      : assert(widget != null);
  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Align(
        alignment: Alignment.center, // default value
        child:
            //   AnimatedCrossFade(
            // crossFadeState: CrossFadeState.showFirst,

            Container(
          child: widget,
          color: color,
          // )
        ));
  }

  @override
  bool shouldRebuild(SliverTabBarDelegate oldDelegate) {
    return false; //// 如果内容需要更新，设置为true
  }

  @override
  double get maxExtent => widget.preferredSize.height; //200.0;
  @override
  double get minExtent => widget.preferredSize.height; //100.0
}

// class CategoryPage extends StatelessWidget {
class MallPage extends StatefulWidget {
  int type;
  MallPage({
    Key? key,
    this.type = 0,
  }) : super(key: key);

  @override
  createState() => _MallPageState();
}

class _MallPageState extends State<MallPage>
    with TickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  var tabNames = [
    {'id': 3, 'name': 'void'}
  ];

  late PageController pageController;
  late ScrollController scrollController;
  late TabController tabController;
  // =  TabController(initialIndex: 0, length: 10, vsync: this);
  var selectedIndex = 0;
  late final MallLogic logic;

  void postRequest() => request(() async {

        var data = await requestClient.post(APIS.home, data: {});

        for (int i = 0; i < data['l'].length; i++) {
          tabNames.add(data['l'][i]);
        }

        setState(() {
          tabController = TabController(
              initialIndex: selectedIndex,
              length: tabNames.length,
              vsync: this); //logic.tabNames.length
          tabController.addListener(() {
            if (tabController.index == tabController.animation!.value) {
              selectedIndex = tabController.index;
              // print(selectedIndex);
              // if(tabController.index ==1){
              //   getSecData();
              // }
            }
          });
        });
      }, showLoading: true);
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    logic = MallLogic();
    Get.put(logic, tag: widget.type.toString());

    scrollController = ScrollController(initialScrollOffset: 0);


    tabController = TabController(
        initialIndex: selectedIndex,
        length: tabNames.length,
        vsync: this); //logic.tabNames.length
    tabController.addListener(() {
      if (tabController.index == tabController.animation!.value) {
        selectedIndex = tabController.index;
        // print(selectedIndex);
        // if(tabController.index ==1){
        //   getSecData();
        // }
      }
    });
    // postRequest();
    pageController = PageController(initialPage: 0);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    Get.delete<MallLogic>(tag: widget.type.toString());
  }


  TabBar buildTab() {
    return TabBar(
      onTap: (index) {
        if (selectedIndex == index) {
        }
      },
      isScrollable: true,
      controller: tabController,
      labelColor: AppTheme.themeHightColor,
      unselectedLabelColor: Colors.grey,
      // indicatorWeight: 3,
      // indicatorSize: TabBarIndicatorSize.label,
      // isScrollable: false,
      labelStyle: const TextStyle(
          fontSize: 14, fontWeight: FontWeight.normal), //height: 1.0,
      tabs: tabNames
          .asMap()
          .keys
          .toList()
          .map((index) => Text('${tabNames[index]['name']}',
              style: TextStyle(fontSize: 14.0)))
          .toList(),

      // logic.tabNames.map((tab) => Text(tab, style: TextStyle(fontSize: 14.0))).toList(),
      indicator: ContainerTabIndicator(
        widthFraction: 0.6,
        height: 2,
        width: 1,
        color: AppTheme.themeHightColor,
        padding: const EdgeInsets.only(top: 23),
      ),
    );
  }

  buildTabSubViews() {
    List<Widget> tabViewList = [];
    tabNames.forEach((data) {
      tabViewList.add(MallStateListPage(
        type: int.parse(data!["id"].toString()),
      ));
    });
    return tabViewList;
  }

  PageView buildPageView() {
    return PageView.builder(
        controller: pageController,
        onPageChanged: (index) {
          pageController.animateToPage(index,
              duration: Duration(microseconds: 100), curve: Curves.bounceIn);
        },
        itemCount: tabNames.length,
        itemBuilder: (_, int index) => MallStateListPage(
            type: int.parse(tabNames[index]["id"].toString())));
  }

  TabBarView buildTabView(bool isCustomSli) {
    return isCustomSli
        ? TabBarView(
            physics: const NeverScrollableScrollPhysics(),
            controller: tabController,
            children: tabNames
                .asMap()
                .keys
                .toList()
                .map((index)

                    =>
                    Builder(builder: (context) {
                      ///=>return
                      return MallStateListPage(
                          type: int.parse(tabNames[index]["id"].toString()));

                    }))
                .toList())
        : TabBarView(
            physics: const NeverScrollableScrollPhysics(),
            //The provided ScrollController is currently attached to more than one ScrollPosition.
            controller: tabController,
            children: buildTabSubViews()

            ,
          );
  }

  NestedScrollView buildNestedScrollView() {
    return

        NestedScrollView(
      //1.head top
      controller: scrollController,
      key: const Key('category'),
      physics: const ClampingScrollPhysics(),
      headerSliverBuilder: (context, innerScrolled) {
        return [
          SliverToBoxAdapter(
            child: Container(
              margin: EdgeInsets.only(top: 10),
              child: buildHeadTabView(),
            ),
          ),

        ];
      },
      body: buildTabView(true)
      // buildPageView()
      ,
    )
        // ),
        ;
  }

  Column buildNoScrollHeaderList() {
    return Column(//2.injec head no scroll
        children: <Widget>[
      const SizedBox(
        height: 10,
      ),
      buildHeadTabView(), //context lead

      Expanded(
        flex: 1,
        child: Container(
          padding: const EdgeInsets.only(left: 0, right: 0),
          child:
              //不加这个，留Expand，TabbarView child只写一个widget，样式相同的话可以这样
              DefaultTabController(
            length: tabNames.length,
            child: Column(
              children: <Widget>[
                Container(
                  // color: AppColors.primaryBackground,
                  width: double.infinity,
                  child: Container(height: 45, child: buildTab()),
                ),
                Container(
                  height: 5,
                  // color: AppColors.primaryBackground,
                ),
                Expanded(
                  flex: 1,
                  child: buildTabView(true),
                ),
              ],
            ),
          ),
        ),
      ),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
        backgroundColor: Colors.white,
        resizeToAvoidBottomInset: false, //解决键盘导致溢出页面
         body: SafeArea(
            child: SizedBox(
          width: double.infinity,
          child: buildNestedScrollView(),
          // buildNoScrollHeaderList(),
        )));
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}

Widget headItemContainer(String txt0, String txt1) {
  return Container(
    alignment: Alignment.centerLeft,
    child: RichText(
      textAlign: TextAlign.left,
      text: TextSpan(
        text: txt0,
        style: TextStyle(fontSize: 20, color: Colors.white),
        children: <TextSpan>[
          TextSpan(
            text: '\n' + txt1,
            style: TextStyle(fontSize: 12, color: Colors.white),
          ),
        ],
      ),
    ),
  );
}

Widget buildHeadTabView() {
  var size = MediaQuery.of(Get.context!).size;
  double itemWidth = (size.width - 4 * 15) / 3;
  final logic = Get.put(MallLogic());
  return Obx(() => Container(
      alignment: Alignment.center,
      // width: size.width - 2*15,
      padding: const EdgeInsets.only(left: 15, right: 15),
      child: Column(children: <Widget>[
        Container(
          height: 86,
          alignment: Alignment.center, //search has ed
          // padding: const EdgeInsets.only(left: 15, right: 15),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(8.0)),
            color: Colors.white,
          ),
          child: Padding(
            padding: const EdgeInsets.only(
              left: 0,
              right: 0,
            ), //top: 10,bottom: 10
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.center,
              // crossAxisAlignment:CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                    // margin: const EdgeInsets.only(left: 8, right: 8,top: 8),
                    child: Row(mainAxisAlignment: MainAxisAlignment.center,
                        // crossAxisAlignment:CrossAxisAlignment.center,

                        children: [
                      Container(
                        padding: const EdgeInsets.only(left: 15, top: 15),
                        alignment: Alignment.centerLeft,
                        child: RichText(
                          textAlign: TextAlign.left,
                          text: TextSpan(
                            text: logic.headDatas['points'].toString(),
                            style: TextStyle(fontSize: 30, color: Colors.white),
                            children: [
                              WidgetSpan(
                                  child: GestureDetector(
                                      onTap: () {
                                        logic.toggle();
                                      },
                                      child: RotationTransition(
                                          turns: logic.turns,
                                          child: Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 3.0, vertical: 7),
                                            child: Icon(
                                              Icons.loop,
                                              color: Colors.white,
                                              size: 20,
                                            ),
                                          )))),
                              TextSpan(
                                text: '\n' + '当前'.tr,
                                style: TextStyle(
                                    height: 1.5,
                                    fontSize: 12,
                                    color: Colors.white),
                              ),
                            ],
                          ),
                        ),
                      ),
                      // sizeBoxPadding(w: 0, h: 0),

                      Expanded(
                        flex: 1,
                        child: Container(
                          alignment: Alignment.centerRight,
                          child: Column(
                            children: [],
                          ),
                        ),
                      ),

                      // Container(
                      //   padding: const EdgeInsets.only(left: 15, top: 22),
                      //   child: buttonImage(
                      //       w: 72,
                      //       h: 30,
                      //       imageName: 'assets/images/ruleBg.png',
                      //       textColor: AppTheme.themeHightColor,
                      //       text: '规则'.tr,
                      //       fontSize: 11,
                      //       onPressed: () {
                      //         Get.toNamed('/onlineService?type=2',
                      //             arguments: 'https://baidu.com');
                      //       }),
                      // ),


                      //
                      // buttonText(
                      //     textColor: Colors.transparent,
                      //     w: 80,
                      //     h: 35,
                      //     text: '',
                      //     onPressed: () {
                      //
                      //     },
                      //     radius: 13),
                    ])),
              ],
            ),
          ),
        )
      ])));
}
