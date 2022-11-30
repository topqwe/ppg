
import 'dart:core';
import 'package:container_tab_indicator/container_tab_indicator.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:ftoast/ftoast.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../style/theme.dart';
import '../../../api/request/config.dart';
import '../../api/request/apis.dart';
import '../../api/request/request.dart';
import '../../api/request/request_client.dart';
import '../../store/AppCacheManager.dart';
import '../../util/DefaultAppBar.dart';
import '../../widgets/helpTools.dart';
import 'catStateList/view.dart';
import 'logic.dart';
import '/widgets/noData_Widget.dart';
import '/widgets/sizebox_widget.dart';
import '/widgets/button_widget.dart';
import '/widgets/text_widget.dart';


// class CategoryPage extends StatelessWidget {
class CategoryPage extends StatefulWidget {
  int type;
  CategoryPage({
    Key? key,
    this.type = 0,
  }) : super(key: key);

  @override
  createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage>
    with TickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  var tabNames = [];
  //[{'id':0,'name':'void'}]

  late PageController pageController;

  late ScrollController scrollController;
  late TabController tabController;

  var selectedIndex = 0;
  late final CategoryLogic logic;

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

            }
          });
        });
      });

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    logic = CategoryLogic();
    Get.put(logic, tag: widget.type.toString());

    scrollController = ScrollController(initialScrollOffset: 0);
    scrollController.addListener(() {
      double offset = scrollController.position.pixels;
      if (offset > 250) {
        // setState(() {
        //   appBarTitleOpacity = 1;
        // });
      } else {
        // setState(() {
        //   appBarTitleOpacity = 0;
        // });
      }
    });

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

    postRequest();

    pageController = PageController(initialPage: 0);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    Get.delete<CategoryLogic>(tag: widget.type.toString());
  }

  Widget buildHeadTabView() {
    var size = MediaQuery.of(Get.context!).size;
    double itemWidth = (size.width - 4 * 15) / 3;
    final logic = Get.put(CategoryLogic());
    return Obx(() => Container(
        alignment: Alignment.center,
        // width: size.width - 2*15,
        padding: const EdgeInsets.only(left: 15, right: 15,bottom: 15),
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
                                  text: logic.headDatas['a'].toString(),
                                  style: TextStyle(fontSize: 30, color: Colors.white),
                                  children: [
                                    WidgetSpan(
                                        child: GestureDetector(
                                            onTap: () {
                                            },

                                                child: Padding(
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal: 3.0, vertical: 7),
                                                  child: Icon(
                                                    Icons.stacked_line_chart,
                                                    color: Colors.white,
                                                    size: 20,
                                                  ),
                                                ))),

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




                          ])),
                ],
              ),
            ),
          )
        ])));
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
      tabViewList.add(CatStateListPage(
        type: data["id"],
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
        itemBuilder: (_, int index) =>
            CatStateListPage(type: tabNames[index]["id"]));
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
                    // 这边需要通过 Builder 来创建 TabBarView 的内容，否则会报错
                    // NestedScrollView.sliverOverlapAbsorberHandleFor must be called with a context that contains a NestedScrollView.
                    //     .map((tab)
                    =>
                    Builder(builder: (context) {
                      ///=>return
                      return CatStateListPage(type: tabNames[index]["id"]);

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
              margin:EdgeInsets.only(top: 10),
              child: buildHeadTabView(),
            ),
          ),

          // SliverOverlapAbsorber(
          //   // 传入 handle 值，直接通过 `sliverOverlapAbsorberHandleFor` 获取即可
          //   handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
          //   sliver:
          //   buildAppBar(),
          // ),

          SliverPersistentHeader(
            pinned: true,
            delegate: SliverSectionHeaderDelegate(
              DecoratedBox(
                decoration: BoxDecoration(
                  color: Colors.white,
                  // image:  DecorationImage(
                  //   image: ImageUtils.getAssetImage('order/order_bg1'),
                  //   fit: BoxFit.fill,
                  // ),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 0.0),
                  child:
                      // Obx(() =>
                      Container(
                    height: 50.0,
                    // padding: const EdgeInsets.only(top: 0.0),
                    child: buildTab(),
                    // )
                  ),
                ),
              ),
              50.0,
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

  @override
  Widget build(BuildContext context) {

    super.build(context);
    return Scaffold(
        resizeToAvoidBottomInset: false, //解决键盘导致溢出页面
        // appBar: DefaultAppBar(
        //   titleStr: ''.tr,
        //   leading: SizedBox.shrink(),
        // ),
        body: SafeArea(
            child: SizedBox(
          width: double.infinity,
          child: buildNestedScrollView(),
        )));
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
