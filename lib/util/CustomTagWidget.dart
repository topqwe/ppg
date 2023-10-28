import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../style/theme.dart';

///代码清单
class CustomTagWidget extends StatefulWidget {
  final Color bgColor;
  final Color selectedBgColor;
  final Color borderColor;
  final Color selectedBorderColor;
  final Color textColor;
  final Color selectedTextColor;
  final double setradius;


  final List  tabTitleList;
  final int select;
  final Function(int index) onTap;

  const CustomTagWidget(
      {Key? key,
        this.bgColor = Colors.transparent,
        this.selectedBgColor = Colors.transparent,
        this.borderColor = Colors.transparent,
        this.selectedBorderColor = Colors.transparent,
        this.textColor = Colors.grey,
        this.selectedTextColor= Colors.black,
        this.setradius = 20.0,
        required this.tabTitleList,
        this.select = 0,
        required this.onTap})
      : super(key: key);

  @override
  CustomTagWidgetState createState() => CustomTagWidgetState();
}

class CustomTagWidgetState extends State<CustomTagWidget> {
  List<TabModel> _list = [];
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    initDataFunction();
  }

  @override
  void didUpdateWidget(covariant CustomTagWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    _currentIndex = widget.select;
    initDataFunction();
  }

  initDataFunction() {
    _list = [];
    for (int i = 0; i < widget.tabTitleList.length; i++) {
      String title = widget.tabTitleList[i];
      _list.add(TabModel(title: title, select: _currentIndex == i, id: i));
    }
    widget.tabTitleList.forEach((element) {});
  }

  ScrollController _scrollController = new ScrollController();

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      controller: _scrollController,
      scrollDirection: Axis.horizontal,
      itemCount: _list.length,
      itemBuilder: (BuildContext context, int index) {
        TabModel _tabModel = _list[index];

        Color bgColor =  widget.bgColor;
        //Colors.grey[200]!;
        Color borderColor = widget.borderColor;
        // Colors.grey[200]!;
        Color textColor = widget.textColor;

        if (_tabModel.select) {
          bgColor = widget.selectedBgColor;
          //Colors.white;
          borderColor = widget.selectedBorderColor;
          // Colors.blueAccent;
          textColor = widget.selectedTextColor;
        }

        return Container(
          margin: EdgeInsets.only(left: 10, right: 10),
          child: Row(
            children: [
              GestureDetector(
                onTap: () {
                  // if (_tabModel.select) {
                  //   return;
                  // }
                  int selectIndex = 0;
                  for (int i = 0; i < _list.length; i++) {
                    TabModel element = _list[i];
                    String title = element.title;
                    String clickTitle = _tabModel.title;
                    if (title == clickTitle) {
                      element.select = true;
                      selectIndex = i;
                    } else {
                      element.select = false;
                    }
                  }
                  double offset = _scrollController.offset;
                  if (selectIndex <= 2) {
                    _scrollController.animateTo(
                      0.0,
                      duration: Duration(milliseconds: 400),
                      curve: Curves.linear,
                    );
                  } else if (selectIndex > 2 &&
                      selectIndex < _list.length - 3) {
                    if (selectIndex > _currentIndex) {
                      //向左滑动
                      _scrollController.animateTo(
                        offset + 80.0 + (selectIndex - _currentIndex - 1) * 80,
                        duration: Duration(milliseconds: 400),
                        curve: Curves.linear,
                      );
                    } else {
                      //向右滑动
                      _scrollController.animateTo(
                        offset - 60,
                        duration: Duration(milliseconds: 400),
                        curve: Curves.linear,
                      );
                    }
                  } else {
                    double max = _scrollController.position.maxScrollExtent;
                    _scrollController.animateTo(
                      max,
                      duration: Duration(milliseconds: 400),
                      curve: Curves.linear,
                    );
                  }
                  _currentIndex = selectIndex;

                  setState(() {});
                  if (widget.onTap != null) {
                    widget.onTap(_currentIndex);
                  }
                },
                child: Container(
                  padding:
                  EdgeInsets.only(left: 12, right: 12, top: 2, bottom: 2),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(widget.setradius)),
                    //背景
                    color: bgColor,
                    //边框
                    border: Border.all(color: borderColor),
                  ),
                  child: Text(
                    "${_tabModel.title}",
                    style: TextStyle(color: textColor),
                  ),
                ),
              ),

            ],
          ),
        );
      },
    );
  }
}

class TabModel {
  String title;
  int id;

  //true 为选中
  bool select;

  TabModel({required this.id, required this.title, this.select = false});
}