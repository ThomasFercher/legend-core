// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sider_colors.dart';

// **************************************************************************
// SubSizingGenerator
// **************************************************************************

abstract class SiderColorsInfoNull {
  final Color? background;
  final Color? backgroundMenu;
  final Color? foreground;
  final Color? selection;
  const SiderColorsInfoNull({
    required this.background,
    required this.backgroundMenu,
    required this.foreground,
    required this.selection,
  });
}

abstract class SiderColorsInfo implements SiderColorsInfoNull {
  @override
  final Color background;
  @override
  final Color backgroundMenu;
  @override
  final Color foreground;
  @override
  final Color selection;
  const SiderColorsInfo({
    required this.background,
    required this.backgroundMenu,
    required this.foreground,
    required this.selection,
  });
}

class SiderColorsComponentsInfo {
  final SideMenuColorsInfoNull? menuColors;
  SiderColorsComponentsInfo({
    this.menuColors,
  });
}

class SiderColorsComponentsOverride implements SiderColorsComponentsInfo {
  @override
  final SideMenuColorsOverride? menuColors;
  SiderColorsComponentsOverride({
    this.menuColors,
  });
}

class SiderColorsComponents implements SiderColorsComponentsInfo {
  @override
  final SideMenuColorsStyle menuColors;
  SiderColorsComponents({
    required this.menuColors,
  });
}

class SiderColorsOverride extends SiderColorsInfoNull
    implements SiderColorsComponentsOverride {
  final SiderColorsComponentsOverride Function(SiderColorsInfoNull sizing)?
      buildComponents;
  @override
  late final SideMenuColorsOverride? menuColors;
  SiderColorsOverride({
    this.buildComponents,
    super.background,
    super.backgroundMenu,
    super.foreground,
    super.selection,
  }) {
    SiderColorsComponentsOverride? components = buildComponents?.call(this);
    menuColors = components?.menuColors;
  }
}

class SiderColorsStyle extends SiderColorsInfo
    implements SiderColorsComponents {
  final SiderColorsComponents Function(SiderColorsInfo sizing) buildComponents;
  @override
  late final SideMenuColorsStyle menuColors;
  SiderColorsStyle({
    required this.buildComponents,
    required super.background,
    required super.backgroundMenu,
    required super.foreground,
    required super.selection,
  }) {
    SiderColorsComponents components = buildComponents.call(this);
    menuColors = components.menuColors;
  }
  factory SiderColorsStyle.override(
    SiderColorsStyle def,
    SiderColorsOverride? override,
  ) {
    if (override == null) {
      return def;
    }
    return SiderColorsStyle(
      background: override.background ?? def.background,
      backgroundMenu: override.backgroundMenu ?? def.backgroundMenu,
      foreground: override.foreground ?? def.foreground,
      selection: override.selection ?? def.selection,
      buildComponents: (_) {
        return SiderColorsComponents(
          menuColors:
              SideMenuColorsStyle.override(def.menuColors, override.menuColors),
        );
      },
    );
  }
}
