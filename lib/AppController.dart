import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:just_audio/just_audio.dart';
import 'package:liandan_flutter/services/cache/storage.dart';
import 'package:liandan_flutter/services/network_service.dart';
import '../store/AppCacheManager.dart';
import '../store/EventBus.dart';
import '../vendor/socket/online_socket_manager.dart';

import 'main.dart';

class AppBinding extends Bindings {
  @override
  void dependencies() {
    // Get.put(AppController());
    Get.lazyPut(() => AppController());
  }
}

class AppController extends GetxController {
  StreamSubscription<ConnectivityResult>? subscription;

  final player = AudioPlayer();


  late StreamSubscription? loginSubscription;

  OnlineSocketManager? onlineSocketManager;

  NetworkTestService? domainTestService;

  @override
  void onReady() {
    subscription = Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult result) {
      if (result == ConnectivityResult.none) {
        //"请检查您的网络状态";
      }
    });

    mainEventBus.on(EventBusConstants.loginSuccessEvent,
            (arg) {
              if (AppCacheManager.instance.getUserToken().isNotEmpty) {
                connectOnLineSocket();
              } else {
                onlineSocketManager?.destorySocket();
                onlineSocketManager = null;
              }
        });



    if (configEnv.autoChangeDomain) {
      domainTestService = NetworkTestService();
    }

    connectOnLineSocket();

    super.onReady();
  }

  void connectOnLineSocket() {
    if (!publicCheckLogin()) {
      return;
    }
    String path = "${configEnv.onlineWsUrl}${publicToken()}";
    onlineSocketManager ??= OnlineSocketManager([path]);
  }


  void playSound() async {
    // if (player.playing) {
    //   return;
    // }
    player.pause();
    await player.seek(Duration.zero);
    await player.play();
  }


  void configAudioPlayer() async {
    await player.setAsset('assets/audio/bd.mp3');
  }

  @override
  void onClose() {
    subscription?.cancel();
    player.dispose();
    // loginSubscription?.cancel();
    // WebSocketUtility.getInstance().closeSocket();
    mainEventBus.off(EventBusConstants.loginSuccessEvent);
    super.onClose();
  }
}
