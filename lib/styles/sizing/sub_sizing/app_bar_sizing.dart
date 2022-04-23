import 'package:flutter/widgets.dart';

class FixedAppBarSizing {
  final Radius? borderRadius;
  final EdgeInsets contentPadding;
  final ShapeBorder? shape;
  final double logoSize;
  late final bool pinned;
  late final bool floating;
  final double? spacing;
  final double appBarHeight;
  final double? iconSize;

  FixedAppBarSizing({
    required this.appBarHeight,
    this.borderRadius,
    required this.contentPadding,
    this.shape,
    bool? pinned,
    bool? floating,
    this.iconSize,
    this.spacing,
    required this.logoSize,
  }) {
    this.floating = floating ?? false;

    if (this.floating) {
      this.pinned = false;
    } else {
      this.pinned = pinned ?? true;
    }
  }
}
