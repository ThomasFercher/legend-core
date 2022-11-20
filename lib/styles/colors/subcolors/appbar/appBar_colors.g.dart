// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'appBar_colors.dart';

// **************************************************************************
// StyleGenerator
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
  final TabbarColorsInfoNull? tabbarColors;
  AppBarColorsComponentsInfo({
    this.menuColors,
    this.subMenuColors,
    this.tabbarColors,
  });
}

class AppBarColorsComponentsOverride implements AppBarColorsComponentsInfo {
  @override
  final MenuColorsOverride? menuColors;
  @override
  final SideMenuColorsOverride? subMenuColors;
  @override
  final TabbarColorsOverride? tabbarColors;
  AppBarColorsComponentsOverride({
    this.menuColors,
    this.subMenuColors,
    this.tabbarColors,
  });
}

class AppBarColorsComponents implements AppBarColorsComponentsInfo {
  @override
  final MenuColors menuColors;
  @override
  final SideMenuColors subMenuColors;
  @override
  final TabbarColors? tabbarColors;
  AppBarColorsComponents({
    required this.menuColors,
    required this.subMenuColors,
    this.tabbarColors,
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
  @override
  late final TabbarColorsOverride? tabbarColors;
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
    tabbarColors = components?.tabbarColors;
  }
}

class AppBarColors extends AppBarColorsInfo implements AppBarColorsComponents {
  @override
  late final MenuColors menuColors;
  @override
  late final SideMenuColors subMenuColors;
  @override
  late final TabbarColors? tabbarColors;
  AppBarColors({
    required AppBarColorsComponents Function(AppBarColorsInfo sizing)
        buildComponents,
    required super.background,
    required super.icon,
    required super.selected,
    required super.foreground,
  }) {
    AppBarColorsComponents components = buildComponents.call(this);
    menuColors = components.menuColors;
    subMenuColors = components.subMenuColors;
    tabbarColors = components.tabbarColors;
  }
  AppBarColors.copy({
    required super.background,
    required super.icon,
    required super.selected,
    required super.foreground,
    required this.menuColors,
    required this.subMenuColors,
    this.tabbarColors,
  });

// **************************************************************************
// Override
// **************************************************************************
  factory AppBarColors.override(
    AppBarColors def,
    AppBarColorsOverride? override,
  ) {
    if (override == null) {
      return def;
    }
    return AppBarColors(
      background: override.background ?? def.background,
      icon: override.icon ?? def.icon,
      selected: override.selected ?? def.selected,
      foreground: override.foreground ?? def.foreground,
      buildComponents: (_) {
        return AppBarColorsComponents(
          menuColors: MenuColors.override(def.menuColors, override.menuColors),
          subMenuColors: SideMenuColors.override(
              def.subMenuColors, override.subMenuColors),
          tabbarColors: def.tabbarColors == null
              ? null
              : TabbarColors.override(def.tabbarColors!, override.tabbarColors),
        );
      },
    );
  }

// **************************************************************************
// Copy With
// **************************************************************************
  AppBarColors copyWith({
    Color? background,
    Color? icon,
    Color? selected,
    Color? foreground,
    MenuColors? menuColors,
    SideMenuColors? subMenuColors,
    TabbarColors? tabbarColors,
  }) {
    return AppBarColors.copy(
      background: background ?? this.background,
      icon: icon ?? this.icon,
      selected: selected ?? this.selected,
      foreground: foreground ?? this.foreground,
      menuColors: menuColors ?? this.menuColors,
      subMenuColors: subMenuColors ?? this.subMenuColors,
      tabbarColors: tabbarColors ?? this.tabbarColors,
    );
  }
}
