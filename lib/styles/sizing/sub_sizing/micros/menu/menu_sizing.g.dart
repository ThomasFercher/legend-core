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
  const MenuSizingInfoNull({
    required this.spacing,
    required this.itemSpacing,
    required this.padding,
    required this.borderRadius,
    required this.height,
    required this.iconSize,
  });
}

abstract class MenuSizingInfo implements MenuSizingInfoNull {
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
  const MenuSizingInfo({
    required this.spacing,
    required this.itemSpacing,
    required this.padding,
    required this.borderRadius,
    required this.height,
    required this.iconSize,
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
  });
}

class MenuSizingStyle extends MenuSizingInfo {
  MenuSizingStyle({
    required super.spacing,
    required super.itemSpacing,
    required super.padding,
    required super.borderRadius,
    required super.height,
    required super.iconSize,
  });
  MenuSizingStyle.copy({
    required super.spacing,
    required super.itemSpacing,
    required super.padding,
    required super.borderRadius,
    required super.height,
    required super.iconSize,
  });

// **************************************************************************
// Override
// **************************************************************************
  factory MenuSizingStyle.override(
    MenuSizingStyle def,
    MenuSizingOverride? override,
  ) {
    if (override == null) {
      return def;
    }
    return MenuSizingStyle(
      spacing: override.spacing ?? def.spacing,
      itemSpacing: override.itemSpacing ?? def.itemSpacing,
      padding: override.padding ?? def.padding,
      borderRadius: override.borderRadius ?? def.borderRadius,
      height: override.height ?? def.height,
      iconSize: override.iconSize ?? def.iconSize,
    );
  }

// **************************************************************************
// Copy With
// **************************************************************************
  MenuSizingStyle copyWith({
    double? spacing,
    double? itemSpacing,
    EdgeInsetsGeometry? padding,
    BorderRadius? borderRadius,
    double? height,
    double? iconSize,
  }) {
    return MenuSizingStyle.copy(
      spacing: spacing ?? this.spacing,
      itemSpacing: itemSpacing ?? this.itemSpacing,
      padding: padding ?? this.padding,
      borderRadius: borderRadius ?? this.borderRadius,
      height: height ?? this.height,
      iconSize: iconSize ?? this.iconSize,
    );
  }
}
