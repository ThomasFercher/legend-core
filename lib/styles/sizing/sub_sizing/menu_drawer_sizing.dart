import 'package:flutter/material.dart';

class MenuDrawerSizing {
  final double width;
  final double iconSize;
  final double spacing;
  final double itemHeight;
  final double subMenuHeaderHeight;
  final double subMenuIconSize;
  final EdgeInsets itemPadding;
  final EdgeInsets subItemPadding;

  MenuDrawerSizing({
    this.width = -1,
    this.iconSize = -1,
    this.spacing = -1,
    this.itemHeight = -1,
    this.subMenuHeaderHeight = -1,
    this.subMenuIconSize = -1,
    this.subItemPadding = EdgeInsets.zero,
    this.itemPadding = EdgeInsets.zero,
  });

  factory MenuDrawerSizing.from({
    required MenuDrawerSizing? sizing,
    required double width,
    required double iconSize,
    required double spacing,
    required double itemHeight,
    required double subMenuHeaderHeight,
    required double subMenuIconSize,
    required EdgeInsets itemPadding,
    required EdgeInsets subItemPadding,
  }) {
    if (sizing == null) {
      return MenuDrawerSizing(
        width: width,
        iconSize: iconSize,
        spacing: spacing,
        itemHeight: itemHeight,
        subMenuHeaderHeight: subMenuHeaderHeight,
        subMenuIconSize: subMenuIconSize,
        itemPadding: itemPadding,
        subItemPadding: subItemPadding,
      );
    } else {
      return MenuDrawerSizing(
        width: sizing.width == -1 ? width : sizing.width,
        iconSize: sizing.iconSize == -1 ? iconSize : sizing.iconSize,
        spacing: sizing.spacing == -1 ? spacing : sizing.spacing,
        itemHeight: sizing.itemHeight == -1 ? itemHeight : sizing.itemHeight,
        subMenuHeaderHeight: sizing.subMenuHeaderHeight == -1
            ? subMenuHeaderHeight
            : sizing.subMenuHeaderHeight,
        subMenuIconSize: sizing.subMenuIconSize == -1
            ? subMenuIconSize
            : sizing.subMenuIconSize,
        subItemPadding: sizing.subItemPadding == EdgeInsets.zero
            ? subItemPadding
            : sizing.subItemPadding,
        itemPadding: sizing.itemPadding == EdgeInsets.zero
            ? itemPadding
            : sizing.itemPadding,
      );
    }
  }
}
