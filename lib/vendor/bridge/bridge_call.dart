//文件名：bridge_call.dart
//参考：https://pub.dev/packages/js
//参考：https://github.com/matanlurey/dart_js_interop
//参考：https://dart.dev/web/js-interop
import "package:js/js.dart";

// //dart调用web
// @JS("JSON.stringify")
// external String stringify(obj);

// //dart调用web
// @JS("window.alert")
// external void alert(obj);

// //dart调用iOS带参数
// @JS("window.webkit.messageHandlers.setCookies.postMessage")
// external void setCookies(obj);

// //dart调用iOS
// @JS("window.webkit.messageHandlers.getIMEI.postMessage")
// external String getIMEI();

// //dart调用Android带参数
// @JS("window.bridge.getIMEI")
// external String getIMEI();

//dart调用Android
@JS("window.NativeAndroid.copyToClipboard")
external void copyToClipboard(obj);
