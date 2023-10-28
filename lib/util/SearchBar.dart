import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import '../../../../widgets/button_widget.dart';

/// 搜索页的AppBar
class SearchingBar extends StatefulWidget implements PreferredSizeWidget {

  const SearchingBar({
    Key? key,
    this.hintText = '',
    this.backImg = 'assets/images/ic_back_black.png',
    this.onPressed,
  }): super(key: key);

  final String backImg;
  final String hintText;
  final Function(String)? onPressed;

  @override
  _SearchBarState createState() => _SearchBarState();

  @override
  Size get preferredSize => const Size.fromHeight(48.0);
}

class _SearchBarState extends State<SearchingBar> {

  final TextEditingController _controller = TextEditingController();
  final FocusNode _focus = FocusNode();

  @override
  void dispose() {
    _focus.dispose();
    _controller.dispose();
    super.dispose();
  }

  // @override
  // void initState() {
  //   WidgetsBinding.instance!.addPostFrameCallback((_) async {
  //     SystemChannels.textInput.invokeMethod<void>('TextInput.updateConfig', const TextInputConfiguration().toJson());
  //     SystemChannels.textInput.invokeMethod<void>('TextInput.hide');
  //   });
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {

    final Widget back = Semantics(
      label: '返回',
      child: SizedBox(
        width: 48.0,
        height: 48.0,
        child: InkWell(
          onTap: () {
            _focus.unfocus();
            Navigator.maybePop(context);
          },
          borderRadius: BorderRadius.circular(24.0),
          child: Padding(
            key: const Key('search_back'),
            padding: const EdgeInsets.only(left: 16.0,right: 16.0
            ,top: 8.0,bottom: 8.0),
            child:
                arrowBackBtn(() {

                })


            // Image.asset(
            //   widget.backImg,
            //   color: isDark ? Colours.dark_text : Colours.text,
            // ),
          ),
        ),
      ),
    );

    /// 使用2.0.0新增CupertinoSearchTextField 实现， 需添加依赖 cupertino_icons: ^1.0.2
    // final Widget textField1 = Expanded(child: Container(
    //     height: 32.0,
    //     child: CupertinoSearchTextField(
    //       key: const Key('search_text_field'),
    //       controller: _controller,
    //       focusNode: _focus,
    //       placeholder: widget.hintText,
    //       placeholderStyle: Theme.of(context).inputDecorationTheme.hintStyle,
    //       padding: const EdgeInsetsDirectional.fromSTEB(3.8, 0, 5, 0),
    //       prefixInsets: const EdgeInsetsDirectional.fromSTEB(8, 0, 0, 0),
    //       suffixInsets: const EdgeInsetsDirectional.fromSTEB(0, 0, 8, 0),
    //       style: Theme.of(context).textTheme.subtitle1,
    //       itemSize: 16.0,
    //       itemColor: iconColor,
    //       decoration: BoxDecoration(
    //         color: isDark ? Colours.dark_material_bg : Colours.bg_gray,
    //         borderRadius: BorderRadius.circular(4.0),
    //       ),
    //       onSubmitted: (String val) {
    //         _focus.unfocus();
    //         // 点击软键盘的动作按钮时的回调
    //         widget.onPressed(val);
    //       },
    //     )
    // ));

    final Widget textField = Expanded(
      child: Container(
        height: 32.0,
        decoration: BoxDecoration(
          color:  Colors.grey,
          borderRadius: BorderRadius.circular(4.0),
        ),
        child: TextField(
          key: const Key('search_text_field'),
//          autofocus: true,
          controller: _controller,
          focusNode: _focus,
          textInputAction: TextInputAction.search,
          onSubmitted: (String val) {
            _focus.unfocus();
            // 点击软键盘的动作按钮时的回调
            widget.onPressed?.call(val);
          },
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.only(left: -8.0, right: -16.0, bottom: 12.0),
            border: InputBorder.none,
            icon: Padding(
              padding: const EdgeInsets.only(top: 8.0, bottom: 8.0, left: 8.0),
              child:
              Image.asset('assets/images/public/searchIcon.png',width: 16,height: 16,)
             ,
            ),
            hintText: widget.hintText,
            suffixIcon: GestureDetector(
              child: Semantics(
                label: '清空',
                child: Padding(
                  padding: const EdgeInsets.only(left: 16.0, top: 8.0, bottom: 8.0),
                  child:
                  Image.asset('assets/images/public/roundDelete.png',width: 16,height: 16,)

                ),
              ),
              onTap: () {
                /// https://github.com/flutter/flutter/issues/35848
                SchedulerBinding.instance!.addPostFrameCallback((_) {
                  _controller.text = '';
                });
              },
            ),
          ),
        ),
      ),
    );
    
    final Widget search = MyButton(
      minHeight: 32.0,
      minWidth: 44.0,
      fontSize: 14,
      radius: 4.0,
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      text: '搜索',
      onPressed:() {
        _focus.unfocus();
        widget.onPressed?.call(_controller.text);
      },
    );
    
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value:  SystemUiOverlayStyle.dark,
      child: Material(
        color: Colors.white,
        child: SafeArea(
          child: Row(
            children: <Widget>[
              back,
              textField,
              SizedBox(width: 16,),
              search,
              SizedBox(width: 16,),
            ],
          ),
        ),
      ),
    );
  }
}
