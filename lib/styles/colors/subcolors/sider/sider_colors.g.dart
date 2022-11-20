// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sider_colors.dart';

// **************************************************************************
// StyleGenerator
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
  final SideMenuColors menuColors;
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

class SiderColors extends SiderColorsInfo implements SiderColorsComponents {
  @override
  late final SideMenuColors menuColors;
  SiderColors({
    required SiderColorsComponents Function(SiderColorsInfo sizing)
        buildComponents,
    required super.background,
    required super.backgroundMenu,
    required super.foreground,
    required super.selection,
  }) {
    SiderColorsComponents components = buildComponents.call(this);
    menuColors = components.menuColors;
  }
  SiderColors.copy({
    required super.background,
    required super.backgroundMenu,
    required super.foreground,
    required super.selection,
    required this.menuColors,
  });

// **************************************************************************
// Override
// **************************************************************************
  factory SiderColors.override(
    SiderColors def,
    SiderColorsOverride? override,
  ) {
    if (override == null) {
      return def;
    }
    return SiderColors(
      background: override.background ?? def.background,
      backgroundMenu: override.backgroundMenu ?? def.backgroundMenu,
      foreground: override.foreground ?? def.foreground,
      selection: override.selection ?? def.selection,
      buildComponents: (_) {
        return SiderColorsComponents(
          menuColors:
              SideMenuColors.override(def.menuColors, override.menuColors),
        );
      },
    );
  }

// **************************************************************************
// Copy With
// **************************************************************************
  SiderColors copyWith({
    Color? background,
    Color? backgroundMenu,
    Color? foreground,
    Color? selection,
    SideMenuColors? menuColors,
  }) {
    return SiderColors.copy(
      background: background ?? this.background,
      backgroundMenu: backgroundMenu ?? this.backgroundMenu,
      foreground: foreground ?? this.foreground,
      selection: selection ?? this.selection,
      menuColors: menuColors ?? this.menuColors,
    );
  }
}
