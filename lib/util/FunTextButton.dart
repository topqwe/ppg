import 'package:flutter/material.dart';
import 'package:liandan_flutter/style/theme.dart';

enum FunTextButtonType {
  primary,
  secondary,
  disable,
}

class FunTextButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final String? title;
  final FunTextButtonType type;
  // 17 15 14
  final double fontSize;
  // 8 4
  final double borderRadius;

  const FunTextButton({
    Key? key,
    this.onPressed,
    this.title,
    this.type = FunTextButtonType.primary,
    this.fontSize = 15,
    this.borderRadius = 8,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isPrimary = type == FunTextButtonType.primary;
    return TextButton(
      onPressed: onPressed,
      style: ButtonStyle(
        side: type == FunTextButtonType.primary
            ? null
        :
        type == FunTextButtonType.disable

            ? null
            : MaterialStateProperty.all(
                const BorderSide(
                  color: Color(0xFFDEDEDE),
                  width: 1.0,
                  style: BorderStyle.solid,
                ),
              ),
        foregroundColor: MaterialStateProperty.resolveWith(
          (states) {
            if (states.contains(MaterialState.disabled)) {
              return isPrimary ? Color(0xFF999999) : Color(0xFF999999);
            }
            return isPrimary ? Colors.white
            :
            type == FunTextButtonType.disable ? Colors.white
                :
            AppTheme.themeHightColor;
          },
        ),
        backgroundColor: MaterialStateProperty.resolveWith(
          (states) {
            if (states.contains(MaterialState.disabled)) {
              return Color(0xFFFAFBFB);
            }
            return isPrimary ? AppTheme.themeHightColor
                :
            type == FunTextButtonType.disable ? Color(0xFFDEDEDE)
                :
            Color(0xFFFAFBFB) ;
          },
        ),
        overlayColor: MaterialStateProperty.all(
            isPrimary ? AppTheme.themeHightColor
                :
            type == FunTextButtonType.disable ? Color(0xFFDEDEDE)
                :
            const Color(0xFFE8EBED)),
        elevation: MaterialStateProperty.all(0),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
          ),
        ),
      ),
      child: Text(
        title ?? "",
        style: TextStyle(
          fontSize: fontSize,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
