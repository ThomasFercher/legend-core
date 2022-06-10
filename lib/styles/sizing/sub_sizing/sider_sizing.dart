import 'package:flutter/widgets.dart';

abstract class SiderSizingInfo {
  final double? width;
  final double? iconSize;
  final double? spacing;
  final double? itemHeight;
  final double? subMenuHeaderHeight;
  final EdgeInsets? itemPadding;
  final EdgeInsets? subItemPadding;
  final double? horizontalPadding;

  const SiderSizingInfo({
    this.width,
    this.iconSize,
    this.spacing,
    this.itemHeight,
    this.subMenuHeaderHeight,
    this.itemPadding,
    this.subItemPadding,
    this.horizontalPadding,
  });
}

class SiderSizingOverride extends SiderSizingInfo {
  const SiderSizingOverride({
    super.width,
    super.iconSize,
    super.spacing,
    super.itemHeight,
    super.subMenuHeaderHeight,
    super.itemPadding,
    super.subItemPadding,
    super.horizontalPadding,
  });
}

class SiderSizing implements SiderSizingInfo {
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
  final EdgeInsets itemPadding;
  @override
  final EdgeInsets subItemPadding;
  @override
  final double horizontalPadding;

  const SiderSizing({
    required this.width,
    required this.iconSize,
    required this.spacing,
    required this.itemHeight,
    required this.subMenuHeaderHeight,
    required this.subItemPadding,
    required this.itemPadding,
    required this.horizontalPadding,
  });

  factory SiderSizing.override({
    required SiderSizing def,
    required SiderSizingOverride? override,
  }) {
    if (override == null) {
      return def;
    }
    return SiderSizing(
      width: override.width ?? def.width,
      iconSize: override.iconSize ?? def.iconSize,
      spacing: override.spacing ?? def.spacing,
      itemHeight: override.itemHeight ?? def.itemHeight,
      subMenuHeaderHeight:
          override.subMenuHeaderHeight ?? def.subMenuHeaderHeight,
      itemPadding: override.itemPadding ?? def.itemPadding,
      subItemPadding: override.subItemPadding ?? def.subItemPadding,
      horizontalPadding: override.horizontalPadding ?? def.horizontalPadding,
    );
  }
}
