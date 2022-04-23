import 'package:flutter/widgets.dart';

class BottomBarSizing {
  final EdgeInsets margin;
  final BoxDecoration decoration;
  final double height;
  final bool showText;
  final bool? textAtBottom;

  final double? iconSize;

  BottomBarSizing({
    required this.showText,
    required this.margin,
    required this.decoration,
    required this.height,
    this.textAtBottom,
    this.iconSize,
  });
}
