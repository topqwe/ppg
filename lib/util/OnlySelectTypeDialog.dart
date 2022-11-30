import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import 'BaseDialog.dart';

showOnlySelectTypeDialog(
    BuildContext context, ValueChanged<String> okcb, VoidCallback canclecb) {
  showDialog<void>(
      context: Get.context!,
      barrierDismissible: false,
      builder: (_) {
        return OnlySelectTypeDialog(
          onPressed: (index, type) {
            okcb('${type}');
          },
        );
      }
  );

}
class OnlySelectTypeDialog extends StatefulWidget {

  const OnlySelectTypeDialog({
    Key? key,
    this.onPressed,
  }) : super(key : key);

  final Function(int, String)? onPressed;
  
  @override
  _OnlySelectTypeDialog createState() => _OnlySelectTypeDialog();
  
}

class _OnlySelectTypeDialog extends State<OnlySelectTypeDialog> {

  int _value = 0;
  final _list = ['UnSelect', 'A', 'B', 'C'];

  Widget _buildItem(int index) {
    return Material(
      type: MaterialType.transparency,
      child: InkWell(
        child: SizedBox(
          height: 42.0,
          child: Row(
            children: <Widget>[
              SizedBox(width: 16,),
              Expanded(
                child: Text(
                  _list[index],
                  style: _value == index ? TextStyle(
                    fontSize: 14,
                    color: Theme.of(context).primaryColor,
                  ) : null,
                ),
              ),
              Visibility(
                visible: _value == index,
                child:
                Image.asset('assets/images/public/correct.png', width: 16.0, height: 16.0),
              ),
              SizedBox(width: 16,),
            ],
          ),
        ),
        onTap: () {
          if (mounted) {
            setState(() {
              _value = index;
            });
          }
        },
      ),
    );
  }
  
  @override
  Widget build(BuildContext context) {
    return BaseDialog(
      title: '单选',
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        mainAxisSize: MainAxisSize.min,
        children: List.generate(_list.length, (i) => _buildItem(i))
      ),
      onPressed: () {
        Get.back();
        widget.onPressed?.call(_value, _list[_value]);
      },
    );
  }
}
