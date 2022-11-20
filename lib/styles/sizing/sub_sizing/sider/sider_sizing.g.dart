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
  final SideMenuSizing sideMenuSizing;
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

class SiderSizing extends SiderSizingInfo implements SiderSizingComponents {
  @override
  late final SideMenuSizing sideMenuSizing;
  SiderSizing({
    required SiderSizingComponents Function(SiderSizingInfo sizing)
        buildComponents,
    required super.width,
    required super.iconSize,
    required super.spacing,
    required super.padding,
  }) {
    SiderSizingComponents components = buildComponents.call(this);
    sideMenuSizing = components.sideMenuSizing;
  }
  SiderSizing.copy({
    required super.width,
    required super.iconSize,
    required super.spacing,
    required super.padding,
    required this.sideMenuSizing,
  });

// **************************************************************************
// Override
// **************************************************************************
  factory SiderSizing.override(
    SiderSizing def,
    SiderSizingOverride? override,
  ) {
    if (override == null) {
      return def;
    }
    return SiderSizing(
      width: override.width ?? def.width,
      iconSize: override.iconSize ?? def.iconSize,
      spacing: override.spacing ?? def.spacing,
      padding: override.padding ?? def.padding,
      buildComponents: (_) {
        return SiderSizingComponents(
          sideMenuSizing: SideMenuSizing.override(
              def.sideMenuSizing, override.sideMenuSizing),
        );
      },
    );
  }

// **************************************************************************
// Copy With
// **************************************************************************
  SiderSizing copyWith({
    double? width,
    double? iconSize,
    double? spacing,
    EdgeInsetsGeometry? padding,
    SideMenuSizing? sideMenuSizing,
  }) {
    return SiderSizing.copy(
      width: width ?? this.width,
      iconSize: iconSize ?? this.iconSize,
      spacing: spacing ?? this.spacing,
      padding: padding ?? this.padding,
      sideMenuSizing: sideMenuSizing ?? this.sideMenuSizing,
    );
  }
}
