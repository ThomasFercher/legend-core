import 'package:flutter/material.dart';

abstract class MenuDrawerSizingInfo {
  final double? width;
  final double? iconSize;
  final double? spacing;
  final double? itemHeight;
  final double? subMenuHeaderHeight;
  final EdgeInsets? itemPadding;
  final EdgeInsets? subItemPadding;
  final double? subMenuIconSize;

  const MenuDrawerSizingInfo({
    this.width,
    this.iconSize,
    this.spacing,
    this.itemHeight,
    this.subMenuHeaderHeight,
    this.itemPadding,
    this.subItemPadding,
    this.subMenuIconSize,
  });
}

class MenuDrawerSizingOverride extends MenuDrawerSizingInfo {
  const MenuDrawerSizingOverride({
    super.width,
    super.iconSize,
    super.spacing,
    super.itemHeight,
    super.subMenuHeaderHeight,
    super.itemPadding,
    super.subItemPadding,
  });
}

class MenuDrawerSizing implements MenuDrawerSizingInfo {
  @override
  final double width;
  @override
  final double iconSize;
  @override
  final double spacing;
  @override
  final double itemHeight;
  @override
  final double subMenuHeaderHeight;

  @override
  final double subMenuIconSize;
  @override
  final EdgeInsets itemPadding;
  @override
  final EdgeInsets subItemPadding;

  const MenuDrawerSizing({
    required this.width,
    required this.iconSize,
    required this.spacing,
    required this.itemHeight,
    required this.subMenuHeaderHeight,
    required this.subMenuIconSize,
    required this.subItemPadding,
    required this.itemPadding,
  });

  factory MenuDrawerSizing.override(
    MenuDrawerSizing def,
    MenuDrawerSizingOverride? override,
  ) {
    if (override == null) {
      return def;
    }
    return MenuDrawerSizing(
      width: override.width ?? def.width,
      iconSize: override.iconSize ?? def.iconSize,
      spacing: override.spacing ?? def.spacing,
      itemHeight: override.itemHeight ?? def.itemHeight,
      subMenuHeaderHeight:
          override.subMenuHeaderHeight ?? def.subMenuHeaderHeight,
      subMenuIconSize: override.subMenuIconSize ?? def.subMenuIconSize,
      itemPadding: override.itemPadding ?? def.itemPadding,
      subItemPadding: override.subItemPadding ?? def.subItemPadding,
    );
  }
}
