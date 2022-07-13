// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sidemenu_sizing.dart';

// **************************************************************************
// SubSizingGenerator
// **************************************************************************

abstract class SideMenuSizingInfoNull {
  final double? spacing;
  final EdgeInsetsGeometry? padding;
  final BorderRadius? borderRadius;
  final double? itemHeight;
  final double? iconSize;
  const SideMenuSizingInfoNull({
    required this.spacing,
    required this.padding,
    required this.borderRadius,
    required this.itemHeight,
    required this.iconSize,
  });
}

abstract class SideMenuSizingInfo implements SideMenuSizingInfoNull {
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
  const SideMenuSizingInfo({
    required this.spacing,
    required this.padding,
    required this.borderRadius,
    required this.itemHeight,
    required this.iconSize,
  });
}

class SideMenuSizingOverride extends SideMenuSizingInfoNull {
  SideMenuSizingOverride({
    super.spacing,
    super.padding,
    super.borderRadius,
    super.itemHeight,
    super.iconSize,
  });
}

class SideMenuSizingStyle extends SideMenuSizingInfo {
  SideMenuSizingStyle({
    required super.spacing,
    required super.padding,
    required super.borderRadius,
    required super.itemHeight,
    required super.iconSize,
  });
  factory SideMenuSizingStyle.override(
    SideMenuSizingStyle def,
    SideMenuSizingOverride? override,
  ) {
    if (override == null) {
      return def;
    }
    return SideMenuSizingStyle(
      spacing: override.spacing ?? def.spacing,
      padding: override.padding ?? def.padding,
      borderRadius: override.borderRadius ?? def.borderRadius,
      itemHeight: override.itemHeight ?? def.itemHeight,
      iconSize: override.iconSize ?? def.iconSize,
    );
  }
}
