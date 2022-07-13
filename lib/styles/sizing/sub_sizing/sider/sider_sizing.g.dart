// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sider_sizing.dart';

// **************************************************************************
// SubSizingGenerator
// **************************************************************************

abstract class SiderSizingInfoNull {
  final double? width;
  final double? iconSize;
  final double? spacing;
  final double? itemHeight;
  final double? subMenuHeaderHeight;
  final EdgeInsets? itemPadding;
  final EdgeInsets? subItemPadding;
  final double? horizontalPadding;
  const SiderSizingInfoNull({
    required this.width,
    required this.iconSize,
    required this.spacing,
    required this.itemHeight,
    required this.subMenuHeaderHeight,
    required this.itemPadding,
    required this.subItemPadding,
    required this.horizontalPadding,
  });
}

abstract class SiderSizingInfo implements SiderSizingInfoNull {
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
  const SiderSizingInfo({
    required this.width,
    required this.iconSize,
    required this.spacing,
    required this.itemHeight,
    required this.subMenuHeaderHeight,
    required this.itemPadding,
    required this.subItemPadding,
    required this.horizontalPadding,
  });
}

class SiderSizingComponentsInfo {
  final SideMenuSizingInfoNull? sideMenuSizing;
  SiderSizingComponentsInfo({
    this.sideMenuSizing,
  });
}

class SiderSizingComponentsOverride implements SiderSizingComponentsInfo {
  @override
  final SideMenuSizingOverride? sideMenuSizing;
  SiderSizingComponentsOverride({
    this.sideMenuSizing,
  });
}

class SiderSizingComponents implements SiderSizingComponentsInfo {
  @override
  final SideMenuSizingStyle sideMenuSizing;
  SiderSizingComponents({
    required this.sideMenuSizing,
  });
}

class SiderSizingOverride extends SiderSizingInfoNull
    implements SiderSizingComponentsOverride {
  final SiderSizingComponentsOverride Function(SiderSizingInfoNull sizing)?
      buildComponents;
  @override
  late final SideMenuSizingOverride? sideMenuSizing;
  SiderSizingOverride({
    this.buildComponents,
    super.width,
    super.iconSize,
    super.spacing,
    super.itemHeight,
    super.subMenuHeaderHeight,
    super.itemPadding,
    super.subItemPadding,
    super.horizontalPadding,
  }) {
    SiderSizingComponentsOverride? components = buildComponents?.call(this);
    sideMenuSizing = components?.sideMenuSizing;
  }
}

class SiderSizingStyle extends SiderSizingInfo
    implements SiderSizingComponents {
  final SiderSizingComponents Function(SiderSizingInfo sizing) buildComponents;
  @override
  late final SideMenuSizingStyle sideMenuSizing;
  SiderSizingStyle({
    required this.buildComponents,
    required super.width,
    required super.iconSize,
    required super.spacing,
    required super.itemHeight,
    required super.subMenuHeaderHeight,
    required super.itemPadding,
    required super.subItemPadding,
    required super.horizontalPadding,
  }) {
    SiderSizingComponents components = buildComponents.call(this);
    sideMenuSizing = components.sideMenuSizing;
  }
  factory SiderSizingStyle.override(
    SiderSizingStyle def,
    SiderSizingOverride? override,
  ) {
    if (override == null) {
      return def;
    }
    return SiderSizingStyle(
      width: override.width ?? def.width,
      iconSize: override.iconSize ?? def.iconSize,
      spacing: override.spacing ?? def.spacing,
      itemHeight: override.itemHeight ?? def.itemHeight,
      subMenuHeaderHeight:
          override.subMenuHeaderHeight ?? def.subMenuHeaderHeight,
      itemPadding: override.itemPadding ?? def.itemPadding,
      subItemPadding: override.subItemPadding ?? def.subItemPadding,
      horizontalPadding: override.horizontalPadding ?? def.horizontalPadding,
      buildComponents: (_) {
        return SiderSizingComponents(
          sideMenuSizing: SideMenuSizingStyle.override(
              def.sideMenuSizing, override.sideMenuSizing),
        );
      },
    );
  }
}
