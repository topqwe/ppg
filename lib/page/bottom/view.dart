
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'logic.dart';

class BottomPage extends StatelessWidget {
  final logic = Get.put(BottomLogic());
  var freTimer;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Obx(() => IndexedStack(
              index: logic.currentIndex.value,
              children: logic.pages.value,
            )),
        // floatingActionButton:Container(
        //     width: 60,
        //     height: 60,
        // margin: EdgeInsets.only(top: ScreenUtil().setHeight(10)),
        // child: FloatingActionButton(
        //   onPressed: () {
        //     if (timer_fun != null) {
        //       return;
        //     }
        //     timer_fun = Timer(
        //       Duration(milliseconds: 1500),
        //           () {
        //         timer_fun = null;
        //       },
        //     );
        //     // logic.changePage(1);
        //   },
        //   backgroundColor: Colors.white,
        //   elevation: 0,
        //   tooltip: 'Refresh'.tr,
        //   child: RotationTransition(turns: logic.turns,
        //   child: Obx(() =>Container(child: Image.asset(
        //       !logic.playing.value?'assets/images/bottom/normal.png':'assets/images/bottom/toggling.png',width: 45,
        //       height: 50)))),
        // )),
        bottomNavigationBar: Obx(() => BottomNavigationBar(
          currentIndex: logic.currentIndex.value,
          iconSize: 25.0,
          type: BottomNavigationBarType.fixed,
          onTap: (index) {
            logic.changePage(index);
          },
          items:[
            BottomNavigationBarItem(
              icon:  Image.asset('assets/images/bottom/b01.png',width: ScreenUtil().setWidth(20),height: ScreenUtil().setHeight(20)),
              activeIcon: Image.asset('assets/images/bottom/b02.png',width: ScreenUtil().setWidth(20),height: ScreenUtil().setHeight(20)),
              label: 'Home'.tr,
            ),
            BottomNavigationBarItem(
              icon:  Image.asset('assets/images/bottom/b11.png',width: ScreenUtil().setWidth(20),height: ScreenUtil().setHeight(20)),
              activeIcon: Image.asset('assets/images/bottom/b12.png',width: ScreenUtil().setWidth(20),height: ScreenUtil().setHeight(20)),
              label: 'Vacation'.tr,
            ),
            BottomNavigationBarItem(
              icon:  Image.asset('assets/images/bottom/b21.png',width: ScreenUtil().setWidth(20),height: ScreenUtil().setHeight(20)),
              activeIcon: Image.asset('assets/images/bottom/b22.png',width: ScreenUtil().setWidth(20),height: ScreenUtil().setHeight(20)),
              label: 'Commodity'.tr,
            ),
            BottomNavigationBarItem(
              icon:  Image.asset('assets/images/bottom/b31.png',width: ScreenUtil().setWidth(20),height: ScreenUtil().setHeight(20)),
              activeIcon: Image.asset('assets/images/bottom/b32.png',width: ScreenUtil().setWidth(20),height: ScreenUtil().setHeight(20)),
              label: 'Category'.tr,
            ),
            BottomNavigationBarItem(
              icon:  Image.asset('assets/images/bottom/b41.png',width: ScreenUtil().setWidth(20),height: ScreenUtil().setHeight(20)),
              activeIcon: Image.asset('assets/images/bottom/b42.png',width: ScreenUtil().setWidth(20),height: ScreenUtil().setHeight(20)),
              label: 'Me'.tr,
            ),
          ],
        )),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked
    );
  }
}
