import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ftoast/ftoast.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'BaseDialog.dart';
showTFInputDialog(
    BuildContext context, ValueChanged<String> okcb, VoidCallback canclecb,String title) {
  showDialog<void>(
      context: Get.context!,
      barrierDismissible: false,
      builder: (_) => TFInputDialog(okcb: okcb, canclecb: canclecb,title: title,)
  );

}
class TFInputDialog extends StatefulWidget {
  final ValueChanged<String> okcb;
  final VoidCallback canclecb;


  const TFInputDialog({
    Key? key,
  required this.okcb,
  required this.canclecb,
    this.title,
    this.inputMaxPrice = 100000,
    // required this.onPressed,
  }) : super(key : key);

  final String? title;
  final double inputMaxPrice;
  // final Function(String) onPressed;
  
  @override
  _PriceInputDialog createState() => _PriceInputDialog();
  
}

class _PriceInputDialog extends State<TFInputDialog> {

  final TextEditingController _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    return BaseDialog(
      title: widget.title,
      child: Container(
        height: 34.0,
        alignment: Alignment.center,
        margin: const EdgeInsets.fromLTRB(16.0, 8.0, 16.0, 0.0),
        decoration: BoxDecoration(
          color: Color(0xFFF6F6F6),
          borderRadius: BorderRadius.circular(2.0),
        ),
        child: TextField(
          key: const Key('price_input'),
          autofocus: true,
          controller: _controller,
          //style: TextStyles.textDark14,
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
          // 限制数字格式
          inputFormatters: [
            // FilteringTextInputFormatter.allow(RegExp('[0-9]')),
            FilteringTextInputFormatter.allow(RegExp(r'[0-9.]'
            r'')),
          ],
          decoration: InputDecoration(
            isDense: true,
            contentPadding: const EdgeInsets.symmetric(horizontal: 16.0),
            border: InputBorder.none,
            hintText: '输入${widget.title}',
            //hintStyle: TextStyles.textGrayC14,
          ),
        ),
      ),
      onPressed: () {
        if (_controller.text.isEmpty) {
          FToast.toast(context, msg:'请输入${widget.title}');
          return;
        }
        Get.back();
        // widget.onPressed(_controller.text);
        widget.okcb('${_controller.text}');
      },
    );
  }
}
