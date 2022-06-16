import 'package:flutter/widgets.dart';

abstract class AbbBarSizingInfo {
  final Radius? borderRadius;
  final EdgeInsets? contentPadding;
  final ShapeBorder? shape;
  final double? logoSize;
  final bool? pinned;
  final bool? floating;
  final double? spacing;
  final double? appBarHeight;
  final double? iconSize;

  const AbbBarSizingInfo({
    this.borderRadius,
    this.contentPadding,
    this.shape,
    this.logoSize,
    this.pinned,
    this.floating,
    this.spacing,
    this.appBarHeight,
    this.iconSize,
  });
}

class AbbBarSizingOverride extends AbbBarSizingInfo {
  const AbbBarSizingOverride({
    super.borderRadius,
    super.contentPadding,
    super.shape,
    super.logoSize,
    super.pinned,
    super.floating,
    super.spacing,
    super.appBarHeight,
    super.iconSize,
  });
}

class AppBarSizing implements AbbBarSizingInfo {
  @override
  final Radius? borderRadius;
  @override
  final EdgeInsets contentPadding;
  @override
  final ShapeBorder? shape;
  @override
  final double logoSize;
  @override
  late final bool pinned;
  @override
  late final bool floating;
  @override
  final double? spacing;
  @override
  final double appBarHeight;
  @override
  final double iconSize;

  AppBarSizing({
    required this.appBarHeight,
    this.borderRadius,
    required this.contentPadding,
    this.shape,
    bool? pinned,
    bool? floating,
    required this.iconSize,
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

  factory AppBarSizing.override(
    AppBarSizing def,
    AbbBarSizingOverride? override,
  ) {
    if (override == null) {
      return def;
    }

    return AppBarSizing(
      appBarHeight: override.appBarHeight ?? def.appBarHeight,
      borderRadius: override.borderRadius ?? def.borderRadius,
      contentPadding: override.contentPadding ?? def.contentPadding,
      floating: override.floating ?? def.floating,
      iconSize: override.iconSize ?? def.iconSize,
      logoSize: override.logoSize ?? def.logoSize,
      pinned: override.pinned ?? def.pinned,
      shape: override.shape ?? def.shape,
      spacing: override.spacing ?? def.spacing,
    );
  }
}
