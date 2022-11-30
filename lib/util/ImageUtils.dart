import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import '../style/theme.dart';

class ImageUtils {
  /**
   * 裁剪图片
   */
  static Future<String> cropImage(String imagePath) async {
    final croppedFile = await ImageCropper().cropImage(
      sourcePath: imagePath,
      // maxHeight: 520,
      // maxWidth: 520,
      aspectRatioPresets: [
        CropAspectRatioPreset.original,
      ],
      compressQuality: 100,
      compressFormat: ImageCompressFormat.png,
      uiSettings: [
        AndroidUiSettings(
            toolbarTitle: '',
            toolbarColor: Colors.white,
            toolbarWidgetColor: Colors.white,
            // AppTheme.themeHightColor,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: false),
        IOSUiSettings(
          title: '',
        )
      ],
    );
    if (croppedFile != null) {
      return croppedFile.path;
    }

    return "";
  }
}
