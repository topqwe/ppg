import 'dart:async';
import 'dart:convert';

import 'package:loggy/loggy.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

abstract class SocketManager {
  late WebSocketChannel? channel;

  bool manualCloseSocket = false;

  int _tryNum = 0;

  List<dynamic> _wsList = [];
  int _wsIdx = 0;
  String _wsTail = "";

  Timer? pingTimer;

  void startPing() {
    if (pingTimer != null) {
      return;
    }
    pingTimer = Timer.periodic(const Duration(seconds: 10), (timer) {
      logInfo("send ping");
      if (!manualCloseSocket) {
        channel?.sink.add("ping");
      }
    });
  }

  SocketManager(List<dynamic> wsList, {String? wsTail}) {
    _wsList = wsList;
    _wsTail = wsTail ?? "";
    _setChannelHandler();
    _tryNum = 0;
  }

  void _setChannelHandler() async {
    manualCloseSocket = false;
    String currentPath = "";
    try {
      currentPath = _wsList[_wsIdx];
    } catch (_) {}
    if (currentPath == "") {
      return;
    }
    String optionPath = "$currentPath$_wsTail";
    logInfo(optionPath);
    try {
      channel = WebSocketChannel.connect(Uri.parse(optionPath));
      channel?.stream.listen(
        (message) {
          _tryNum = 0;
          Map<String, dynamic> msgJson = json.decode(message);
          if (msgJson["send"] != null && msgJson["send"] == "ping") {
            msgJson["send"] = "pong";
            if (!manualCloseSocket) {
              channel?.sink.add(json.encode(msgJson));
            }
          } else if (msgJson["channel"] != null) {
            dealwithSocketResult(message: msgJson);
          }
        },
        onDone: () {
          logInfo("Socket is closed");
          if (!manualCloseSocket && _wsList.length == 1) {
            _tryNum += 1;
            if (_tryNum >= 5) {
              return;
            }
            pingTimer = null;
            _reconnectSocket();
          }
        },
        onError: (e) {
          logInfo("Socket is error");
          pingTimer = null;
          _wsIdx += 1;
          if (_wsIdx > (_wsList.length - 1)) {
            onSocketError();
            return;
          }
          _reconnectSocket();
        },
      );
      startPing();
    } catch (e) {
      onSocketError();
    }
  }

  void dealwithSocketResult({
    required Map<String, dynamic> message,
  }) {}

  void _reconnectSocket() {
    channel?.sink.close();
    channel = null;
    _setChannelHandler();
    reSubscribeTopics();
  }

  // 重写此方法
  void reSubscribeTopics() {}

  void subscribeTopics({required List<String> topics}) {
    manualCloseSocket = false;
    for (String t in topics) {
      channel?.sink.add(t);
    }
  }

  void onSocketError() {}

  void destorySocket() {
    manualCloseSocket = true;
    channel?.sink.close();
    channel = null;
    pingTimer?.cancel();
    pingTimer = null;
  }
}
