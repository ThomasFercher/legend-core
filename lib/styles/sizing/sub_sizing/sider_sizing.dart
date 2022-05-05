import 'package:flutter/widgets.dart';
import 'package:legend_design_core/layout/fixed/sider/normal/legend_sider.dart';

class SiderSizing {
  final double width;
  final double iconSize;
  final double spacing;
  final double itemHeight;
  final double subMenuHeaderHeight;
  final EdgeInsets itemPadding;
  final EdgeInsets subItemPadding;

  SiderSizing({
    this.width = -1,
    this.iconSize = -1,
    this.spacing = -1,
    this.itemHeight = -1,
    this.subMenuHeaderHeight = -1,
    this.subItemPadding = EdgeInsets.zero,
    this.itemPadding = EdgeInsets.zero,
  });

  factory SiderSizing.from({
    required SiderSizing? siderSizing,
    required double width,
    required double iconSize,
    required double spacing,
    required double itemHeight,
    required double subMenuHeaderHeight,
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
      );
    }
  }
}
