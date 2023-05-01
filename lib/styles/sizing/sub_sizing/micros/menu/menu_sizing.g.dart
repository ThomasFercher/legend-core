// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'menu_sizing.dart';

// **************************************************************************
// StyleGenerator
// **************************************************************************

abstract class MenuSizingInfoNull {
  final double? spacing;
  final double? itemSpacing;
  final EdgeInsetsGeometry? padding;
  final BorderRadius? borderRadius;
  final double? height;
  final double? iconSize;
  final BoxShadow? shadow;
  final BoxBorder? border;
  const MenuSizingInfoNull({
    required this.spacing,
    required this.itemSpacing,
    this.padding,
    this.borderRadius,
    required this.height,
    required this.iconSize,
    this.shadow,
    this.border,
  });
}

abstract class MenuSizingInfo implements MenuSizingInfoNull {
  @override
  final double spacing;
  @override
  final double itemSpacing;
  @override
  final EdgeInsetsGeometry? padding;
  @override
  final BorderRadius? borderRadius;
  @override
  final double height;
  @override
  final double iconSize;
  @override
  final BoxShadow? shadow;
  @override
  final BoxBorder? border;
  const MenuSizingInfo({
    required this.spacing,
    required this.itemSpacing,
    this.padding,
    this.borderRadius,
    required this.height,
    required this.iconSize,
    this.shadow,
    this.border,
  });
}

class MenuSizingOverride extends MenuSizingInfoNull {
  MenuSizingOverride({
    super.spacing,
    super.itemSpacing,
    super.padding,
    super.borderRadius,
    super.height,
    super.iconSize,
    super.shadow,
    super.border,
  });
}

class MenuSizing extends MenuSizingInfo {
  MenuSizing({
    required super.spacing,
    required super.itemSpacing,
    super.padding,
    super.borderRadius,
    required super.height,
    required super.iconSize,
    super.shadow,
    super.border,
  });
  MenuSizing.copy({
    required super.spacing,
    required super.itemSpacing,
    super.padding,
    super.borderRadius,
    required super.height,
    required super.iconSize,
    super.shadow,
    super.border,
  });

// **************************************************************************
// Override
// **************************************************************************
  factory MenuSizing.override(
    MenuSizing def,
    MenuSizingOverride? override,
  ) {
    if (override == null) {
      return def;
    }
    return MenuSizing(
      spacing: override.spacing ?? def.spacing,
      itemSpacing: override.itemSpacing ?? def.itemSpacing,
      padding: override.padding ?? def.padding,
      borderRadius: override.borderRadius ?? def.borderRadius,
      height: override.height ?? def.height,
      iconSize: override.iconSize ?? def.iconSize,
      shadow: override.shadow ?? def.shadow,
      border: override.border ?? def.border,
    );
  }

// **************************************************************************
// Copy With
// **************************************************************************
  MenuSizing copyWith({
    double? spacing,
    double? itemSpacing,
    EdgeInsetsGeometry? padding,
    BorderRadius? borderRadius,
    double? height,
    double? iconSize,
    BoxShadow? shadow,
    BoxBorder? border,
  }) {
    return MenuSizing.copy(
      spacing: spacing ?? this.spacing,
      itemSpacing: itemSpacing ?? this.itemSpacing,
      padding: padding ?? this.padding,
      borderRadius: borderRadius ?? this.borderRadius,
      height: height ?? this.height,
      iconSize: iconSize ?? this.iconSize,
      shadow: shadow ?? this.shadow,
      border: border ?? this.border,
    );
  }
}
