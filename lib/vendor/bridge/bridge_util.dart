import "package:js/js.dart";
import "dart:html";
import "dart:js";
import 'package:js/js_util.dart' as js_util;

var bridge;
//这里往window窗口写入bridge对象
bool checkBridge() {
  if (bridge == null) {
    js_util.setProperty(window, "NativeAndroid", Object());
    bridge = js_util.getProperty(window, "NativeAndroid");
  }
  return bridge != null;
}

//Android/iOS/web调用dart，本质是往bridge写入一个函数
void registerBridge(String name, void Function(String) callback) {
  if (checkBridge()) {
    js_util.setProperty(bridge, name, allowInterop(callback));
  }
}
