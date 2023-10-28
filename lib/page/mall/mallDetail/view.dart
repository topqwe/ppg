import 'dart:ui';
import 'package:container_tab_indicator/container_tab_indicator.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper_view/flutter_swiper_view.dart';
import 'package:get/get.dart';
import '../../../style/theme.dart';
import '../../../util/DefaultAppBar.dart';
import 'logic.dart';
import '/widgets/noData_Widget.dart';
import '/widgets/sizebox_widget.dart';
import '/widgets/button_widget.dart';
import '/widgets/text_widget.dart';
 class MallDetailPage extends StatefulWidget {
   int type;

   MallDetailPage({
     Key? key,
     this.type = 0,
   }) : super(key: key);

   @override
   createState() => MallDetailPageState();
 }

 class MallDetailPageState extends State<MallDetailPage>
     with SingleTickerProviderStateMixin, AutomaticKeepAliveClientMixin {
// class MallDetailPage extends StatelessWidget {
   double topTabBarHeight = 72;
   ///tab栏
   var tabs = <Tab>[];
   late TabController tabController;
   ///滑动监听
   ScrollController scrollController = new ScrollController();
   ///监听商品模块的位置信息
   GlobalKey goodsKey = GlobalKey();
   var goodHeight = 0.0;

   ///滑动多少距离显示顶部bar
   double DEFAULT_SCROLLER = 100;

   ///顶部bar的透明度，默认为透明，1为不透明
   double toolbarOpacity = 0.0;

   final logic = Get.put(MallDetailLogic());



   @override
   void initState() {
     super.initState();
     tabs = [
       Tab(text: "商品"),
       Tab(text: "详情"),
     ];
     tabController = new TabController(length: 2, vsync: this);
     scrollController.addListener(() {
       ///如果滑动的偏移量超出了自己设定的值，tab栏就进行透明化操作
       double t = scrollController.offset / DEFAULT_SCROLLER;
       if (t < 0.0) {
         t = 0.0;
       } else if (t > 1.0) {
         t = 1.0;
       }
       if (mounted) {
         setState(() {
           toolbarOpacity = t;
         });
       }
       ///如果滑动偏移量大于商品页高度，tab就切换到详情页
       if (scrollController.offset >= goodHeight) {
         tabController.animateTo(1);
       } else {
         tabController.animateTo(0);
       }
     });

     ///计算商品信息页高度和位置信息
     WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
       calculateHeight();
     });
   }

   @override
   void dispose() {
     super.dispose();
     scrollController.dispose();
     tabController.dispose();
   }

   ///计算商品信息页的高度
   void calculateHeight() {
     goodHeight = MediaQuery.of(context).size.height  - (GetPlatform.isIOS ? 88 : 50);
     // getSize(_goodsKey.currentContext) - (Platform.isIOS ? 88 : 50);
     print("calculateHeight $goodHeight");
   }

   Scaffold scaffoldWithNaviBar(){
     return Scaffold(
       resizeToAvoidBottomInset: false, //解决键盘导致溢出页面
       appBar: DefaultAppBar(
         titleStr: '详情'.tr,
       ),
       body: SafeArea(
           child: Stack(children: <Widget>[
             Column(children: <Widget>[
               Expanded(
                 flex: 1,
                 child:
                 // Container(
                 //   padding: const EdgeInsets.only(left: 0, right: 0),
                 //   child:
                 //   EasyRefreshCustom(type: 0,),
                 // ),
                 SingleChildScrollView(
                   // controller: _scrollController,
                   child: Column(
                     children: [
                       // Container(
                       //   padding: const EdgeInsets.only(left: 0, right: 0),
                       //   child:
                       //   EasyRefreshCustom(type: 0,),
                       // ),
                       Obx(
                             () => logic.listModel.isNotEmpty
                             ? cellForRow(logic.listModel, 0, 0)
                             : noDataWidget(
                             mainAxisAlignment: MainAxisAlignment.start,
                             topPadding: 30),
                       ),
                       Container(
                         child: logic.html,
                       ),
                     ],
                   ),
                 ),
               ),
               Column(children: [
                 Obx(() => Visibility(
                   child: Column(
                     children: [
                       customFootFuncBtn('Ex'.tr, () {
                         // logic.postCheckFund();
                         logic.showPzyDialog();
                         //logic.postUnlockOrPay();
                       }),
                       SizedBox(
                         height: 0,
                       ),
                     ],
                   ),
                   visible: (logic.listModel['status'] == 3),
                 )),

               ]),
             ]),
           ])),
     );
   }

   Scaffold scaffoldWithOutNaviBar(){
     return Scaffold(
       bottomNavigationBar: buildBottomBar(),
       body: Stack(
         children: [
           SingleChildScrollView(
             controller: scrollController,
             child: Column(
               children: [
                 Stack(
                   children: <Widget>[
                     Obx(
                           () => logic.listModel.isNotEmpty
                           ? cellForRow(logic.listModel, 0, 0)
                           : noDataWidget(
                           mainAxisAlignment: MainAxisAlignment.start,
                           topPadding: 30),
                     ),
                     GestureDetector(
                       onTap: () {
                         Get.back();
                       },
                       child: Container(
                         width: 100,
                         height: 100,
                         padding:
                         EdgeInsets.only(left: 12, right: 48, top: 40, bottom: 20),
                         child: Container(
                           padding: EdgeInsets.only(
                             left: 5,
                             right: 5,
                           ),
                           child: arrowBackBtn(() { },backgroundColor: Colors.white),

                           // Image.asset(
                           //   "assets/images/back_status.webp",
                           //   width: 30,
                           //   height: 30,
                           //   fit: BoxFit.fitWidth,
                           // ),
                           decoration: BoxDecoration(
                             color: AppTheme.themeHightColor,
                             shape: BoxShape.circle,
                           ),
                         ),
                       ),
                     ),
                   ],
                 ),

                 Container(
                   child: logic.html,
                 ),
               ],
             ),
           ),
           ///根据透明度显隐顶部的bar
           Opacity(
             opacity: toolbarOpacity,
             child: Container(
               height: topTabBarHeight,
               color: Colors.red,
               ///顶部显隐的bar
               child: buildTopBar(),
             ),
           )
         ],
       ),
     );
   }

  @override
  Widget build(BuildContext context) {
    // return scaffoldWithNaviBar();
    return scaffoldWithOutNaviBar();
  }

  Widget cellForRow(var listModel, int type, int index) {
    var size = MediaQuery.of(Get.context!).size;
    double itemWidth = (size.width - 4 * 15) / 3;

    var images = [];

    String imageString =
        '${listModel['iconImg']}';
    images.add(imageString);
    images.add(imageString);
    // int type = listModel['status'];

    return
        // Padding(
        //     padding: const EdgeInsets.only(left: 0, right: 0),
        //     child:
        Column(children: <Widget>[

          Stack(children: [

            Container(
                height: size.width,
                color: Colors.white,
                child: Swiper(
                  key: UniqueKey(),
                  itemBuilder: (BuildContext context, int index) {
                    return
                      ExtendedImage.network(
                        images[index],
                        fit: BoxFit.fill,
                        width: size.width,
                        height: size.width,
                        // height: 100,
                        // width: 100,
                      );



                    //   Image.network(
                    //   Uri.encodeFull(images[index]),
                    //   fit: BoxFit.fill,
                    // );
                  },
                  itemCount: images.length,
                  loop: images.length == 1 ? false : true,
                  autoplay: true,
                  pagination: SwiperPagination(
                    builder: SwiperPagination.dots,
                  ),
                )),

            // ExtendedImage.network(
            //   images.first,
            //   fit: BoxFit.fill,
            //   width: size.width,
            //   height: size.width,
            // ),

            Positioned(
              child: Container(
                width: 75,
                height: 22,
                child: OutlinedButton(
                  style: ButtonStyle(
                      backgroundColor:
                      MaterialStateProperty.all(type == 0
                          ? Color(0xff2DBD85)
                          : Color(0xffFF4141)),
                      shape: MaterialStateProperty.all(
                          RoundedRectangleBorder(
                              borderRadius:
                              BorderRadius.circular(4))),
                      side: MaterialStateProperty.all(
                          BorderSide(
                              color: Colors.transparent))),
                  child: Text(
                    'a',
                    style: TextStyle(
                        fontSize: 10,
                        color: Color(0xffffffff)),
                  ),
                  onPressed: () {
                  },
                ),
              ),
              bottom: 10,
              right: 10,
            ),
          ],),


      Container(
        // height: 300,
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
                    // divideLine(),
                    // sizeBoxPadding(w: 0, h: 10),

                    sizeBoxPadding(w: 0, h: 15),
                    Container(
                      // height: 40,
                      alignment: Alignment.topLeft,
                      child: RichText(
                        // maxLines: 2,
                        // overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.left,
                        text: TextSpan(
                          text: '${listModel['name']}',
                          style: TextStyle(color: Colors.black, fontSize: 16),
                          children: <TextSpan>[
                            TextSpan(
                              text: '',
                              style:
                                  TextStyle(fontSize: 12, color: Colors.grey),
                            ),
                          ],
                        ),
                      ),
                    ),

                    sizeBoxPadding(w: 0, h: 15),
                    Container(
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
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                          children: <TextSpan>[
                            TextSpan(
                              text: ' \$'.tr,
                              style:
                                  TextStyle(fontSize: 16, color: Colors.black),
                            ),
                          ],
                        ),
                      ),
                    ),

                    sizeBoxPadding(w: 0, h: 27),
                    Container(
                      // margin: const EdgeInsets.only(left: 8, right: 8),
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            ultimatelyLRTxt(
                                textl: '总数'.tr,
                                textr: ''),
                            sizeBoxPadding(w: 0, h: 20),
                            ultimatelyLRTxt(
                                textl: '数量'.tr,
                                textr: ''),
                            sizeBoxPadding(w: 0, h: 24),
                          ]),
                    ),
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
   ///顶部
   PreferredSize buildTopBar() {
     return PreferredSize(
       preferredSize: Size.fromHeight(topTabBarHeight),
       child: AppBar(
         backgroundColor: AppTheme.themeHightColor,
         // automaticallyImplyLeading: false,
         // centerTitle: false,
         // title:
         // Container(
         //   color: Colors.transparent,
         //   child: Row(
         //     children: [
         //       buttonImage(
         //           w: 170, h: 30, imageName: "", text: "", onPressed: () {}),
         //       Expanded(child: SizedBox()),
         //       buttonImage(
         //           w: 25, h: 25, imageName: "", text: "", onPressed: () {})
         //     ],
         //   ),
         // ),
         leading:

           IconButton(
           padding: EdgeInsets.symmetric(vertical:  10),
       icon: Icon(
         Icons.arrow_back,
         color: Color(0xffffffff),
         size: 25,
       ),
       onPressed: (){
         Get.back();
       },
     ),
     title:
     Container(height: topTabBarHeight,child: TabBar(
       isScrollable: true,
       controller: tabController,
       // indicatorColor: Colors.white,
       // indicatorSize: TabBarIndicatorSize.label,
       // indicatorPadding: EdgeInsets.all(10),
       //   indicatorWeight: 3.5,
       tabs: tabs,

       labelColor: Colors.white,
       unselectedLabelColor: Colors.grey,
       labelStyle: const TextStyle(
           fontSize: 14, fontWeight: FontWeight.normal),
       indicator: ContainerTabIndicator(
         widthFraction: 0.6,
         height: 2,
         width: 1,
         color: Colors.white,
         padding: const EdgeInsets.only(top: 20),
       ),
       onTap: (index) {
         if(tabController.indexIsChanging) {
           switch(index) {
             case 0:
               scrollController.jumpTo(0);
               tabController.animateTo(0);
               break;
             case 1:
               scrollController.jumpTo(goodHeight);
               tabController.animateTo(1);
               break;
           }
         }
       },
     ),),

     centerTitle: true,
       ),
     );
   }


   ///创建底部栏
   BottomAppBar buildBottomBar(){
     return BottomAppBar(
       color: Colors.white,
       child: Container(
         padding: EdgeInsets.only(left: 10, right: 10),
         height: 50,
         child: Row(
           mainAxisAlignment: MainAxisAlignment.spaceAround,
           crossAxisAlignment: CrossAxisAlignment.center,
           children: [
             SizedBox(width: 20,),
             Expanded(
                 flex: 3,
                 child: Text("联系客服")),
             Expanded(
               flex: 3,
               child: Container(
                 margin: EdgeInsets.all(8),
                 decoration: ShapeDecoration(
                   gradient: LinearGradient(colors: [
                     Color(int.parse("ffff9b00", radix: 16)),
                     Color(int.parse("ffF8CD6A", radix: 16)),
                   ]),
                   shape: RoundedRectangleBorder (
                     borderRadius: BorderRadius.all(
                       Radius.circular(20.0),
                     ),
                   ),
                 ),
                 child: Center(child: Text("加入购物车", style: TextStyle(color: Colors.white),)),
               ),
             ),
             Expanded(
               flex: 3,
               child:
               InkWell(onTap: (){
                 // logic.postCheckFund();
                 logic.showPzyDialog();
               },child:
               Container(
                 margin: EdgeInsets.all(8),
                 decoration: ShapeDecoration(
                   gradient: LinearGradient(colors: [
                     Color(int.parse("ffFF5252", radix: 16)),
                     Color(int.parse("ffFF0000", radix: 16)),
                   ]),
                   shape: RoundedRectangleBorder (
                     borderRadius: BorderRadius.all(
                       Radius.circular(20.0),
                     ),
                   ),
                 ),
                 child: Center(child: Text("直接", style: TextStyle(color: Colors.white),)),
               ),
               )
             ),
           ],
         ),
       ),
     );
   }
  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}