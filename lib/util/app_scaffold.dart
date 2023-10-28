import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:liandan_flutter/util/DefaultAppBar.dart';

class AppScaffold extends StatelessWidget {
  final Widget? child;
  final String? title;
  final List<Widget>? actions;
  final VoidCallback? backAction;
  final bool hideBackButton;
  final bool hideAppbar;
  final Widget? floatingActionButton;
  final String? backTitle;
  const AppScaffold({
    super.key,
    this.child,
    this.title,
    this.actions,
    this.backAction,
    this.hideBackButton = false,
    this.hideAppbar = false,
    this.floatingActionButton,
    this.backTitle,
  });

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        systemNavigationBarColor: Colors.white,
        systemNavigationBarIconBrightness: Brightness.dark,
      ),
      child: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/img_bg.png"),
            fit: BoxFit.fill,
          ),
        ),
        child: Scaffold(
          floatingActionButton: floatingActionButton,
          floatingActionButtonLocation: floatingActionButton == null
              ? null
              : FloatingActionButtonLocation.centerDocked,
          appBar: hideAppbar
              ? null
              : DefaultAppBar(
      titleStr: title.toString(),
      // leading: SizedBox.shrink(),
    ),
          backgroundColor: Colors.transparent,
          body: child,
        ),
      ),
    );
  }
}
