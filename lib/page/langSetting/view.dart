import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../util/CustomBackButton.dart';
import '../../util/DefaultAppBar.dart';
import '../bottom/logic.dart';
import 'logic.dart';
import '/widgets/sizebox_widget.dart';
import '/widgets/button_widget.dart';
import '/widgets/text_widget.dart';

class LangSettingPage extends StatelessWidget {
  final logic = Get.put(LangSettingLogic());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        // resizeToAvoidBottomInset: false, //解决键盘导致溢出页面
        appBar: DefaultAppBar(
          titleStr: '语言设置'.tr,
          leading: CustomBackButton(
            onPressed: () {
              if ('${Get.parameters['path']}' == '1') {
                Get.offNamed('/index');
                final logic = Get.put(BottomLogic());
                logic.changePage(4);
              } else {
                Get.offAllNamed("/login");
              }
            },
          ),
        ),
        body: SafeArea(
          child: CustomScrollView(
            controller: logic.scrollController,
            physics: BouncingScrollPhysics(),
            scrollDirection: Axis.vertical,
            slivers: <Widget>[
              const HomeList(),
              sliverSectionHead(''),
            ],
          ),
        ));
  }
}

class HomeList extends StatefulWidget {
  const HomeList({Key? key}) : super(key: key);

  @override
  HomeListState createState() => HomeListState();
}

class HomeListState extends State<HomeList> {
  late List<HomeListItem> lists = <HomeListItem>[];

  @override
  void initState() {
    super.initState();
    // requestData();
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
    lists = getHomeLists();

    if (mounted) {
      setState(() {});
    }
  }

  Widget cellForRow(HomeListItem listModel, int index) {
    final logic = Get.put(LangSettingLogic());
    return
        // InkWell(
        // hoverColor: Colors.transparent,
        // //GestureDetector
        // onTap: () {
        //   itemClick(listModel);
        // },
        // child:

        Container(
            height: 60,
            width: double.infinity,
            padding: const EdgeInsets.only(left: 15, right: 15),
            // margin: const EdgeInsets.only(top: 15),
            // child:
            // GestureDetector(
            //     onTap: () {
            //       // Navigator.of(context).pushReplacementNamed("/topup");
            //     },
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.transparent,
                borderRadius: BorderRadius.all(
                  Radius.circular(0),
                ),
                // image: DecorationImage(
                //   image: AssetImage("images/game1.png"),
                //   fit: BoxFit.cover,
                // ),
              ),
              child: Container(
                margin: const EdgeInsets.only(left: 0, right: 0),
                child: rowImgTxtImg(
                    textl: listModel.title,
                    textr: "",
                    onPressed: () {
                      // print('objectIndex');
                      // print('${index}');
                      logic.settingPostRequest(index);
                      if ('${Get.parameters['path']}' == '1') {
                        Get.offNamed('/index');
                        final logic = Get.put(BottomLogic());
                        logic.changePage(4);
                      } else {
                        Get.offAllNamed("/login");
                      }
                      // Get.offAllNamed('/index');
                      // Get.back();
                    },
                    urlL: listModel.describe,
                    urlR: listModel.img,
                    check: listModel.isChecked),
              ),
            )
            // )
            )
        //     ,
        // )
        ;
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() => SliverToBoxAdapter(
          child: _buildListViewBuilder(),
        ));
  }

  Widget _buildListViewBuilder() {
    final logic = Get.put(LangSettingLogic());
    // int count = 0;
    // count = (lists.isEmpty) ? 0 : lists.length;
    //
    // if (count == 0) {
    //   //   return noDataWidget(
    //   //       mainAxisAlignment: MainAxisAlignment.start, topPadding: 30);
    //   // } else {
    //   return noDataListWidget();
    // }

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
            itemExtent: 60,
            shrinkWrap: true,
            itemCount: logic.lists.length,
            itemBuilder: (BuildContext context, int index) {
              HomeListItem data = logic.lists[index];
              return cellForRow(data, index);
            },
          ),
          sizeBoxPadding(w: 0, h: 20),
        ],
      ),
    );
    // ),
  }
}
