import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

import 'app_scaffold.dart';


class InAppWV extends StatefulWidget {
  final String url;
  final String title;
  final bool showAppBar;
  const InAppWV({
    Key? key,
    required this.url,
    required this.title,
    this.showAppBar = true,
  }) : super(key: key);
  @override
  InAppWVState createState() => InAppWVState();
}

class InAppWVState extends State<InAppWV> {
  @override
  void initState() {
    super.initState();
    // registerWebViewWebImplementation();
  }

  Size get screenSize => MediaQuery.of(context).size;
  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Widget _buildWebViewX() {
      return InAppWebView(//WebUri(widget.url)
        initialUrlRequest: URLRequest(url:Uri.parse(widget.url) ),
        // initialSettings: InAppWebViewSettings(
        //   useShouldOverrideUrlLoading: true,
        //   mediaPlaybackRequiresUserGesture: false,
        //   iframeReferrerPolicy: ReferrerPolicy.NO_REFERRER,
        // ),
        // onReceivedError: (controller, request, error) {
        //   print("onReceivedError: $error");
        // },
      );
    }

    return AppScaffold(
      title: widget.title,
      hideAppbar: !widget.showAppBar && kIsWeb,
      child: _buildWebViewX(),
    );
  }
}
