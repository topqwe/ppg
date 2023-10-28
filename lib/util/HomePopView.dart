
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:liandan_flutter/style/theme.dart';

void showHomePopView(var datas) {
  if (datas == null) {
    return;
  }
  Get.dialog(
    HomePopView(datas: datas),
    barrierDismissible: false,
    useSafeArea: false,
  );
}

class HomePopView extends StatefulWidget {
  var datas;
  HomePopView({super.key, this.datas});

  @override
  State<HomePopView> createState() => _HomePopViewState();
}

class _HomePopViewState extends State<HomePopView> {

  @override
  void dispose() {


    super.dispose();
  }

  @override
  void initState() {
    super.initState();

  }


  @override
  Widget build(BuildContext context) {
    var verData =  widget.datas;
    bool isForceUpdate = false;

    return WillPopScope(
      onWillPop: () async => false,
      child: Material(
        type: MaterialType.transparency,
        child: Container(
          color: const Color(0xFF1E1E1E).withOpacity(0.3),
          width: Get.width,
          height: Get.height,
          alignment: Alignment.center,
          child: Stack(
            alignment: Alignment.topCenter,
            children: [
              Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(
                    Radius.circular(20),
                  ),
                ),
                padding: const EdgeInsets.only(
                  top: 25,
                  left: 30,
                  right: 30,
                  bottom: 30,
                ),
                margin: const EdgeInsets.only(
                  left: 38,
                  right: 38,
                  top: 64,
                  bottom: 100,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  // mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,//stretch
                  children: [
                     Text(
                      "${verData['title'] ?? ""}",
                      style: TextStyle(
                        fontSize: 25,
                        color: AppTheme.primary,
                      ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    // Row(
                    //   children: [
                    //      Container(
                    //         // padding: const EdgeInsets.symmetric(
                    //         //     horizontal: 19, vertical: 2),
                    //         child: Text(
                    //           "${verData['description'] ?? ""}",
                    //           style: const TextStyle(
                    //             fontSize: 16,
                    //             color: AppTheme.themeHightColor,
                    //           ),
                    //         ),
                    //       ),
                    //
                    //   ],
                    // ),
                    // const SizedBox(
                    //   height: 20,
                    // ),
                     Text(
                      "",
                      style: TextStyle(
                        fontSize: 14,
                        color: Color(0xFF26273C),
                      ),
                    ),
                    Row(children: [


                    Container(
                      constraints:
                          const BoxConstraints(maxHeight: 100, minHeight: 20),
                      child: SingleChildScrollView(
                        child: Text(
                          "${verData['content'] ?? ""}",
                          style: const TextStyle(

                            fontSize: 14,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                    ],),
                    const SizedBox(
                      height: 20,
                    ),

                     SizedBox(
                            height: 44,
                            child: Row(
                              mainAxisAlignment: isForceUpdate
                                  ? MainAxisAlignment.center
                                  : MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                if (!isForceUpdate)
                                  GestureDetector(
                                    onTap: () {
                                      Get.back();
                                    },
                                    child: Container(
                                        width: 100,
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 6),
                                        decoration: BoxDecoration(
                                          color: const Color(0xFFFAFBFB),
                                          border: Border.all(
                                            color: Colors.white,
                                            width: 1,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(25),
                                        ),
                                        // color: BibColor.grayBG,
                                        alignment: Alignment.center,
                                        child: const Text(
                                          "取消",
                                          style: TextStyle(
                                            fontSize: 15,
                                            fontWeight:
                                                FontWeight.normal,
                                            color: Colors.grey,
                                          ),
                                          textAlign: TextAlign.center,
                                        )),
                                  ),
                                GestureDetector(
                                  onTap: () {
                                    Get.back();
                                  },
                                  child: Container(
                                      width: isForceUpdate ? 200 : 100,
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 6),
                                      decoration: BoxDecoration(
                                        color: const Color(0xFF191C31),
                                        borderRadius: BorderRadius.circular(25),
                                      ),
                                      // color: BibColor.grayBG,
                                      alignment: Alignment.center,
                                      child: Text(
                                        isForceUpdate ? "确定" : "确定",
                                        style: const TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.normal,
                                          color: Colors.white,
                                        ),
                                        textAlign: TextAlign.center,
                                      )),
                                ),
                              ],
                            ),
                          ),

                  ],
                ),
              ),


            ],
          ),
        ),
      ),
    );
  }
}
