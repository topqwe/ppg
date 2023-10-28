import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:liandan_flutter/style/theme.dart';
import 'package:r_upgrade/r_upgrade.dart';
import 'package:url_launcher/url_launcher_string.dart';

import 'ClipperView.dart';

void showAppUpdatePopup(var datas) {
  if (datas == null) {
    return;
  }
  Get.dialog(
    UpdatePage(datas: datas),
    barrierDismissible: false,
    useSafeArea: false,
  );
}

class UpdatePage extends StatefulWidget {
  var datas;
  UpdatePage({super.key, this.datas});

  @override
  State<UpdatePage> createState() => _UpdatePageState();
}

class _UpdatePageState extends State<UpdatePage> {
  bool isDownloading = false;
  double progress = 0;
  int? apkId;
  @override
  void dispose() {
    if (Platform.isAndroid) {
      RUpgrade.cancel(apkId ?? 0);
    }

    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    if (Platform.isAndroid) {
      RUpgrade.stream.listen((DownloadInfo info) {
        progress = (info.percent ?? 0) / 100;
        if (info.status == DownloadStatus.STATUS_SUCCESSFUL) {
          isDownloading = false;
        }
        setState(() {});
      });
    }
  }

  void downloadApp() async {
    if (Platform.isAndroid) {
      String url = widget.datas['latest']['apk_url'] ?? "";
      // UrlLaincher.openUrl(url);
      launchUrlString(url, mode: LaunchMode.externalApplication);
      // await RUpgrade.upgradeFromUrl(url);
      // await RUpgrade.upgradeFromUrl(widget.msg?.downloadUrl ?? "");
      return;
    }
    isDownloading = true;
    setState(() {});
    int? id = await RUpgrade.upgrade(
      widget.datas['latest']['apk_url'] ?? "",
      fileName: "app-release.apk",
      useDownloadManager: true,
    );
    apkId = id;
    if (id != null) {
      await RUpgrade.install(id);
    }


  }

  @override
  Widget build(BuildContext context) {
    var verData =  widget.datas['version'];
    bool isForceUpdate = verData['force'] == false;
        // true;
    return WillPopScope(
      onWillPop: () async => true,//!isForceUpdate
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
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const Text(
                      "发现新版本",
                      style: TextStyle(
                        fontSize: 25,
                        color: AppTheme.primary,
                      ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Row(
                      children: [
                        ClipPath(
                          clipper: ClipperView(),
                          child:
                         Container(
                           color: AppTheme.themeHightColor,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 19, vertical: 2),
                            child: Text(
                              "v${verData['release'] ?? ""}",
                              style: const TextStyle(
                                fontSize: 16,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                    // const SizedBox(
                    //   height: 20,
                    // ),
                    // const Text(
                    //   "【版本更新】",
                    //   style: TextStyle(
                    //     fontSize: 14,
                    //     color: Color(0xFF26273C),
                    //   ),
                    // ),
                    Container(
                      constraints:
                          const BoxConstraints(maxHeight: 100, minHeight: 20),
                      child: SingleChildScrollView(
                        child: Text(
                          "${verData['content'] ?? "bbc"}",
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    isDownloading
                        ? Padding(
                            padding: const EdgeInsets.only(
                                top: 18.0, left: 10, right: 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Text(
                                  "下载进度：${(progress * 100).toStringAsFixed(0)}%",
                                  style: const TextStyle(
                                    fontSize: 12,
                                    color: Colors.black,
                                  ),
                                ),
                                const SizedBox(
                                  height: 8,
                                ),
                                LinearProgressIndicator(
                                  value: progress,
                                  color: AppTheme.themeHightColor,
                                ),
                              ],
                            ),
                          )
                        : SizedBox(
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
                                    downloadApp();
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
                                        isForceUpdate ? "强制更新" : "立即更新",
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
