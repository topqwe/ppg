import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';
import 'package:tapped/tapped.dart';
import '../../widgets/button_widget.dart';
import '../../widgets/helpTools.dart';
import '../../widgets/image_widget.dart';
import '../DefaultAppBar.dart';
import '../../style/theme.dart';
import 'countries.dart';

String m_gChooseIso = "";
String m_gChoosePhone = "1";
pushCountryPage(
    BuildContext context, VoidCallback okcb, VoidCallback canclecb,
    {bshowName: true}) {
  openPage(
      countryChoosePage(
        canclecb: canclecb,
        okcb: okcb,
        bshowName: bshowName,
      ),
      context);
}

class countryChoosePage extends StatefulWidget {
  final VoidCallback okcb;
  final VoidCallback canclecb;
  final bool bshowName;
  const countryChoosePage({
    Key? key,
    required this.okcb,
    required this.canclecb,
    required this.bshowName,
  }) : super(key: key);

  @override
  _countryChoosePageState createState() => _countryChoosePageState();
}

class _countryChoosePageState extends State<countryChoosePage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // m_gChooseIso = "";
  }

  @override
  void dispose() {
    super.dispose();
  }

  var _controller = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    List<Widget> col = <Widget>[];

    col.add(SizedBox(
      height: 20,
    ));
    for (int i = 0; i < countryList.length; ++i) {
      var searchText = _controller.text;
      if (searchText.isNotEmpty) {
        if (!countryList[i]
            .name
            .toLowerCase()
            .contains(searchText.toLowerCase())) continue;
      }
      Container c = Container(
        padding: EdgeInsets.only(bottom: 30, top: 0, left: 0),
        alignment: Alignment.center,
        child: Tapped(
            onTap: () {
              m_gChooseIso = countryList[i].isoCode;
              m_gChoosePhone = countryList[i].phoneCode;
              this.widget.okcb();
              Navigator.of(context).pop();
            },
            child: Row(
              // mainAxisAlignment: MainAxisAlignment.center,
              children: [
                imageCircularNoH(
                    w: 35,
                    radius: 1,
                    image:
                        'assets/images/country/${countryList[i].isoCode.toLowerCase()}.png'),
                SizedBox(
                  width: 10,
                ),
                Text(countryList[i].name.length > 26
                    ? countryList[i].name.substring(0, 26) + "..."
                    : countryList[i].name,style: TextStyle(
                  fontWeight: FontWeight.normal,
                  fontSize: 14,
                  inherit: true,
                ),),

                Expanded(child: SizedBox()),
                Text('+' + countryList[i].phoneCode,
                  style: TextStyle(
                  fontWeight: FontWeight.normal,
                  color: AppTheme.themeGreyColor,
                  fontSize: 14,
                  inherit: true,
                ),),

              ],
            )),
      );
      col.add(c);
    }


    return
      KeyboardDismisser(
          gestures: [
            GestureType.onTap,
            GestureType.onPanUpdateDownDirection,
          ],
          child:
          Scaffold(
            // resizeToAvoidBottomInset: false,
            backgroundColor: Colors.white,
            appBar:
            DefaultAppBar(titleStr: widget.bshowName ? "选择国家".tr : "选择区域码".tr),
            body:
            SafeArea(child:
            Column(
              children: <Widget>[
                SizedBox(height: 10,),
                Container(
                    alignment: Alignment.center,
                    //im if out has here no
                    child: Container(
                        alignment: Alignment.center,
                        padding: const EdgeInsets.only(left: 15, right: 15), //im
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Row(
                                children: [
                                  Container(
                                    height: 40,
                                    width:
                                    MediaQuery.of(Get.context!).size.width  - 30, //im
                                    decoration: BoxDecoration(
                                      color: const Color(0xFFF6F6F6),
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                    child: Row(
                                      children: <Widget>[
                                        const SizedBox(width: 5),
                                        IconButton(
                                            icon:  Icon(Icons.search,
                                                size: 20,
                                                color:
                                                // logic.cTxt.value.isNotEmpty?
                                                Color(0xffCCCCCC)
                                              // :Colors.transparent
                                            ),
                                            onPressed: () {
                                            }),

                                        // SizedBox(width: 6),
                                        Expanded(
                                            flex: 1,
                                            child: TextField(
                                              // 与输入框交互控制器
                                              controller: _controller,
                                              decoration: InputDecoration(
                                                contentPadding:
                                                const EdgeInsets.symmetric(
                                                    vertical: 10.0,
                                                    horizontal: 1),
                                                border: InputBorder.none,
                                                isCollapsed: true,
                                                hintText: "搜索".tr,
                                                suffixIcon: IconButton(
                                                    icon:  Icon(Icons.cancel,
                                                        size: 18,
                                                        color:
                                                        // logic.cTxt.value.isNotEmpty?
                                                        Color(0xffCCCCCC)
                                                            // :Colors.transparent
                                                    ),
                                                    onPressed: () {
                                                      _controller.text = '';
                                                      setState(() {});
                                                    }),
                                              ),
                                              style: TextStyle(
                                                color: Color.fromARGB(255, 153, 153, 153),
                                                fontWeight: FontWeight.normal,
                                                fontSize: 12,
                                                inherit: true,
                                              ),
                                              // 键盘动作右下角图标
                                              textInputAction: TextInputAction.search,

                                              // 输入框内容改变回调
                                              onChanged: (value) {
                                                setState(() {});
                                              },
                                              // onSubmitted: widget.onSearch, //输入框完成触发
                                              onSubmitted: (value) {
                                                setState(() {});
                                              },
                                            )),
                                        // _suffix(),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ]))),
              Expanded(child:
              ListView(
                padding: EdgeInsets.only(left: 15, right: 15),
                physics: AlwaysScrollableScrollPhysics(
                  parent: BouncingScrollPhysics(),
                ),
                children:
                col,
              ),
              ),

              ],
            ),


            )
            ,
          )

      )
    ;



  }
}
