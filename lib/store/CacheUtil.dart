import 'dart:io';
import 'package:ftoast/ftoast.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:path_provider/path_provider.dart';

class CacheUtil {
  // /// 获取缓存大小
  // static Future<int> total() async {
  //   Directory tempDir = await getTemporaryDirectory();
  //   if (tempDir == null) return 0;
  //   int total = await _reduce(tempDir);
  //   return total;
  // }
  //
  /// 清除缓存
  static Future<void> clear() async {
    Directory tempDir = await getTemporaryDirectory();
    if (tempDir.existsSync()) {
      await _delete(tempDir);
      await tempDir.delete();
    }

    Directory docDirectory = await getApplicationDocumentsDirectory();
    if (docDirectory.existsSync()) {
      await _delete(docDirectory);
      await docDirectory.delete();
    }

  }

  /// 递归缓存目录，计算缓存大小
  static Future<int> _reduce(final FileSystemEntity file) async {
    /// 如果是一个文件，则直接返回文件大小
    if (file is File) {
      int length = await file.length();
      return length;
    }

    /// 如果是目录，则遍历目录并累计大小
    if (file is Directory) {
      final List<FileSystemEntity> children = file.listSync();

      int total = 0;

      if (children != null && children.isNotEmpty)
        for (final FileSystemEntity child in children)
          total += await _reduce(child);

      return total;
    }

    return 0;
  }

  /// 递归删除缓存目录和文件
  static Future<void> _delete(FileSystemEntity file) async {
    if (file is Directory && file.existsSync()) {
      print(file.path);
      final List<FileSystemEntity> children =
      file.listSync(recursive: true, followLinks: true);
      for (final FileSystemEntity child in children) {
        await _delete(child);
      }
    }
    try {
      if (file.existsSync()) {
        await file.delete(recursive: true);
      }
    } catch (err) {
      print(err);
    }


    // if (file is Directory) {
    //   final List<FileSystemEntity> children = file.listSync();
    //   for (final FileSystemEntity child in children) {
    //     await _delete(child);
    //   }
    // } else {
    //   await file.delete();
    // }
  }







  /// 获取缓存
  static Future<double> loadApplicationCache() async {
    //获取文件夹
    Directory docDirectory = await getApplicationDocumentsDirectory();
    Directory tempDirectory = await getTemporaryDirectory();

    double size = 0;

    if (docDirectory.existsSync()) {
      size += await getTotalSizeOfFilesInDir(docDirectory);
    }
    if (tempDirectory.existsSync()) {
      size += await getTotalSizeOfFilesInDir(tempDirectory);
    }
    return size;
  }

  /// 循环计算文件的大小（递归）
  static Future<double> getTotalSizeOfFilesInDir(final FileSystemEntity file) async {
    if (file is File) {
      int length = await file.length();
      return double.parse(length.toString());
    }
    if (file is Directory) {
      final List<FileSystemEntity> children = file.listSync();
      double total = 0;
      if (children != null)
        for (final FileSystemEntity child in children)
          total += await getTotalSizeOfFilesInDir(child);
      return total;
    }
    return 0;
  }

  /// 缓存大小格式转换
  static String formatSize(double value) {
    if (null == value) {
      return '0';
    }
    List<String> unitArr = []
      ..add('B')
      ..add('K')
      ..add('M')
      ..add('G');
    int index = 0;
    while (value > 1024) {
      index++;
      value = value / 1024;
    }
    String size = value.toStringAsFixed(2);
    return size + unitArr[index];
  }

  /// 删除缓存
  static  clearApplicationCache() async {
    clear();
    Directory docDirectory = await getApplicationDocumentsDirectory();
    Directory tempDirectory = await getTemporaryDirectory();

    if (docDirectory.existsSync()) {
      await deleteDirectory(docDirectory);
    }

    if (tempDirectory.existsSync()) {
      await deleteDirectory(tempDirectory);
    }

  }

  /// 递归方式删除目录
  static Future<Null> deleteDirectory(FileSystemEntity file) async {
    if (file is Directory) {
      final List<FileSystemEntity> children = file.listSync();
      for (final FileSystemEntity child in children) {
        await _delete(child);
      }
    }
    await file.delete();
  }


  /// 将数据内容写入doc文件夹里，如果不传direcName，默认存doc文件夹
  /// fileName: 文件名
  /// notes 要存储的内容
  /// direcName 文件夹名字，如分类，首页，购物车，我的等。可不传
  static void writeToFile(String fileName, String notes,
      {required String direcName}) async {
    //获取doc路径
    Directory documentsDir = await getApplicationDocumentsDirectory();
    if (!documentsDir.existsSync()) {
      documentsDir.createSync();
    }

    //用户文件夹，如果有uid,用uid见文件夹，没有建tourist
    String userId = 'abc';
        // LoginManager.uid;
    if (userId == null) {
      userId = "tourist";
    }
    String userFileDirec = '${documentsDir.path}/$userId';
    documentsDir = Directory(userFileDirec);
    if (!documentsDir.existsSync()) {
      documentsDir.createSync();
    }

    //功能文件夹
    if (direcName != null) {
      String path = '${documentsDir.path}/$direcName';
      documentsDir = Directory(path);
    }
    if (!documentsDir.existsSync()) {
      documentsDir.createSync();
    }
    String documentsPath = documentsDir.path;
    File file = new File('$documentsPath/$fileName');
    if (!file.existsSync()) {
      file.createSync();
    }

    //写入文件
    File file1 = await file.writeAsString(notes);
    if (file1.existsSync()) {
      FToast.toast(Get.context!, msg: "保存成功")
      ;
    }
  }


}
