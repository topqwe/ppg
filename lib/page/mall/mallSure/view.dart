import 'dart:async';
import 'dart:math';
import 'dart:core';
import 'package:container_tab_indicator/container_tab_indicator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';
import '../../../style/theme.dart';

import '../../../api/request/apis.dart';
import '../../../api/request/request.dart';
import '../../../api/request/request_client.dart';
import '../../../util/CustomBackButton.dart';
import '../../../util/DefaultAppBar.dart';
import '../../../widgets/helpTools.dart';
import 'logic.dart';
import 'mallSureStateList/view.dart';

// class CategoryPage extends StatelessWidget {
class MallSurePage extends StatefulWidget {
  int type;
  MallSurePage({
    Key? key,
    this.type = 0,
  }) : super(key: key);

  @override
  createState() => _MallSurePageState();
}

class _MallSurePageState extends State<MallSurePage>
    with TickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  var tabNames = [
    {'id': 0, 'name': '实物'.tr},
    {'id': 1, 'name': '豆'.tr}
  ];

  late ScrollController scrollController;
  late TabController tabController;
  // =  TabController(initialIndex: 0, length: 10, vsync: this);
  var selectedIndex = 0;
  late PageController pageController;
  late final MallSureLogic logic;

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
    logic = MallSureLogic();
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
    // postRequest();
    pageController = PageController(initialPage: 0);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    Get.delete<MallSureLogic>(tag: widget.type.toString());
  }

  TabBar buildTab() {
    return TabBar(
      onTap: (index) {
        if (selectedIndex == index) {
          // TaskStateListLogic stateListLogic = Get.find<TaskStateListLogic>();
          // stateListLogic.type = index;
          // // logic.dataRefresh();
          // stateListPage.dataRefresh();

          // return
          //   // TaskStateListPage();
          //   stateListPage;

          // if(selectedIndex == 0){///Special handle
          //
          // }else{
          //
          // }
        }
      },
      isScrollable: false,
      controller: tabController,
      labelColor: AppTheme.themeHightColor,
      unselectedLabelColor: Colors.grey,
      // indicatorWeight: 3,
      // indicatorSize: TabBarIndicatorSize.label,
      // isScrollable: false,
      labelStyle: const TextStyle(
          fontSize: 13, fontWeight: FontWeight.normal), //height: 1.0,
      tabs: tabNames
          .asMap()
          .keys
          .toList()
          .map((index) => Text('${tabNames[index]['name']}',
              style: TextStyle(fontSize: 13.0)))
          .toList(),

      // logic.tabNames.map((tab) => Text(tab, style: TextStyle(fontSize: 14.0))).toList(),
      indicator: ContainerTabIndicator(
        widthFraction: 0.6,
        height: 2,
        width: 1,
        color: AppTheme.themeHightColor,
        padding: const EdgeInsets.only(top: 20),
      ),
    );
  }

  buildTabSubViews() {
    List<Widget> tabViewList = [];
    tabNames.forEach((data) {
      tabViewList.add(MallSureStateListPage(
        type: int.parse(data['id'].toString()),
      ));
    });
    return tabViewList;
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
                      return MallSureStateListPage(
                        type: int.parse(
                          tabNames[index]['id'].toString(),
                        ),
                      );
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
      controller: scrollController,
      key: const Key('category'),
      physics: const ClampingScrollPhysics(),
      headerSliverBuilder: (context, innerScrolled) {
        return [
          SliverToBoxAdapter(
            child: Container(
              height: 1,

            ),
          ),

          // SliverOverlapAbsorber(
          //   // 传入 handle 值，直接通过 `sliverOverlapAbsorberHandleFor` 获取即可
          //   handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
          //   sliver:
          //   buildAppBar(),
          // ),

          // SliverPersistentHeader(
          //   pinned: true,
          //   delegate: SliverSectionHeaderDelegate(
          //     DecoratedBox(
          //       decoration: BoxDecoration(
          //         color: Colors.white,
          //         // image:  DecorationImage(
          //         //   image: ImageUtils.getAssetImage('order/order_bg1'),
          //         //   fit: BoxFit.fill,
          //         // ),
          //       ),
          //       child: Padding(
          //         padding: EdgeInsets.only(left: 30, right: 30),
          //         // padding: const EdgeInsets.symmetric(horizontal: 0.0),
          //         child:
          //             // Obx(() =>
          //             Container(
          //           height: 38.0,
          //           // padding: const EdgeInsets.only(top: 0.0),
          //           child: buildTab(),
          //           // )
          //         ),
          //       ),
          //     ),
          //     38.0,
          //   ),
          // ),

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
    return WillPopScope(
      child: KeyboardDismisser(
        gestures: [
          GestureType.onTap,
          GestureType.onPanUpdateDownDirection,
        ],
        child: Scaffold(
            resizeToAvoidBottomInset: false, //解决键盘导致溢出页面
            appBar: DefaultAppBar(
                titleStr: 'Ex'.tr,
                leading: CustomBackButton(
                  onPressed: () {
                    Get.offNamed('/mallDetail',
                        arguments: Get.arguments,
                        parameters: {'url': Get.parameters['url'].toString()});
                  },
                )),
            body: SafeArea(
                child: SizedBox(
              width: double.infinity,
              child: buildNestedScrollView(),
            ))),
      ),
      onWillPop: () async {
        return false;
      },
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
