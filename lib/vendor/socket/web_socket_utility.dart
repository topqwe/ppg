import 'dart:async';
// import 'dart:html';
import 'package:liandan_flutter/main.dart';
import 'protocol.pb.dart';
import 'package:loggy/loggy.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

import 'dart:convert';

import '../../services/cache/storage.dart';
import '../../services/response/ws_message.dart';

// class Uint8ListTransformer extends DefaultTransformer {
//   @override
//   Future<String> transformRequest(RequestOptions options) async {
//     if (options.data is Uint8List) {
//       return String.fromCharCodes(options.data);
//     } else {
//       return super.transformRequest(options);
//     }
//   }
// }


/// WebSocket状态
enum SocketStatus {
  SocketStatusConnected, // 已连接
  SocketStatusFailed, // 失败
  SocketStatusClosed, // 连接关闭
}

class WebSocketUtility {
  var id = "1001";

  /// 获取单例内部方法
  // factory WebSocketUtility() {
  //   // 只能有一个实例
  //   if (_socket == null) {
  //     _socket = new WebSocketUtility._();
  //   }
  //   return _socket;
  // }

  late WebSocketChannel _webSocket; // WebSocket
  late SocketStatus socketStatus; // socket状态
  late Timer? _heartBeat; // 心跳定时器
  final int _heartTimes = 20; // 心跳间隔(毫秒)
  final num _reconnectCount = 5; // 重连次数，默认60次
  late num _reconnectTimes = 0; // 重连计数器
  late Timer? _reconnectTimer; // 重连定时器
  late Function onError; // 连接错误回调
  late Function onOpen; // 连接开启回调
  late Function onMessage; // 接收消息回调
  /// 单例对象
  ///
  ///
  WebSocketUtility();
  static final WebSocketUtility _instance = WebSocketUtility._();

  // 私有构造器
  WebSocketUtility._();
  // 方案1：静态方法获得实例变量
  static WebSocketUtility getInstance() => _instance;

  bool shouldReconnect = true;

  /// 初始化WebSocket
  void initWebSocket({
    Function? onMessage,
    Function? onError,
  }) {
    shouldReconnect = true;
    this.onMessage = onMessage!;
    this.onError = onError!;
    logInfo('WebSocket连接成功');
    openSocket();
  }

  // void getWebSocket({Function onMessage}) {
  //   this.onMessage = onMessage;
  // }

  /// 开启WebSocket连接
  void openSocket() {
    try {
      String http = configEnv.bizWsUrl;
      Uri url = Uri.parse(http);
      _webSocket = WebSocketChannel.connect(url);
      // print('WebSocket连接成功');
      // 连接成功，返回WebSocket实例
      socketStatus = SocketStatus.SocketStatusConnected;
      // 连接成功，重置重连计数器

      sendauto();

      // 接收消息
      _webSocket.stream.listen((data) => webSocketOnMessage(data),
          onError: webSocketOnError, onDone: webSocketOnDone);

      // _reconnectTimes = 0;
      // if (_reconnectTimer != null) {
      //   _reconnectTimer.cancel();
      // }
    } catch (_) {}
  }

  /// WebSocket接收消息回调
  webSocketOnMessage(data) {
    //  var dataJson = json.encode(data);

// ## token内容
// | 指令     | 说明  |
// | :-----     | :---  |
// | mid | 用户id |
// | room_id | 房间类型://房间号 如没有 可以默认为 {appname}://1 |
// | platform | 平台 |
// | accepts | 接受订阅的topic |
// | key | 客户端唯一key 可不填 有特殊要求时候 生成一个唯一值 保证定点推送 |

// ## 指令
// | 指令     | 说明  |
// | :-----     | :---  |
// | 2 | 客户端请求心跳 |
// | 3 | 服务端心跳答复 |
// | 5 | 下行消息 |
// | 7 | auth认证 |
// | 8 | auth认证返回 |

    Proto pbdata = Proto.fromBuffer(data);
    if (pbdata.op == 8) {
      initHeartBeat();
    }

    if (pbdata.op == 3) {
      logInfo("心跳回复");
    }
    if (pbdata.op == 9) {
      String result = utf8.decode(pbdata.body);
      logInfo(result);
      Map<String, dynamic> resultJson = json.decode(result);
      WsMessage me = WsMessage.fromJson(resultJson);
      onMessage(me);
      // print(data);

      // _listeners.forEach((Function callback) {
      //   callback(data);
      // });
    }
  }

  /// WebSocket关闭连接回调
  webSocketOnDone() {
    logInfo('WebSocket关闭连接---done');
    // print('closed');
    reconnect();
  }

  ///
  /// 添加回调
  ///

  /// WebSocket连接错误回调
  webSocketOnError(e) {
    WebSocketChannelException ex = e;
    socketStatus = SocketStatus.SocketStatusFailed;
    onError(ex.message);
    closeSocket();
  }

  /// 初始化心跳
  void initHeartBeat() {
    _heartBeat = Timer.periodic(Duration(seconds: _heartTimes), (timer) {
      sentHeart();
    });
  }

  /// 心跳
  void sentHeart() {
    String mid = publicUserInfo()?.memberId ?? "";
    Map data = {
      'mid': mid,
      'room_id': "0",
      'accepts': [1001, 1002],
      'platform': "web"
    };

    String token = json.encode(data);

    Proto req = Proto.create();
    req.ver = 1;
    req.op = 2;
    req.seq = 1;
    req.body = utf8.encode(token);
    sendMessage(req.writeToBuffer());
  }

  void sendauto() {
    sendMessage(heartBeatrMsg().writeToBuffer());
  }

  Proto heartBeatrMsg() {
    String mid = publicUserInfo()?.memberId ?? "";
    Map data = {
      'mid': mid,
      'room_id': "0",
      'accepts': [1001, 1002],
      'platform': "web"
    };

    String token = json.encode(data);

    Proto req = Proto.create();
    req.ver = 1;
    req.op = 7;
    req.seq = 1;
    req.body = utf8.encode(token);

    return req;
  }

  /// 销毁心跳
  void destroyHeartBeat() {
    _heartBeat?.cancel();
    _heartBeat = null;
  }

  /// 关闭WebSocket
  void closeSocket() {
    shouldReconnect = false;
    _webSocket.sink.close();
    destroyHeartBeat();
    socketStatus = SocketStatus.SocketStatusClosed;
  }

  /// 发送WebSocket消息
  void sendMessage(message) {
    switch (socketStatus) {
      case SocketStatus.SocketStatusConnected:
        // print('发送中：' + message);
        _webSocket.sink.add(message);
        break;
      case SocketStatus.SocketStatusClosed:
        logInfo('连接已关闭');
        break;
      case SocketStatus.SocketStatusFailed:
        // print('发送失败');
        break;
      default:
        break;
    }
  }

  /// 重连机制
  void reconnect() {
    if (!shouldReconnect) return;
    if (_reconnectTimes < _reconnectCount) {
      _reconnectTimes++;
      _reconnectTimer = Timer.periodic(Duration(seconds: _heartTimes), (timer) {
        openSocket();
      });
    } else {
      if (_reconnectTimer != null) {
        // print('重连次数超过最大次数');
        _reconnectTimer?.cancel();
      }
      return;
    }
  }
}
