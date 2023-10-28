
import 'package:flutter/material.dart';
import 'package:ftoast/ftoast.dart';

import '../../util/SearchBar.dart';

class SearchPage extends StatefulWidget {

  const SearchPage({Key? key}) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
      SearchingBar(
        hintText: '请输入查询',
        onPressed: (text) => FToast.toast(context, msg:'搜索内容：$text'),
      ),
      body: Container(),
    );
  }
}
