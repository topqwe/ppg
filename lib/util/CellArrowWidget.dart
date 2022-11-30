import 'package:flutter/material.dart';
import '/widgets/button_widget.dart';

class CellArrowWidget extends StatelessWidget {

  const CellArrowWidget({
    Key? key,
    this.onTap,
    required this.title,
    this.content = '',
    this.textAlign = TextAlign.start,
    this.maxLines = 1
  }): super(key: key);

  final GestureTapCallback? onTap;
  final String title;
  final String content;
  final TextAlign textAlign;
  final int maxLines;

  @override
  Widget build(BuildContext context) {
    Widget child = Row(
      //为了数字类文字居中
      crossAxisAlignment: maxLines == 1 ? CrossAxisAlignment.center : CrossAxisAlignment.start,
      children: <Widget>[
        Text(title, textAlign: TextAlign.start),
        const Spacer(),
        SizedBox(width: 16,),
        Expanded(
          flex: 4,
          child: Text(
            content,
            maxLines: maxLines,
            textAlign: maxLines == 1 ? TextAlign.right : textAlign,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.subtitle2?.copyWith(fontSize: 14),
          ),
        ),
        SizedBox(width: 8,),
        Opacity(
          // 无点击事件时，隐藏箭头图标
          opacity: onTap == null ? 0 : 1,
          child: Padding(
            padding: EdgeInsets.only(top: maxLines == 1 ? 0.0 : 2.0),
            child: arrowForward(),
          ),
        )
      ],
    );
    
    /// 分隔线
    child = Container(
      margin: const EdgeInsets.only(left: 15.0),
      padding: const EdgeInsets.fromLTRB(10.0, 15.0, 15.0, 15.0),
      constraints: const BoxConstraints(
        minHeight: 50.0,
      ),
      // width: double.infinity,
      decoration: BoxDecoration(
        border: Border(
          bottom: Divider.createBorderSide(context, width: 0.6),
        ),
      ),
      child: child,
    );
    
    return InkWell(
      onTap: onTap,
      child: child,
    );
  }
}
