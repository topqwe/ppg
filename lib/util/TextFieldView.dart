
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../style/theme.dart';


class TextFieldView extends StatefulWidget {
  final TextInputType? keyboardType;
  final ValueChanged<String>? onChanged;
  final String? hintText;
  final double? height;
  final Decoration? decoration;
  final String title;
  final Widget? endChild;
  late  String initValue;
  final bool readOnly;
  final EdgeInsetsGeometry? margin;
  final List<TextInputFormatter>? inputFormatters;
  final TextEditingController? inputController;
  final VoidCallback? onTap;
  final bool isViviEdit;
  final bool isRTextField;
  bool isObscureType ;
  bool isObscureText ;
  Function? onObscured;
   TextFieldView({Key? key,
     this.keyboardType,
    this.onChanged,
    this.hintText,
    this.height,
    this.decoration, this.title ='',
    this.endChild, this.initValue = '',
    this.margin, this.inputFormatters,  this.readOnly = false, this.onTap, this.inputController,
     this.isViviEdit= true,
   this.isRTextField = false,
     this.isObscureType = false,
     this.isObscureText = false,
     this.onObscured,
   })
      : super(key: key);

  @override
  State createState() => _TextFieldViewState();
}

class _TextFieldViewState extends State<TextFieldView> {
  late TextEditingController _inputController;
  String text = "";

  @override
  void initState() {
    super.initState();
    _inputController = widget.inputController??TextEditingController(text: widget.initValue??'');
    _inputController.text = widget.initValue;
    _inputController.addListener(search);
  }

  //搜索当前
  void search() {
    setState(() {
      text = _inputController.text;
    });
  }

  @override
  void dispose() {
    _inputController.removeListener(search);
    _inputController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return _buildSearch();
  }

  Widget _buildSearch() {
    return GestureDetector(
      onTap: widget.onTap,
      child:
      Column(children: [
        widget.isRTextField?SizedBox.shrink():
        Column(children: [
          Row(children: [Text(widget.title,style: const TextStyle(fontSize: 14),),],),
          SizedBox(
            height: 10,
          ),
        ],),

        Container(
          // margin: widget.margin??const EdgeInsets.symmetric(horizontal: 15,vertical: 10),
          height: 44,
          decoration:widget.decoration??  BoxDecoration(
            color: Colors.white,
            border:
            Border.all(width: 1, color:widget.isRTextField?Color(0xffDDDDDD):Colors.white ),
            //
            // shape: const RoundedRectangleBorder(
            //   borderRadius: BorderRadius.all(Radius.circular(2)),
            // )
            borderRadius: BorderRadius.all(Radius.elliptical(5.0, 5.0),),
          ),
          child: Row(
            children: [
              widget.isRTextField?Row(children: [
                SizedBox(width: 5,),
                Text(widget.title,style: const TextStyle(fontSize: 14),),
              ],) :SizedBox.shrink(),

              if(widget.isViviEdit)Expanded(
                child: TextFormField(
                  obscureText: widget.isObscureText,
                  keyboardType: widget.keyboardType,
                  controller: _inputController,
                  style: const TextStyle(fontSize: 14),
                  readOnly: widget.readOnly,
                  inputFormatters: widget.inputFormatters,
                  onChanged: widget.onChanged,
                  decoration: InputDecoration(
                    isCollapsed: true,
                    // contentPadding: EdgeInsets.all(10),

                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 12.0, horizontal: 10),
                    // fillColor: Color(0xff2F375B),
                    // filled: true,
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color:widget.isRTextField? Colors.white
                          :
                          AppTheme.themeHightColor,
                          width: 1.0),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: widget.isRTextField? Colors.white
                              :Color(0xffDDDDDD),
                          width: 1.0),
                    ),
                    hintText: widget.hintText,
                    hintStyle: TextStyle(
                        color: AppTheme.themeGreyColor),
                    border: InputBorder.none,
                    counterText: '',
                    suffixIcon:
                    widget.isObscureType?

                    IconButton(
                        icon: Icon(!widget.isObscureText?Icons.visibility
                          :Icons.visibility_off,
                            size: 18,
                            color:!widget.isObscureText?
                                 Color(0xffCCCCCC)
                                : AppTheme.themeHightColor
                        ),
                        onPressed: () {
                          widget.onObscured!();

                          widget.isObscureText = ! widget.isObscureText;

                          setState(() {

                          });

                          // widget.initValue = '';
                          // _inputController.text = '';
                        })

                        :

                    IconButton(
                        icon: Icon(Icons.cancel,
                            size: 18,
                            color: widget.initValue.isNotEmpty
                                ? Color(0xffCCCCCC)
                                : Colors.transparent),
                        onPressed: () {
                          widget.initValue = '';
                          _inputController.text = '';
                        }),
                  ),
                  // autofocus: false,

                ),
              ),
              if(widget.endChild != null) widget.endChild!,
            ],
          ),
        ),
      ],)


    );
  }
}
