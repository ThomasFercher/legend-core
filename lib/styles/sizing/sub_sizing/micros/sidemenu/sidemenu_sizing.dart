import 'package:flutter/widgets.dart';

class SideMenuSizingOverride {
  final double? spacing;
  final EdgeInsetsGeometry? padding;
  final BorderRadius? borderRadius;
  final double? itemHeight;
  final double? iconSize;

  const SideMenuSizingOverride({
    this.spacing,
    this.borderRadius,
    this.iconSize,
    this.itemHeight,
    this.padding,
  });
}

class SideMenuSizing implements SideMenuSizingOverride {
  @override
  final double spacing;
  @override
  final EdgeInsetsGeometry padding;
  @override
  final BorderRadius borderRadius;
  @override
  final double itemHeight;
  @override
  final double iconSize;

  const SideMenuSizing({
    required this.spacing,
    required this.borderRadius,
    required this.iconSize,
    required this.itemHeight,
    required this.padding,
  });

  factory SideMenuSizing.override(
    SideMenuSizing def,
    SideMenuSizingOverride? override,
  ) {
    if (override == null) {
      return def;
    }

    return SideMenuSizing(
      spacing: override.spacing ?? def.spacing,
      padding: override.padding ?? def.padding,
      borderRadius: override.borderRadius ?? def.borderRadius,
      iconSize: override.iconSize ?? def.iconSize,
      itemHeight: override.itemHeight ?? def.itemHeight,
    );
  }
}
