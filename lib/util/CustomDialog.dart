import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:liandan_flutter/style/theme.dart';

ShowCustomDialog({
  String? title,
  String? detail,
  String? primaryTitle,
  String? secondaryTitle,
  Widget? detailWidget,
  VoidCallback? primaryAction,
  VoidCallback? secondaryAction,
  TextAlign? detailTextAlign,
  bool barrierDismissible = true,
  Widget? topWidget,
  bool useVertialButton = false,
  double? borderRadius,
  Widget? bottomWidget,
  bool preventDismissOnPrimaryAction = false,
}) {
  Get.dialog(
    PayAlertDialog(
      title: title,
      detail: detail,
      primaryTitle: primaryTitle,
      secondaryTitle: secondaryTitle,
      primaryAction: primaryAction,
      secondaryAction: secondaryAction,
      detailTextAlign: detailTextAlign ?? TextAlign.center,
      detailWidget: detailWidget,
      topWidget: topWidget,
      useVertialButton: useVertialButton,
      borderRadius: borderRadius,
      bottomWidget: bottomWidget,
      preventDismissOnPrimaryAction: preventDismissOnPrimaryAction,
    ),
    barrierDismissible: barrierDismissible,
    barrierColor: const Color(0xFF000000).withOpacity(0.5),
  );
}

class PayAlertDialog extends StatelessWidget {
  final String? title;
  final String? detail;
  final String? primaryTitle;
  final String? secondaryTitle;
  final VoidCallback? primaryAction;
  final VoidCallback? secondaryAction;
  final TextAlign detailTextAlign;
  final Widget? detailWidget;
  final Widget? topWidget;
  final bool useVertialButton;
  final double? borderRadius;
  final Widget? bottomWidget;
  final bool preventDismissOnPrimaryAction;

  const PayAlertDialog({
    Key? key,
    this.title,
    this.detail,
    this.primaryTitle = "确定",
    this.secondaryTitle,
    this.primaryAction,
    this.secondaryAction,
    this.detailTextAlign = TextAlign.center,
    this.detailWidget,
    this.topWidget,
    this.useVertialButton = false,
    this.borderRadius,
    this.bottomWidget,
    this.preventDismissOnPrimaryAction = false,
  }) : super(key: key);

  void _dismissAction() {
    Get.back();
    // Navigator.of(Get.context!).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(borderRadius ?? 13)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              children: [
                topWidget ?? const SizedBox.shrink(),
                Container(
                  color: Colors.white,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      SizedBox(
                        height: topWidget == null ? 14 : 4,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 47,
                            vertical: topWidget == null ? 15 : 8),
                        child: Text(
                          title ?? "",
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 20,
                            color: Color(0xFF191C32),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      detailWidget ?? const SizedBox.shrink(),
                      detail == null
                          ? const SizedBox(
                              height: 10,
                            )
                          : Container(
                              constraints:
                                  BoxConstraints(maxHeight: Get.height * 0.5),
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 24),
                              child: SingleChildScrollView(
                                child: Text(
                                  detail ?? "",
                                  textAlign: detailTextAlign,
                                  style: const TextStyle(
                                    fontSize: 14,
                                    height: 1.4,
                                    color: Color(0xFF9395A4),
                                  ),
                                ),
                              ),
                            ),
                      detail != null
                          ? const SizedBox(
                              height: 24,
                            )
                          : const SizedBox.shrink(),
                      buildButtons(),
                      bottomWidget ??
                          const SizedBox(
                            height: 30,
                          ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildButtons() {
    if (useVertialButton) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            GestureDetector(
              onTap: () {
                if (!preventDismissOnPrimaryAction) {
                  _dismissAction();
                }
                primaryAction?.call();
              },
              child: Container(
                  height: 44,
                  // padding: const EdgeInsets.symmetric(vertical: 6),
                  decoration: BoxDecoration(
                    color: const Color(0xFF191C31),
                    borderRadius: BorderRadius.circular(25),
                  ),
                  // color: BibColor.grayBG,
                  alignment: Alignment.center,
                  child: Text(
                    primaryTitle ?? "",
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.center,
                  )),
            ),
            if (secondaryTitle != null)
              GestureDetector(
                onTap: () {
                  _dismissAction();
                  secondaryAction?.call();
                },
                child: Container(
                    height: 44,
                    margin: const EdgeInsets.only(top: 9),
                    // padding: const EdgeInsets.symmetric(vertical: 6),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFAFBFB),
                      border: Border.all(
                        color: const Color(0xFFDEDEDE),
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(25),
                    ),
                    // color: BibColor.grayBG,
                    alignment: Alignment.center,
                    child: Text(
                      secondaryTitle ?? "",
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                        color: AppTheme.themeHightColor,
                      ),
                      textAlign: TextAlign.center,
                    )),
              ),
          ],
        ),
      );
    }
    return SizedBox(
      height: 56,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (secondaryTitle != null)
            GestureDetector(
              onTap: () {
                _dismissAction();
                secondaryAction?.call();
              },
              child: Container(
                  width: 140,
                  padding: const EdgeInsets.symmetric(vertical: 6),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFAFBFB),
                    border: Border.all(
                      color: Color(0xFFF2F3F8),
                      width: 1,
                    ),
                    borderRadius: BorderRadius.circular(25),
                  ),
                  // color: BibColor.grayBG,
                  alignment: Alignment.center,
                  child: Text(
                    secondaryTitle ?? "",
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      color: AppTheme.themeHightColor,
                    ),
                    textAlign: TextAlign.center,
                  )),
            ),
          GestureDetector(
            onTap: () {
              if (!preventDismissOnPrimaryAction) {
                _dismissAction();
              }
              primaryAction?.call();
            },
            child: Container(
                width: 140,
                padding: const EdgeInsets.symmetric(vertical: 6),
                decoration: BoxDecoration(
                  color: const Color(0xFF191C31),
                  borderRadius: BorderRadius.circular(25),
                ),
                // color: BibColor.grayBG,
                alignment: Alignment.center,
                child: Text(
                  primaryTitle ?? "",
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.center,
                )),
          ),
        ],
      ),
    );
  }
}
