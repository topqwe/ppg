import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ftoast/ftoast.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import '../widgets/button_widget.dart';
import '../widgets/helpTools.dart';
import 'DefaultAppBar.dart';
pushInputTextPage(
    BuildContext context, ValueChanged<String> okcb, VoidCallback canclecb,String title,
    ) {
  openPage(
      InputTextPage(
        okcb: okcb,
        canclecb: canclecb,
        title: title,
      ),
      context);
}
class InputTextPage extends StatefulWidget {

  final ValueChanged<String> okcb;
  final VoidCallback canclecb;
  final String title;
  final String? content;
  final String? hintText;
  final TextInputType? keyboardType;
  const InputTextPage({
    Key? key,
    required this.okcb,
    required this.canclecb,
    required this.title,
    this.content,
    this.hintText,
    this.keyboardType = TextInputType.text,
  }) : super(key : key);


  
  @override
  _InputTextPageState createState() => _InputTextPageState();
}

class _InputTextPageState extends State<InputTextPage> {

  final TextEditingController _controller = TextEditingController();
  List<TextInputFormatter>? _inputFormatters;
  late int _maxLength;

  @override
  void initState() {
    super.initState();
    _controller.text = widget.content ?? '';
    _maxLength = widget.keyboardType == TextInputType.phone ? 11 : 30;
    _inputFormatters = widget.keyboardType == TextInputType.phone ? [FilteringTextInputFormatter.allow(RegExp('[0-9]'))] : null;
  }
  
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
      DefaultAppBar(titleStr: widget.title, actions: [
        buttonText(w: 100, h: 50, text: '完成'.tr,textColor: Color(0xff999999),textSize:16, onPressed:(){
          if(_controller.text.isEmpty){
            FToast.toast(context, msg:'请输入');
            return;
          }
          Get.back();

           widget.okcb(_controller.text);
        }),
      ]),// Get.back(result:'${_controller.text}');

      body: Padding(
        padding: const EdgeInsets.only(top: 21.0, left: 16.0, right: 16.0, bottom: 16.0),
        child: Semantics(
          multiline: true,
          maxValueLength: _maxLength,
          child: TextField(
            maxLength: _maxLength,
            maxLines: 5,
            autofocus: true,
            controller: _controller,
            keyboardType: widget.keyboardType,
            inputFormatters: _inputFormatters,
            decoration: InputDecoration(
              hintText: widget.hintText,
              border: InputBorder.none,
            ),
          ),
        ),
      ),
    );
  }
}
