
import 'dart:core';
import 'package:container_tab_indicator/container_tab_indicator.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:ftoast/ftoast.dart';
import 'package:get/get.dart';
import 'package:liandan_flutter/util/SearchBar.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../services/api/api_basic.dart';
import '../../services/responseHandle/request.dart';
import '../../style/theme.dart';
import '../../store/AppCacheManager.dart';
import '../../util/DefaultAppBar.dart';
import '../../util/SearchTextComponent.dart';
import '../../widgets/helpTools.dart';
import 'logic.dart';
import '/widgets/noData_Widget.dart';
import '/widgets/sizebox_widget.dart';
import '/widgets/button_widget.dart';
import '/widgets/text_widget.dart';


// class CategoryPage extends StatelessWidget {
class VerticalCategoryPage extends StatefulWidget {
  int type;
  VerticalCategoryPage({
    Key? key,
    this.type = 0,
  }) : super(key: key);

  @override
  createState() => _VerticalCategoryPageState();
}

class _VerticalCategoryPageState extends State<VerticalCategoryPage>
    with TickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  // var tabNames = [];
  //[{'id':0,'name':'void'}]

  List categoryList = [];
  // [{'id':0,'name':'void'}]
  List rightCateList = [];

  var selectedIndex = 0;


  late ScrollController scrollController;


  late final VerticalCategoryLogic logic;

  //右侧数据：
  _getRightCateData(pid) {
    setState(() {
      if (categoryList[pid]["children"] != null) {
        rightCateList = categoryList[pid]["children"];
      } else {
        rightCateList = [];
      }
    });
  }

  void postRequest() => request(() async {

    // product env

    var data = await ApiBasic().dummy({});
    // dummy env
    // type '_Map<dynamic, dynamic>' is not a subtype of type 'Map<String, dynamic>?'
    //http://192.168.225.156:9090/home
    // var data = await HttpUtils().get(RequestConfig.baseUrl+APIS.home,<String, dynamic>{});
    categoryList.clear();
    rightCateList.clear();
    // for (int i = 0; i < data['l'].length; i++) {
    //       categoryList.add(data['l'][i]);
    //     }
    categoryList.addAll(data['l']);

        setState(() {
          _getRightCateData(0);
        });
      });



  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    logic = VerticalCategoryLogic();
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

    categoryList = [];
    rightCateList = [];
    selectedIndex = 0;

    categoryList.addAll(ApiBasic().initCus());

    setState(() {
      _getRightCateData(0);
    });

    postRequest();

  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    Get.delete<VerticalCategoryLogic>(tag: widget.type.toString());
  }

  Widget buildCustomView(){
    return Column(
      children: [
        // 搜索框
        SearchTextComponent(),
        // 分类主体
        Expanded(
          child: Container(
            child: Row(
              children: [
                // 左侧一级分类
                Expanded(
                  flex: 1,
                  child: Container(
                    child: ListView.builder(
                        itemCount: categoryList.length,
                        itemBuilder: (BuildContext context, int index) {
                          return InkWell(
                            onTap: () {
                              setState(() {
                                selectedIndex = index;
                                _getRightCateData(selectedIndex);
                              });
                            },
                            child: Container(
                              width: double.infinity,
                              height: 56,
                              child: Text(
                                categoryList[index]["name"].toString(),
                              ),
                              alignment: Alignment.center,
                              color: selectedIndex == index
                                  ? Colors.white
                                  : Color.fromRGBO(250, 249, 249, 0.9),
                            ),
                          );
                        }),
                  ),
                ),
                // 右侧二级分类
                Expanded(
                    flex: 3,
                    child: Container(
                        padding: EdgeInsets.all(10),
                        height: double.infinity,
                        color: Colors.white,
                        child: Column(
                          children: [
                            Expanded(
                              child: Row(
                                children: [
                                  Container(
                                    width: 32,
                                    height: 1,
                                    margin: EdgeInsets.fromLTRB(45, 0, 0, 0),
                                    color: Color(0xFFE6DFE0),
                                  ),
                                  Container(
                                      margin:
                                      EdgeInsets.fromLTRB(45, 0, 0, 0),
                                      child: Text("分类",
                                          style: TextStyle(fontSize: 14))),
                                  Container(
                                    width: 32,
                                    height: 1,
                                    margin: EdgeInsets.fromLTRB(45, 0, 0, 0),
                                    color: Color(0xFFE6DFE0),
                                  ),
                                ],
                              ),
                              flex: 1,
                            ),
                            Expanded(
                              child: GridView.builder(
                                  gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 3,
                                      childAspectRatio: 0.6,
                                      crossAxisSpacing: 10,
                                      mainAxisSpacing: 10),
                                  itemCount: rightCateList.length,
                                  itemBuilder: (context, index) {
                                    return InkWell(
                                      onTap: () {
                                        if (rightCateList[index]["id"] !=
                                            null) {
                                          Get.toNamed('/mallDetail',
                                              parameters:
                                              {
                                                'url':
                                                """
  <img alt='Flutter' src='https://flutter.cn/assets/flutter-lockup-1caf6476beed76adec3c477586da54de6b552b2f42108ec5bc68dc63bae2df75.png' /><br />
  <img alt='Google' src='https://www.google.com/images/branding/googlelogo/2x/googlelogo_color_92x30dp.png' /><br />
  <img alt='Flutter' src='https://flutter.cn/assets/flutter-lockup-1caf6476beed76adec3c477586da54de6b552b2f42108ec5bc68dc63bae2df75.png' /><br />
  <img alt='Google' src='https://www.google.com/images/branding/googlelogo/2x/googlelogo_color_92x30dp.png' /><br />
  <img alt='Flutter' src='https://flutter.cn/assets/flutter-lockup-1caf6476beed76adec3c477586da54de6b552b2f42108ec5bc68dc63bae2df75.png' /><br />
  <img alt='Google' src='https://www.google.com/images/branding/googlelogo/2x/googlelogo_color_92x30dp.png' /><br />
  <img alt='Flutter' src='https://flutter.cn/assets/flutter-lockup-1caf6476beed76adec3c477586da54de6b552b2f42108ec5bc68dc63bae2df75.png' /><br />
  <img alt='Google' src='https://www.google.com/images/branding/googlelogo/2x/googlelogo_color_92x30dp.png' /><br />
  <img alt='Flutter' src='https://flutter.cn/assets/flutter-lockup-1caf6476beed76adec3c477586da54de6b552b2f42108ec5bc68dc63bae2df75.png' /><br />
  <img alt='Google' src='https://www.google.com/images/branding/googlelogo/2x/googlelogo_color_92x30dp.png' /><br />
  <img alt='Flutter' src='https://flutter.cn/assets/flutter-lockup-1caf6476beed76adec3c477586da54de6b552b2f42108ec5bc68dc63bae2df75.png' /><br />
  <img alt='Google' src='https://www.google.com/images/branding/googlelogo/2x/googlelogo_color_92x30dp.png' /><br />
  <img alt='Flutter' src='https://flutter.cn/assets/flutter-lockup-1caf6476beed76adec3c477586da54de6b552b2f42108ec5bc68dc63bae2df75.png' /><br />
  <img alt='Google' src='https://www.google.com/images/branding/googlelogo/2x/googlelogo_color_92x30dp.png' /><br />
  <img alt='Flutter' src='https://flutter.cn/assets/flutter-lockup-1caf6476beed76adec3c477586da54de6b552b2f42108ec5bc68dc63bae2df75.png' /><br />
  <img alt='Google' src='https://www.google.com/images/branding/googlelogo/2x/googlelogo_color_92x30dp.png' /><br />
  <img alt='Flutter' src='https://flutter.cn/assets/flutter-lockup-1caf6476beed76adec3c477586da54de6b552b2f42108ec5bc68dc63bae2df75.png' /><br />
  <img alt='Google' src='https://www.google.com/images/branding/googlelogo/2x/googlelogo_color_92x30dp.png' /><br />
  <img alt='Flutter' src='https://flutter.cn/assets/flutter-lockup-1caf6476beed76adec3c477586da54de6b552b2f42108ec5bc68dc63bae2df75.png' /><br />
  <img alt='Google' src='https://www.google.com/images/branding/googlelogo/2x/googlelogo_color_92x30dp.png' /><br />
  <img alt='Flutter' src='https://flutter.cn/assets/flutter-lockup-1caf6476beed76adec3c477586da54de6b552b2f42108ec5bc68dc63bae2df75.png' /><br />
  <img alt='Google' src='https://www.google.com/images/branding/googlelogo/2x/googlelogo_color_92x30dp.png' /><br />
  <img alt='Flutter' src='https://flutter.cn/assets/flutter-lockup-1caf6476beed76adec3c477586da54de6b552b2f42108ec5bc68dc63bae2df75.png' /><br />
  <img alt='Google' src='https://www.google.com/images/branding/googlelogo/2x/googlelogo_color_92x30dp.png' /><br />
  <img alt='Flutter' src='https://flutter.cn/assets/flutter-lockup-1caf6476beed76adec3c477586da54de6b552b2f42108ec5bc68dc63bae2df75.png' /><br />
  <img alt='Google' src='https://www.google.com/images/branding/googlelogo/2x/googlelogo_color_92x30dp.png' /><br />
  <img alt='Flutter' src='https://flutter.cn/assets/flutter-lockup-1caf6476beed76adec3c477586da54de6b552b2f42108ec5bc68dc63bae2df75.png' /><br />
  <img alt='Google' src='https://www.google.com/images/branding/googlelogo/2x/googlelogo_color_92x30dp.png' /><br />
  <img alt='Flutter' src='https://flutter.cn/assets/flutter-lockup-1caf6476beed76adec3c477586da54de6b552b2f42108ec5bc68dc63bae2df75.png' /><br />
  <img alt='Google' src='https://www.google.com/images/branding/googlelogo/2x/googlelogo_color_92x30dp.png' /><br />
  <img alt='Flutter' src='https://flutter.cn/assets/flutter-lockup-1caf6476beed76adec3c477586da54de6b552b2f42108ec5bc68dc63bae2df75.png' /><br />
  <img alt='Google' src='https://www.google.com/images/branding/googlelogo/2x/googlelogo_color_92x30dp.png' /><br />
  <img alt='Flutter' src='https://flutter.cn/assets/flutter-lockup-1caf6476beed76adec3c477586da54de6b552b2f42108ec5bc68dc63bae2df75.png' /><br />
  <img alt='Google' src='https://www.google.com/images/branding/googlelogo/2x/googlelogo_color_92x30dp.png' /><br />
  <img alt='Flutter' src='https://flutter.cn/assets/flutter-lockup-1caf6476beed76adec3c477586da54de6b552b2f42108ec5bc68dc63bae2df75.png' /><br />
  <img alt='Google' src='https://www.google.com/images/branding/googlelogo/2x/googlelogo_color_92x30dp.png' /><br />
  <img alt='Flutter' src='https://flutter.cn/assets/flutter-lockup-1caf6476beed76adec3c477586da54de6b552b2f42108ec5bc68dc63bae2df75.png' /><br />
  <img alt='Google' src='https://www.google.com/images/branding/googlelogo/2x/googlelogo_color_92x30dp.png' /><br />
  <img alt='Flutter' src='https://flutter.cn/assets/flutter-lockup-1caf6476beed76adec3c477586da54de6b552b2f42108ec5bc68dc63bae2df75.png' /><br />
  <img alt='Google' src='https://www.google.com/images/branding/googlelogo/2x/googlelogo_color_92x30dp.png' /><br />
  
  """,
                                                'id':'${rightCateList[index]['id']}',
                                              }, );

                                        }
                                      },
                                      child: Column(
                                        children: [
                                          AspectRatio(
                                            aspectRatio: 1,
                                            child:
                                            ExtendedImage.network(
                                              "${rightCateList[index]["iconBig"]}",
                                              fit: BoxFit.fill,
                                              height: 120,
                                              width: 120,
                                              shape: BoxShape.rectangle,
                                              borderRadius:
                                              BorderRadius.all(Radius.circular(4.0)),
                                            ),

                                          ),
                                          Container(
                                            height: 40,
                                            child: Text(
                                                "${rightCateList[index]["name"]}"),
                                          )
                                        ],
                                      ),
                                    );
                                  }),
                              flex: 10,
                            )
                          ],
                        )))
              ],
            ),
          ),
          flex: 14,
        )
      ],
    );
  }




  NestedScrollView buildNestedScrollView() {
    return

        NestedScrollView(
      //1.head top
      controller: scrollController,
      key: const Key('verticalcategory'),
      physics: const ClampingScrollPhysics(),
      headerSliverBuilder: (context, innerScrolled) {
        return [
          // SliverToBoxAdapter(
          //   child: Container(
          //     margin:EdgeInsets.only(top: 10),
          //     child: buildHeadTabView(),
          //   ),
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
                    child: SearchTextComponent(),
                    // SearchingBar(),
                    // )
                  ),
                ),
              ),
              50.0,
            ),
          ),

        ];
      },
      body: buildCustomView()
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
