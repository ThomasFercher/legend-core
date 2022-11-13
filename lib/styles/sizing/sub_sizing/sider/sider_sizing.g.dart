// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sider_sizing.dart';

// **************************************************************************
// StyleGenerator
// **************************************************************************

abstract class SiderSizingInfoNull {
  final double? width;
  final double? iconSize;
  final double? spacing;
  final EdgeInsetsGeometry? padding;
  const SiderSizingInfoNull({
    required this.width,
    required this.iconSize,
    required this.spacing,
    required this.padding,
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
  final EdgeInsetsGeometry padding;
  const SiderSizingInfo({
    required this.width,
    required this.iconSize,
    required this.spacing,
    required this.padding,
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
    super.padding,
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
    required super.padding,
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
      padding: override.padding ?? def.padding,
      buildComponents: (_) {
        return SiderSizingComponents(
          sideMenuSizing: SideMenuSizingStyle.override(
              def.sideMenuSizing, override.sideMenuSizing),
        );
      },
    );
  }
}
