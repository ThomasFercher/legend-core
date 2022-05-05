import 'package:flutter/widgets.dart';

class SiderSubMenuStyle {
  final Color background;
  final Color activeForeground;
  final Color activeBackground;
  final Color foreground;
  final BorderRadius? borderRadius;
  final double headerHeight;
  final double itemHeight;
  final double iconSize;
  final double spacing;
  final double subMenuIconSize;
  final EdgeInsetsGeometry itemPadding;

  SiderSubMenuStyle({
    required this.background,
    required this.activeForeground,
    required this.activeBackground,
    required this.foreground,
    required this.borderRadius,
    required this.headerHeight,
    required this.itemHeight,
    required this.iconSize,
    required this.subMenuIconSize,
    required this.spacing,
    required this.itemPadding,
  });
}

class SiderMenuStyle {
  final Color background;
  final Color foreground;
  final Color activeBackground;
  final Color activeForeground;
  final Color? subMenuColor;
  final double spacing;
  final EdgeInsetsGeometry padding;
  final BorderRadius? borderRadius;
  final double itemHeight;
  final double subMenuHeaderHeight;
  final double iconSize;

  SiderMenuStyle({
    required this.background,
    required this.foreground,
    required this.activeBackground,
    required this.activeForeground,
    this.subMenuColor,
    required this.spacing,
    required this.padding,
    this.borderRadius,
    required this.itemHeight,
    required this.subMenuHeaderHeight,
    required this.iconSize,
  });
}
