import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:ftoast/ftoast.dart';
import 'package:get/get.dart';
import '../widgets/image_widget.dart';
import '../widgets/sizebox_widget.dart';
import '../style/theme.dart';
showSetPWSheet(
    BuildContext context, ValueChanged<String> okcb, VoidCallback canclecb) {
  //显示对话框

  showModalBottomSheet<void>(
      context: Get.context!,
      /// 禁止拖动关闭
      enableDrag: false,
      /// 使用true则高度不受16分之9的最高限制
      isScrollControlled: true,
      builder: (_) => SetPWSheet(okcb: okcb,canclecb: canclecb,)
  );


}

// typedef  okcb =Function(String string);

class SetPWSheet extends StatefulWidget {

  final ValueChanged<String> okcb;
  final VoidCallback canclecb;

  const SetPWSheet({
    Key? key,
    required this.okcb,
    required this.canclecb,
  }) : super(key: key);

  @override
  SetPWSheetState createState() => SetPWSheetState();
}

class SetPWSheetState extends State<SetPWSheet> {

  int _index = 0;
  final _list = [1, 2, 3, 4, 5, 6, 7, 8, 9, 0, 0, 0];
  final List<String> _codeList = ['', '', '', '', '', ''];
  
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      height: context.height * 7 / 10.0,
      child: Column(
        children: <Widget>[
          Stack(
            children: <Widget>[
              Container(
                width: double.infinity,
                alignment: Alignment.center,
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: const Text(
                  '设置提现密码',
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold
                  ),
                ),
              ),
              Positioned(
                right: 16.0,
                top: 16.0,
                bottom: 16.0,
                child: Semantics(
                  label: '关闭',
                  child: GestureDetector(
                    onTap: () {
                      widget.canclecb();
                      Get.back();
                    } ,
                    child: IconButton(
                      padding: EdgeInsets.only(right: 0),
                      alignment: Alignment.centerRight,
                      color: Color(0xff999999),
                      icon: Icon(Icons.close_rounded, color: Color(0xff999999), size: 25),
                      iconSize: 25,
                      onPressed: (){
                        widget.canclecb();
                        Get.back();

                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  height: 45.0,
                  margin: const EdgeInsets.only(left: 16.0, right: 16.0),
                  decoration: BoxDecoration(
                    border: Border.all(width: 0.6, color: AppTheme.themeGreyColor),
                    borderRadius: BorderRadius.circular(4.0),
                  ),
                  child: Row(
                    children: List.generate(_codeList.length, (i) => _buildInputWidget(i))
                  ),
                ),
                SizedBox(height: 10,),
                Text('提现密码不可为连续、重复的6位数字。', style: Theme.of(context).textTheme.subtitle2),
              ],
            ),
          ),
          divideLine(),
          Container(
            color: Theme.of(context).dividerTheme.color,
            child: GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                childAspectRatio: 1.953,
                mainAxisSpacing: 0.6,
                crossAxisSpacing: 0.6,
              ),
              itemCount: 12,
              itemBuilder: (_, index) => _buildButton(index)
            ),
          ),
        ],
      )
    );
  }

  Widget _buildButton(int index) {
    // final color = context.isDark ? Colours.dark_bg_gray : Colours.dark_button_text;
    return Material(
      color: (index == 9 || index == 11) ? AppTheme.themeGreyColor : null,
      child: InkWell(
        child: Center(
          child: index == 11 ? Semantics(
            label: '删除',
            child:
            Image.asset('assets/images/public/del.png',width: 32,height: 15,)
            ,
          ) : index == 9 ? Semantics(
            label: '无效',
            child: const SizedBox.shrink(),
          ) : Text(
            _list[index].toString(),
            style: const TextStyle(fontSize: 26.0),
          ),
        ),
        onTap: () async {
          if (index == 9) {
            return;
          }

          /// 点击时给予振动反馈
          // if (!GetPlatform.isDesktop && (await Vibration.hasVibrator() ?? false)) {
          //   Vibration.vibrate(duration: 10);
          // }

          if (index == 11) {
            if (_index == 0) {
              return;
            }
            _codeList[_index - 1] = '';
            _index--;
            setState(() {

            });
            return;
          }
          _codeList[_index] = _list[index].toString();
          _index++;
          if (_index == _codeList.length) {

            var code = '';
            for (var i = 0; i < _codeList.length; i ++) {
              code = code + _codeList[i];
            }
            // FToast.toast(Get.context!, msg:'密码：$code');
            // Navigator.of(context).pop();
            Get.back();
            widget.okcb('${code}');

            _index = 0;
            for (var i = 0; i < _codeList.length; i ++) {
              _codeList[i] = '';
            }
          }
          setState(() {

          });
        },
      ),
    );
  }

  Widget _buildInputWidget(int p) {
    return Expanded(
      child: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          border: p != 5 ? Border(
            right: Divider.createBorderSide(context, color: AppTheme.themeGreyColor, width: 0.6),
          ) : null,
        ),
        child: Text(_codeList[p].isEmpty ? '' : '●', style: TextStyle(color: Colors.black,
          fontSize: 12,
        ),),
      ),
    );
  }
}
