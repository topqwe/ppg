import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:liandan_flutter/style/theme.dart';
import 'package:liandan_flutter/util/TextFieldView.dart';

import '../widgets/button_widget.dart';
import '../widgets/helpTools.dart';
import 'FunTextButton.dart';
import 'JCHub.dart';



showSMSVerifyDialog(
    BuildContext context, final Function(String, String)? okcb,final Function(String, String)? surecb, VoidCallback canclecb) {
  showDialog<void>(
      context: Get.context!,
      barrierDismissible: false,
      builder: (_) => SMSVerifyDialog(okcb: okcb,surecb:surecb, canclecb: canclecb)
  );

}


class SMSVerifyDialog extends StatefulWidget {

  final Function(String, String)? okcb;
  final Function(String, String)? surecb;
  final VoidCallback canclecb;

  const SMSVerifyDialog({
    Key? key,
    required this.okcb,
    required this.surecb,
    required this.canclecb,
  }) : super(key: key);
  @override
  _SMSVerifyDialogState createState() => _SMSVerifyDialogState();
}

class _SMSVerifyDialogState extends State<SMSVerifyDialog> {

  final int _second = 60;
  late int _currentSecond;
  StreamSubscription? _subscription;
  bool _clickable = true;


  bool isInputAll = false;

  final FocusNode _focusNode = FocusNode();


  String phoneStr = '';
  String msgStr = '';
  @override
  void initState() {
    // mainEventBus.on(EventBusConstants.grabRefreshBkListEvent,
    //         (arg) {
    //           setState(() {
    //             Get.back();
    //           });
    //     });
    super.initState();
  }
  
  @override
  void dispose() {
    _subscription?.cancel();
    _focusNode.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    final Color textColor = Theme.of(context).primaryColor;
    
    final Widget child = Column(
      children: <Widget>[
        Stack(
          children: <Widget>[
            Container(
              width: double.infinity,
              height: 56.0,
              alignment: Alignment.topCenter,
              padding: const EdgeInsets.only(top: 13.0),
              child: const Text(
                '手机号绑定',
                style: TextStyle(
                  fontWeight: FontWeight.normal,
                  fontSize: 18,
                  inherit: true,
                ),
              ),
            ),
            Positioned(
              top: 0.0,
              right: 0.0,
              child: Semantics(
                label: '关闭',
                child: GestureDetector(
                  onTap: () => Get.back(),
                  child:  Padding(
                    padding: EdgeInsets.only(top: 16.0, right: 16.0),
                    child:
                    // Image.asset(
                    //   'assets/images/tamthoi/icon-closee.png',
                    //   width: 16,
                    //   height: 16,
                    // )
                    Icon(Icons.close, color: Color(0xff999999), size: 16),
                  ),
                ),
              ),
            )
          ],
        ),

        // SizedBox(height: 7,),
Container(
  height:45,
  margin: EdgeInsets.only(left: 10,right: 10),
  decoration: BoxDecoration(
      borderRadius:
      BorderRadius.circular(25),
      // color: Color(0xff262C4A),
      border: Border.all(
          color: AppTheme.themeHightColor.withOpacity(0.8),
          width: 0)),
  // decoration: BoxDecoration(
  //     color:   AppColors.primaryColor.withOpacity(0.8),
  //     borderRadius: const BorderRadius.all(
  //       Radius.circular(25),
  //     )),
  alignment: Alignment.center,


  child:
Row(children: [


  Expanded(flex:2,child:
  TextFieldView(
    isRTextField: true,
    isShowBorder: false,
    height: 43,
    hintText:
    '请输入手机号' ,
    inputFormatters: [
      FilteringTextInputFormatter.allow(RegExp("[0-9]")),
      LengthLimitingTextInputFormatter(11), //最大长度
    ],
    onChanged: (value) {
      phoneStr = value;
      setState(() {
        if(phoneStr.isNotEmpty&&
            msgStr.isNotEmpty){
          isInputAll = true;
        }else{
          isInputAll = false;
        }
      });
    },
  ),

  ),

  Container(width: 89,child: MyButton(
    fontSize: 11,
    text: _clickable ? '获取验证码' : '已发($_currentSecond s)',
    textColor: textColor,
    disabledTextColor: Colors.grey,
    backgroundColor: Colors.transparent,
    disabledBackgroundColor: Colors.transparent,
    onPressed: _clickable ? () {
      if(phoneStr.isEmpty){
        JCHub.showmsg("请输入手机号", context);
        return;
      }
      if(validateMobile(phoneStr)==false){
        JCHub.showmsg("请输入有效格式手机号", context);
        return;
      }
      setState(() {
        _currentSecond = _second;
        print('send');
        _clickable = false;
      });
      _subscription = Stream.periodic(const Duration(seconds: 1), (i) => i).take(_second).listen((i) {
        setState(() {
          _currentSecond = _second - i - 1;
          _clickable = _currentSecond < 1;
        });
      });
      Future.delayed(const Duration(milliseconds: 500), () {

              widget.okcb?.call(phoneStr,'aaa');


      });







    }: null,
  ),
  ),


],)
  ,)
        ,

        // const SizedBox(height: 7),
        // Container(margin:  EdgeInsets.only(left: 16, right: 16),
        //   color: Color(0xFFE5E7F3),height: .5, ),
        const SizedBox(height: 7),

        Container(
          height:45,
          margin: EdgeInsets.only(left: 10,right: 10),
          decoration: BoxDecoration(
              borderRadius:
              BorderRadius.circular(25),
              // color: Color(0xff262C4A),
              border: Border.all(
                  color: AppTheme.themeHightColor.withOpacity(0.8),
                  width: 0)),
          // decoration: BoxDecoration(
          //     color:   AppColors.primaryColor.withOpacity(0.8),
          //     borderRadius: const BorderRadius.all(
          //       Radius.circular(25),
          //     )),
          alignment: Alignment.center,

          child:

        TextFieldView(
          isRTextField: true,
          isShowBorder: false,
          height: 43,
         hintText:
          '请输入短信验证码' ,
          inputFormatters: [
            // FilteringTextInputFormatter.allow(RegExp("[0-9]")),
            LengthLimitingTextInputFormatter(13), //最大长度
          ],
          onChanged: (value) {
            msgStr = value;
            setState(() {
              if(phoneStr.isNotEmpty&&
              msgStr.isNotEmpty){
                isInputAll = true;
              }else{
                isInputAll = false;
              }
            });
          },
        )
          ,)
       ,




        SizedBox(height: 7,),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: Text('',
              style: const TextStyle(color:Color(0xFF9395A4),fontSize: 11), textAlign: TextAlign.center),
        ),
        SizedBox(height: 10,),
        // Expanded(
        //   child:
          SizedBox(
            width: 150,
            height: 45,
            child:
            FunTextButton(
              type: isInputAll?FunTextButtonType.primary:FunTextButtonType.disable,
              title: "确定",
              borderRadius: 22,
              onPressed: (){
                if(!isInputAll)return;
                if(phoneStr.isEmpty){
                  JCHub.showmsg("请输入手机号", context);
                  return;
                }
                if(msgStr.isEmpty){
                  JCHub.showmsg("请输入短信验证码", context);
                  return;
                }
                widget.surecb?.call(phoneStr,msgStr);
Get.back();

              },
            ),
          ),
        // ),
      ],
    );

    Widget body = Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.0),
      ),
      width: 300.0,
      height: 250.0,
      child: child,
    );


      body = AnimatedContainer(
        alignment: Alignment.center,
        height: context.height - MediaQuery.of(context).viewInsets.bottom,
        duration: const Duration(milliseconds: 120),
        curve: Curves.easeInCubic,
        child: body,
      );


    return Scaffold(//创建透明层
      backgroundColor: Colors.transparent,//透明类型
      body: body,
    );
  }


}
