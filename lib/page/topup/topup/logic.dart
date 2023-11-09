import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:ftoast/ftoast.dart';
import 'package:get/get.dart';

import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:liandan_flutter/services/api/api_basic.dart';
import '../../../services/request/http_utils.dart';
import '../../../services/responseHandle/request.dart';
import '../../../util/LoadingBarrierView.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:ui' as ui;
import '../../../util/ImageUtils.dart';

class TopupLogic extends GetxController {
  // var cTxt = ''.obs;
  var cTxt = 0.0.obs;
  var depositFee = 0.0.obs;
  var txtnum = TextEditingController();
  late TextEditingController controller;
  GlobalKey repaintKey = GlobalKey();
  var image2 = ''.obs;
  var session_token = ''.obs;
  var choseDatas = [].obs;
  var showData = {}.obs;
  var argu = Get.parameters['type'];
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    controller = TextEditingController();
    controller.addListener(() {
      // cTxt.value = controller.text;
      cTxt.value = double.parse(controller.text);
      update();
    });
    postSession();
    postTopUrl();
  }

  void textFieldChanged(String str) {
    print(str);
  }

  getImage() async {
    var status = await Permission.photos.status;
    print('camera before'); //pod add
    print(status); //denied
    if (!status.isGranted||status.isDenied) {
      status = await Permission.photos.request(); //req granted
      if (status.isPermanentlyDenied) {
        status = await Permission.photos.request();
        FToast.toast(Get.context!, msg: '请去设置开启相册访问权限'.tr);
        // print(status);
        return;
      }
    }

    var image = await ImagePicker()
        .pickImage(source: ImageSource.gallery);
    //imageQuality: 100,
    //Base from the error,
    // image_picker doesn't support png when compressing or changing the image quality. You can use flutter_image_compress plugin which has support for PNG format.
    if (image != null) {

      // cropAndUpload(image, image.path);
      _upLoadImage(image);
    }
  }

  void cropAndUpload(var image, String imagePath) {
    Future<String> fe = ImageUtils.cropImage(imagePath);
    fe.then((value) async {
      if (value != null && value is String) {
        var file = File(value);

        if (file.existsSync()) {

          var r =
              await FlutterImageCompress.compressWithFile(value, quality: 70);
          if (r == null) {
            FToast.toast(Get.context!, msg: '失败'.tr);
            return;
          }

          String imageName = file.path.split("/").last;
          uploadImage(r, imageName);
        }
      }
    });
  }

  uploadImage(image, imageName) => request(() async {
        LoadingBarrierView.showLoading(Get.context!);
        var post = await ApiBasic().postImage( image, imageName);
        LoadingBarrierView.hideLoading(Get.context!);
        image2.value = post['data'];

        update();
      });

  _upLoadImage(image) => request(() async {
        // LoadingBarrierView.showLoading(Get.context!);
        var postf = await ApiBasic().postImage2(image);
        // LoadingBarrierView.hideLoading(Get.context!);
        image2.value = postf['data'];

        update();
      });

  void postSession() => request(() async {
        var data = {};
        var user = await ApiBasic().home({});
        print(user);
        session_token.value = user['session_token'];
        return;
      });
  void postTopUrl() => request(() async {
        var data = {};
        var recharge = await ApiBasic().home({});
        print(recharge);
        for (var i = 0; i < recharge.length; i++) {
          if (recharge[i]['coin'] == argu) {
            choseDatas.add(recharge[i]);
          }
        }
        showData.value = choseDatas[0];
        print(showData['blockchain_name']);
        depositFee.value = showData['fee'];
        // recharge['withdraw_fee'];
        return;
      });

  getPerm() async {
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
        name: 'b' + DateTime.now().toString());
    if (result['isSuccess'].toString() == 'true') {
      FToast.toast(Get.context!, msg: "保存成功".tr);
    } else {
      FToast.toast(Get.context!, msg: "保存失败".tr);
    }
  }

  void postform(context) => request(() async {
        if (controller.text == '') {
          FToast.toast(context, msg: "请输入数量".tr);
          return;
        }
        if (depositFee * cTxt.value >
            showData['recharge_limit_max']) {
          FToast.toast(context,
              msg: '不得大于最大限额'.tr +
                  '${showData['recharge_limit_max']}');
          return;
        }
        if (depositFee * cTxt.value <
            showData['recharge_limit_min']) {
          FToast.toast(context,
              msg: '不得小于最小限额'.tr +
                  '${showData['recharge_limit_min']}');
          return;
        }
        if (image2.value == '') {
          FToast.toast(context, msg: "请上传图片".tr);
          return;
        }

        var user2 = await ApiBasic().home({});
        print(user2);
        session_token.value = user2['session_token'];
        var data = {
          'session_token': '${session_token.value}',
          'amount': '${controller.text}',
          'from': '123',
          'blockchain_name':
              '${showData['blockchain_name']}',
          'img': '${image2.value}',
          'coin': '${showData['coin']}',
          'channel_address': '${showData['address']}',
          'tx': '123',
        };
        controller.text == '';
        image2.value == '';
        var recharge = await ApiBasic().home({});
        controller.text == '';
        image2.value == '';
        print(recharge);
        FToast.toast(context, msg: "提交成功".tr);
        Get.offNamed('/submitSuccess?path=topup&path2=topupRecord');
        // Get.offNamed('/submitSuccess?path=withDraw&path2=withdrawalsRecord');
      });
}
