import 'package:flutter/material.dart';

/// Octoganal clipper clips the widget in octagon shape used with [ClipPath]
class ClipperView extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var sx = 10.0;
    final path = Path()
      ..lineTo(sx, 0)
      ..lineTo(size.width, 0)
      ..lineTo(size.width - sx, size.height)
      ..lineTo(0, size.height)
      ..lineTo(sx, 0)
      ..close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}
