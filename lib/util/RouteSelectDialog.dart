import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:liandan_flutter/main.dart';
import 'package:liandan_flutter/util/FunTextButton.dart';

import '../../services/request/api_response.dart';
import '../store/EventBusNew.dart';
import '../widgets/helpTools.dart';



showRouteSelectDialog(
    BuildContext context, final Function(int, String)? okcb, VoidCallback canclecb,int selIndex,List<String> selArr,List<String> selRoutes) {
  showDialog<void>(
      context: Get.context!,
      barrierDismissible: false,
      builder: (_) => RouteSelectDialog(okcb: okcb, canclecb: canclecb,selIndex:selIndex,selArr:selArr,selRoutes:selRoutes)
  );

}


class RouteSelectDialog extends StatefulWidget {

  final Function(int, String)? okcb;
  final VoidCallback canclecb;

  const RouteSelectDialog({
    Key? key,
    required this.okcb,
    required this.canclecb,
    this.selIndex,
    this.selArr,
    this.selRoutes,
  }) : super(key: key);

  final int? selIndex;
  final List<String>? selArr ;
  final List<String>? selRoutes ;
  @override
  _RouteSelectDialogState createState() => _RouteSelectDialogState();
}

class _RouteSelectDialogState extends State<RouteSelectDialog> {



  final FocusNode _focusNode = FocusNode();
  final TextEditingController _controller = TextEditingController();


  String phoneStr = '';
  String msgStr = '';


  int _value = 0;
  List _list = [];
  List _rlist = [];

  Widget _buildItem(int index) {

    int curRate =  int.parse(_rlist[index]);
    return Material(
      type: MaterialType.transparency,
      child: InkWell(
        child: SizedBox(
          height: 52.0,
          child:
          Column(children: [

          Row(
            children: <Widget>[
              SizedBox(width: 16,),
              Expanded(
                child: Text(
                  _value == index ?_list[index]+'(当前)':_list[index],
                  style: _value == index ? TextStyle(
                    fontSize: 14,
                    color: Colors.black,
                  ) :
                  TextStyle(
                    fontSize: 14,
                    color: Colors.black,
                  )
                  //null,
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

          Row(
            children: <Widget>[
            SizedBox(width: 16,),
            Expanded(
              child: Text(
                curRate==1000000?'(测速中)':_rlist[index]+' ms',
                // _value == index ?
                style:  TextStyle(
                  fontSize: 14,
                  color:enumTypeColor(type: curRate)
                  ,
                  // Theme.of(context).primaryColor,
                ) ,
              ),
            ),
              SizedBox(width: 16,),
            ],
          ),


          ],)
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
  void initState() {
    super.initState();
    _value = widget.selIndex ?? 0;
    _list = widget.selArr?? [];
    _rlist = widget.selRoutes?? [];
    EventBusNew.eventBus.on<RouteChangedEvent
    >().listen((event) {
      List? arr = event.arr;
      if (arr!.isNotEmpty) {
        setState(() {
          _rlist = arr;
          _value = event.index!;
        });
      }
    });
  }
  
  @override
  void dispose() {
    _focusNode.dispose();
    _controller.dispose();
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
                '线路切换',
                style: TextStyle(
                  fontWeight: FontWeight.normal,
                  fontSize: 18,
                  inherit: true,
                ),
              ),
            ),
            // Positioned(
            //   top: 0.0,
            //   right: 0.0,
            //   child: Semantics(
            //     label: '关闭',
            //     child: GestureDetector(
            //       onTap: () => Get.back(),
            //       child: const Padding(
            //         padding: EdgeInsets.only(top: 16.0, right: 16.0),
            //         child: Icon(Icons.close_rounded, color: Color(0xff999999), size: 16),
            //       ),
            //     ),
            //   ),
            // )
          ],
        ),

        // SizedBox(height: 7,),
    Expanded(
    child: Container(
    width: double.infinity,
    child: SingleChildScrollView(
    child:
        Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            mainAxisSize: MainAxisSize.min,
            children: List.generate(_list.length, (i) => _buildItem(i))
        ),
    ),
    )),
    Padding(
    padding: EdgeInsets.only(bottom: 16.0,left: 16.0, right: 16.0),
    child:
        Row(
          children: [
            Expanded(
              child: SizedBox(
                height: 40,
                child: FunTextButton(
                  title: "取消",
                  borderRadius: 22,
                  type: FunTextButtonType.secondary,
                  onPressed: (){
                    Get.back();
                  },
                ),
              ),
            ),
            const SizedBox(
              width: 20,
            ),
            Expanded(
              child: SizedBox(
                height: 40,
                child: FunTextButton(
                  title: "确定",
                  borderRadius: 22,
                  onPressed: (){
                    widget.okcb?.call(_value,_list[_value]);

                    Get.back();
                  },
                ),
              ),
            ),
          ],
        ),
    ),
        // Expanded(
        //   child:
        //   SizedBox(
        //     height: 50,
        //     child:

          // ),
        // ),
      ],
    );

    Widget body = Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.0),
      ),
      width: 280.0,
      height:
      360.0,
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
