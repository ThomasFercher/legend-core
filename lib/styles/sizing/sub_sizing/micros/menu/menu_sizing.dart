import 'package:flutter/widgets.dart';

class MenuSizingOverride {
  final double? spacing;
  final double? itemSpacing;

  final EdgeInsetsGeometry? padding;
  final BorderRadius? borderRadius;
  final double? height;
  final double? iconSize;

  const MenuSizingOverride({
    this.spacing,
    this.borderRadius,
    this.iconSize,
    this.height,
    this.padding,
    this.itemSpacing,
  });
}

class MenuSizing implements MenuSizingOverride {
  @override
  final double spacing;
  @override
  final double itemSpacing;
  @override
  final EdgeInsetsGeometry padding;
  @override
  final BorderRadius borderRadius;
  @override
  final double height;
  @override
  final double iconSize;

  const MenuSizing({
    required this.spacing,
    required this.borderRadius,
    required this.iconSize,
    required this.height,
    required this.padding,
    required this.itemSpacing,
  });

  factory MenuSizing.override(
    MenuSizing def,
    MenuSizingOverride? override,
  ) {
    if (override == null) {
      return def;
    }

    return MenuSizing(
      spacing: override.spacing ?? def.spacing,
      padding: override.padding ?? def.padding,
      borderRadius: override.borderRadius ?? def.borderRadius,
      iconSize: override.iconSize ?? def.iconSize,
      height: override.height ?? def.height,
      itemSpacing: override.itemSpacing ?? def.itemSpacing,
    );
  }
}
