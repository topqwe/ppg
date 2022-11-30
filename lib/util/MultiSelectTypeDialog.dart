import 'package:flutter/material.dart';
import 'package:ftoast/ftoast.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import 'BaseDialog.dart';

showMultiSelectTypeDialog(
    BuildContext context, ValueChanged<List<int>> okcb, VoidCallback canclecb,List<int> value) {
  showDialog<void>(
      context: Get.context!,
      barrierDismissible: false,
      builder: (_) => MultiSelectTypeDialog(okcb: okcb, canclecb: canclecb,value: value,)
  );

}
class MultiSelectTypeDialog extends StatefulWidget {
  final ValueChanged<List<int>> okcb;
  final VoidCallback canclecb;


  const MultiSelectTypeDialog({
  Key? key,
  required this.okcb,
  required this.canclecb,
    this.value,
  }) : super(key : key);

  final List<int>? value;
  
  @override
  _MultiSelectTypeDialog createState() => _MultiSelectTypeDialog();
  
}

class _MultiSelectTypeDialog extends State<MultiSelectTypeDialog> {

  late List<int> _selectValue;
  final List<String> _list = <String>['A', 'B', 'C'];

  Widget _buildItem(int index) {
    _selectValue = widget.value ?? <int>[0];
    return Material(
      type: MaterialType.transparency,
      child: InkWell(
        child: SizedBox(
          height: 42.0,
          child: Row(
            children: <Widget>[
              SizedBox(width: 16,),
              Expanded(
                child: Text(_list[index],
                  // style: TextStyle(color:_selectValue.contains(index) ?Colors.black:Colors.white )
                  // ,
                ),
              ),
              Image.asset(_selectValue.contains(index) ? 'assets/images/public/selectedJ.png' : 'assets/images/public/unselectedJ.png', width: 16.0, height: 16.0),
              SizedBox(width: 16,),
            ],
          ),
        ),
        onTap: () {
          if (mounted) {
            if (index == 0) {
              FToast.toast(context, msg:'A为必选项');
              return;
            }
            setState(() {
              if (_selectValue.contains(index)) {
                _selectValue.remove(index);
              } else {
                _selectValue.add(index);
              }
            });
          }
        },
      ),
    );
  }
  
  @override
  Widget build(BuildContext context) {
    return BaseDialog(
      title: '(多选)',
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        mainAxisSize: MainAxisSize.min,
        children: List.generate(_list.length, (i) => _buildItem(i))
      ),
      onPressed: () {
        Get.back();
        widget.okcb(_selectValue);
      },
    );
  }
}
