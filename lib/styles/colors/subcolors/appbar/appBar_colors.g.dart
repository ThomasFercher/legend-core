// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'appBar_colors.dart';

// **************************************************************************
// SubSizingGenerator
// **************************************************************************

abstract class AppBarColorsInfoNull {
  final Color? background;
  final Color? icon;
  final Color? selected;
  final Color? foreground;
  const AppBarColorsInfoNull({
    required this.background,
    required this.icon,
    required this.selected,
    required this.foreground,
  });
}

abstract class AppBarColorsInfo implements AppBarColorsInfoNull {
  @override
  final Color background;
  @override
  final Color icon;
  @override
  final Color selected;
  @override
  final Color foreground;
  const AppBarColorsInfo({
    required this.background,
    required this.icon,
    required this.selected,
    required this.foreground,
  });
}

class AppBarColorsComponentsInfo {
  final MenuColorsInfoNull? menuColors;
  final SideMenuColorsInfoNull? subMenuColors;
  AppBarColorsComponentsInfo({
    this.menuColors,
    this.subMenuColors,
  });
}

class AppBarColorsComponentsOverride implements AppBarColorsComponentsInfo {
  @override
  final MenuColorsOverride? menuColors;
  @override
  final SideMenuColorsOverride? subMenuColors;
  AppBarColorsComponentsOverride({
    this.menuColors,
    this.subMenuColors,
  });
}

class AppBarColorsComponents implements AppBarColorsComponentsInfo {
  @override
  final MenuColorsStyle menuColors;
  @override
  final SideMenuColorsStyle subMenuColors;
  AppBarColorsComponents({
    required this.menuColors,
    required this.subMenuColors,
  });
}

class AppBarColorsOverride extends AppBarColorsInfoNull
    implements AppBarColorsComponentsOverride {
  final AppBarColorsComponentsOverride Function(AppBarColorsInfoNull sizing)?
      buildComponents;
  @override
  late final MenuColorsOverride? menuColors;
  @override
  late final SideMenuColorsOverride? subMenuColors;
  AppBarColorsOverride({
    this.buildComponents,
    super.background,
    super.icon,
    super.selected,
    super.foreground,
  }) {
    AppBarColorsComponentsOverride? components = buildComponents?.call(this);
    menuColors = components?.menuColors;
    subMenuColors = components?.subMenuColors;
  }
}

class AppBarColorsStyle extends AppBarColorsInfo
    implements AppBarColorsComponents {
  final AppBarColorsComponents Function(AppBarColorsInfo sizing)
      buildComponents;
  @override
  late final MenuColorsStyle menuColors;
  @override
  late final SideMenuColorsStyle subMenuColors;
  AppBarColorsStyle({
    required this.buildComponents,
    required super.background,
    required super.icon,
    required super.selected,
    required super.foreground,
  }) {
    AppBarColorsComponents components = buildComponents.call(this);
    menuColors = components.menuColors;
    subMenuColors = components.subMenuColors;
  }
  factory AppBarColorsStyle.override(
    AppBarColorsStyle def,
    AppBarColorsOverride? override,
  ) {
    if (override == null) {
      return def;
    }
    return AppBarColorsStyle(
      background: override.background ?? def.background,
      icon: override.icon ?? def.icon,
      selected: override.selected ?? def.selected,
      foreground: override.foreground ?? def.foreground,
      buildComponents: (_) {
        return AppBarColorsComponents(
          menuColors:
              MenuColorsStyle.override(def.menuColors, override.menuColors),
          subMenuColors: SideMenuColorsStyle.override(
              def.subMenuColors, override.subMenuColors),
        );
      },
    );
  }
}
