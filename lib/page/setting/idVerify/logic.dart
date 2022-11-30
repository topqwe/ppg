import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:ftoast/ftoast.dart';
import 'package:get/get.dart';

import 'package:image_gallery_saver/image_gallery_saver.dart';
import '../../../util/LoadingBarrierView.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:ui' as ui;
import '../../../api/file/HttpUtils.dart';

import '../../../api/request/apis.dart';
import '../../../api/request/config.dart';
import '../../../api/request/request.dart';
import '../../../api/request/request_client.dart';
import '../../../util/Country/countries.dart';
import '../../../util/ImageUtils.dart';

class IdVerifyLogic extends GetxController {
  var boolId = 0.obs;
  var boolCanEdit = 0.obs;
  var boolBank = 0.obs;
  var m_countryiso = "US".obs;
  var cTxt0 = ''.obs;
  var cTxt = 0.0.obs;
  var depositFee = 0.0.obs;
  late TextEditingController controller0;
  late TextEditingController controller;
  GlobalKey repaintKey = GlobalKey();
  var image0 = ''.obs;
  var image1 = ''.obs;
  var image2 = ''.obs;
  var session_token = ''.obs;
  var rechargeBlockchain_url_data = [].obs;
  var rechargeBlockchain_url_show = {}.obs;
  var argu = Get.parameters['type'];

  void postCheckInfosStatus() => request(() async {
        var user = await requestClient.post(APIS.home, data: {});

        if ('${user['nationality']}' != 'null' &&
            '${user['nationality']}' != '') {
          m_countryiso.value =
              '${user['nationality']}'.toString().toUpperCase();
        } else {
          m_countryiso.value = 'US';
        }
        if ('${user['name']}' != 'null' && '${user['name']}' != '') {
          controller0.text = '${user['name']}';
        }
        if ('${user['idnumber']}' != 'null' && '${user['idnumber']}' != '') {
          controller.text = '${user['idnumber']}';
        }
        if ('${user['idimg_1']}' != 'null' && '${user['idimg_1']}' != '') {
          String urlPath = '';
          // RequestConfig.baseUrl+RequestConfig.imagePath;

          image0.value = '$urlPath${user['idimg_1']}';
          image1.value = '$urlPath${user['idimg_2']}';
          image2.value = '$urlPath${user['idimg_3']}';
        }

        boolId.value = user['status'];
        boolCanEdit.value =
            // 1;
            (boolId.value == 0 || boolId.value == 3) ? 1 : 0;
        if (boolId.value == 0) {
        } else {}
        boolBank.value = user['safeword'];
        if (boolBank.value == 0) {
        } else {}
        update();
        // else{
        //   Get.toNamed("/funReset");
        // }
      });
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    controller0 = TextEditingController();
    controller0.addListener(() {
      // cTxt.value = controller.text;
      cTxt0.value = controller0.text;
      update();
    });

    controller = TextEditingController();
    controller.addListener(() {
      // cTxt.value = controller.text;
      cTxt.value = double.parse(controller.text);
      update();
    });
    postCheckInfosStatus();
    // session_token_post();
    // rechargeBlockchain_url_post();
  }

  void textFieldChanged(String str) {
    print(str);
    // print(controller);
  }

  getImage(int id) async {
    var status = await Permission.photos.status;
    print('before'); //pod add
    print(status); //denied
    if (!status.isGranted) {
      status = await Permission.photos.request(); //req granted
      if (status.isPermanentlyDenied) {
        status = await Permission.photos.request();
        FToast.toast(Get.context!, msg: '请去设置开启相册访问权限'.tr);
        // print(status);
        return;
      }
    }

    var image = await ImagePicker()
        .pickImage(imageQuality: 100, source: ImageSource.gallery);
    if (image != null) {
      // ByteData bytes = await rootBundle.load(image);
      // print(image);
      // print('dddxxx0'); //11.091450691223145 MB
      // // print(image.length() / 1024 / 1024);
      // var bytes = File(image.path);
      // var enc = await bytes.readAsBytesSync();
      // print(enc.lengthInBytes);
      // if(enc.lengthInBytes/1024/1024  > 5) {
      //   FToast.toast(Get.context!, msg: '要限制5M以内'.tr);
      //   return;
      // }

      // testCompressAndGetFile(File(image), image.path);
      cropAndUpload(image, image.path, id);
      // _upLoadImage(image,id);
    }
  }

  void cropAndUpload(var image, String imagePath, int id) {
    Future<String> fe = ImageUtils.cropImage(imagePath);
    fe.then((value) async {
      if (value != null && value is String) {
        var file = File(value);

        if (file.existsSync()) {
          // print('dddxxx');//11MB 11630229 Byte
          // print(file.lengthSync());
          // print('dddxxx1'); //11.091450691223145 MB
          // print((file.readAsBytesSync().lengthInBytes) / 1024 / 1024);
          //
          // if((file.readAsBytesSync().lengthInBytes) / 1024 / 1024/ 2  > 10) {
          //   FToast.toast(Get.context!, msg: '要限制5M以内'.tr);
          //   return;
          // }
          //展示等待框
          //压缩文件
          var r =
              await FlutterImageCompress.compressWithFile(value, quality: 70);
          if (r == null) {
            FToast.toast(Get.context!, msg: '失败'.tr);
            return;
          }
          // print('dddxxx2');
          // print(r.lengthInBytes);

          String imageName = file.path.split("/").last;
          uploadImage(r, imageName, id);
        }
      }
    });
  }

  uploadImage(image, imageName, id) => request(() async {
        String url = RequestConfig.baseUrl + RequestConfig.uploadImgPath;
        LoadingBarrierView.showLoading(Get.context!);
        var post = await HttpUtils().postImage(url, image, imageName);
        LoadingBarrierView.hideLoading(Get.context!);
        id == 0
            ? image0.value = post['data']
            : id == 1
                ? image1.value = post['data']
                : image2.value = post['data'];

        update();
      });

  _upLoadImage(image, id) => request(() async {
        String url = RequestConfig.baseUrl + RequestConfig.uploadImgPath;
        LoadingBarrierView.showLoading(Get.context!);
        var post = await HttpUtils().post(url, image);
        LoadingBarrierView.hideLoading(Get.context!);
        id == 0
            ? image0.value = post['data']
            : id == 1
                ? image1.value = post['data']
                : image2.value = post['data'];

        update();
      });

  void session_token_post() => request(() async {
        var url = APIS.home;
        var data = {};
        var user = await requestClient.post(url, data: data);
        print(user);
        session_token.value = user['session_token'];
        return;
      });
  void rechargeBlockchain_url_post() => request(() async {
        var url = APIS.home;
        var data = {};
        var recharge = await requestClient.post(url, data: data);
        print(recharge);
        for (var i = 0; i < recharge.length; i++) {
          if (recharge[i]['coin'] == argu) {
            rechargeBlockchain_url_data.add(recharge[i]);
          }
        }
        rechargeBlockchain_url_show.value = rechargeBlockchain_url_data[0];
        print(rechargeBlockchain_url_show['blockchain_name']);
        depositFee.value = rechargeBlockchain_url_show['fee'];
        // recharge['withdraw_fee'];
        return;
      });

  getPerm(context) async {
    var status = await Permission.storage.status;
    if (!status.isGranted) {
      status = await Permission.storage.request();
      print(status);
      return;
    }

    RenderRepaintBoundary? boundary =
        repaintKey.currentContext?.findRenderObject()! as RenderRepaintBoundary;
    ui.Image image = await boundary.toImage();
    ByteData? byteData = await image.toByteData(format: ui.ImageByteFormat.png);
    final result = await ImageGallerySaver.saveImage(
        byteData!.buffer.asUint8List(),
        quality: 100,
        name: 'boss_Image' + DateTime.now().toString());
    if (result['isSuccess'].toString() == 'true') {
      FToast.toast(context, msg: "保存成功".tr);
    } else {
      FToast.toast(context, msg: "保存失败".tr);
    }
  }

  void postform(context) => request(() async {
        if (controller0.text == '') {
          FToast.toast(context, msg: "请输入真实姓名".tr);
          return;
        }
        if (controller.text == '') {
          FToast.toast(context, msg: "请输入证件/护照号码".tr);
          return;
        }

        if (image0.value == '') {
          FToast.toast(context, msg: "请上传全图片".tr);
          return;
        }
        if (image1.value == '') {
          FToast.toast(context, msg: "请上传全图片".tr);
          return;
        }
        if (image2.value == '') {
          FToast.toast(context, msg: "请上传全图片".tr);
          return;
        }

        String isoCode = "";
        for (int i = 0; i < countryList.length; ++i) {
          if (countryList[i].isoCode == m_countryiso.value) {
            isoCode = countryList[i].isoCode;
          }
        }

        // var user2 = await requestClient.post(APIS.session_token,data: {
        // });
        // print(user2);
        // session_token.value = user2['session_token'];
        var url = APIS.home;
        var data = {
          'nationality': isoCode.toLowerCase(),
          'name': '${controller0.text}',
          'idname': "身份证".tr,
          // 'idname':'${controller0.text}',
          // 'session_token': '${session_token.value}',
          'idnumber': '${controller.text}',
          // 'from':'123',
          // 'blockchain_name':'${rechargeBlockchain_url_show['blockchain_name']}',
          // 'img':'${image2.value}',
          'idimg_1': '${image0.value}',
          'idimg_2': '${image1.value}',
          'idimg_3': '${image2.value}',

          // 'coin':'${rechargeBlockchain_url_show['coin']}',
          // 'channel_address':'${rechargeBlockchain_url_show['address']}',
          // 'tx':'123',
        };
        // controller0.text=='';
        // controller.text=='';
        // image0.value=='';
        // image1.value=='';
        // image2.value=='';
        var recharge = await requestClient.post(url, data: data);
        // controller0.text=='';
        // controller.text=='';
        // image0.value=='';
        // image1.value=='';
        // image2.value=='';
        print(recharge);
        FToast.toast(context, msg: "提交成功".tr);
        postCheckInfosStatus();
        // Get.offNamed('/succ?path=3');
        // Get.offNamed('/submitSuccess?path=topup&path2=topupRecord');
      });
}
