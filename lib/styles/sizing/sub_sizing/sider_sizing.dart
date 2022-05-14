import 'package:flutter/widgets.dart';

class SiderSizing {
  final double width;
  final double iconSize;
  final double spacing;
  final double itemHeight;
  final double subMenuHeaderHeight;
  final EdgeInsets itemPadding;
  final EdgeInsets subItemPadding;
  final double horizontalPadding;

  SiderSizing({
    this.width = -1,
    this.iconSize = -1,
    this.spacing = -1,
    this.itemHeight = -1,
    this.subMenuHeaderHeight = -1,
    this.subItemPadding = EdgeInsets.zero,
    this.itemPadding = EdgeInsets.zero,
    this.horizontalPadding = -1,
  });

  factory SiderSizing.from({
    required SiderSizing? siderSizing,
    required double width,
    required double iconSize,
    required double spacing,
    required double itemHeight,
    required double subMenuHeaderHeight,
    required double horizontalPadding,
    required EdgeInsets itemPadding,
    required EdgeInsets subItemPadding,
  }) {
    if (siderSizing == null) {
      return SiderSizing(
        width: width,
        iconSize: iconSize,
        spacing: spacing,
        itemHeight: itemHeight,
        subMenuHeaderHeight: subMenuHeaderHeight,
        itemPadding: itemPadding,
        subItemPadding: subItemPadding,
        horizontalPadding: horizontalPadding,
      );
    } else {
      return SiderSizing(
        width: siderSizing.width == -1 ? width : siderSizing.width,
        iconSize: siderSizing.iconSize == -1 ? iconSize : siderSizing.iconSize,
        spacing: siderSizing.spacing == -1 ? spacing : siderSizing.spacing,
        itemHeight:
            siderSizing.itemHeight == -1 ? itemHeight : siderSizing.itemHeight,
        subMenuHeaderHeight: siderSizing.subMenuHeaderHeight == -1
            ? subMenuHeaderHeight
            : siderSizing.subMenuHeaderHeight,
        subItemPadding: siderSizing.subItemPadding == EdgeInsets.zero
            ? subItemPadding
            : siderSizing.subItemPadding,
        itemPadding: siderSizing.itemPadding == EdgeInsets.zero
            ? itemPadding
            : siderSizing.itemPadding,
        horizontalPadding: siderSizing.horizontalPadding == -1
            ? horizontalPadding
            : siderSizing.horizontalPadding,
      );
    }
  }
}
