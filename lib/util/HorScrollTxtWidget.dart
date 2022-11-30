import 'dart:async';

import 'package:flutter/material.dart';
import 'package:infinite_listview/infinite_listview.dart';

class HorScrollTxtWidget extends StatefulWidget {
  HorScrollTxtWidget({Key? key, required this.count, required this.itemBuilder})
      : super(key: key);

  int count;

  IndexedWidgetBuilder itemBuilder;

  @override
  HorScrollTxtWidgetState createState() => HorScrollTxtWidgetState();
}

class HorScrollTxtWidgetState extends State<HorScrollTxtWidget> {
  late PageController _controller;
  late Timer _timer;

  @override
  void initState() {
    super.initState();

    _controller = PageController();
    _timer = Timer.periodic(const Duration(seconds: 3), (timer) {
      if (_controller.page!.round() >= widget.count) {
        _controller.jumpToPage(0);
      }
      _controller.nextPage(
          duration: const Duration(seconds: 1), curve: Curves.linear);
    });
  }

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
        scrollDirection: Axis.horizontal,

        controller: _controller,
        itemBuilder: (buildContent, index) {
          if (index < widget.count) {
            return widget.itemBuilder(buildContent, index);
          } else {
            return widget.itemBuilder(buildContent, 0);
          }
        },
        itemCount: widget.count + 1);
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
    _timer.cancel();
  }
}


///无限滚动文本
class SwiperListWidget extends StatefulWidget {
  const SwiperListWidget({Key? key}) : super(key: key);

  @override
  SwiperListWidgetState createState() => SwiperListWidgetState();
}

class SwiperListWidgetState extends State<SwiperListWidget> {
  late Timer _timer;
  int currentIndex = 0;
  List titleList = ["1","2","3","4","5","6","7","8","9","10","11"];
  final InfiniteScrollController _infiniteController = InfiniteScrollController(
    initialScrollOffset: 0.0,
  );

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(milliseconds: 300), (timer) {
      _infiniteController.animateTo(_infiniteController.offset + 44.0,
          duration: const Duration(milliseconds: 1000), curve: Curves.linear);
    });
  }

  @override
  Widget build(BuildContext context) {
    return AbsorbPointer(
      child: InfiniteListView.separated(
        controller: _infiniteController,
        itemBuilder: (BuildContext context, int index) {
          currentIndex ++;
          if(currentIndex >=11) currentIndex =0;
          return Material(
            child: SizedBox(
                height: 44,
                child: Text(titleList[currentIndex])),
          );
        },
        separatorBuilder: (BuildContext context, int index) => const Divider(height: 0.0,color: Colors.white,),
        anchor: 0.0,
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _timer.cancel();
  }
}
