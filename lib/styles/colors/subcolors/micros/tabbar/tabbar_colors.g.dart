// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tabbar_colors.dart';

// **************************************************************************
// StyleGenerator
// **************************************************************************

abstract class TabbarColorsInfoNull {
  final Color? background;
  final Color? foreground;
  final Color? selection;
  final Color? disabled;
  const TabbarColorsInfoNull({
    required this.background,
    required this.foreground,
    required this.selection,
    required this.disabled,
  });
}

abstract class TabbarColorsInfo implements TabbarColorsInfoNull {
  @override
  final Color background;
  @override
  final Color foreground;
  @override
  final Color selection;
  @override
  final Color disabled;
  const TabbarColorsInfo({
    required this.background,
    required this.foreground,
    required this.selection,
    required this.disabled,
  });
}

class TabbarColorsOverride extends TabbarColorsInfoNull {
  TabbarColorsOverride({
    super.background,
    super.foreground,
    super.selection,
    super.disabled,
  });
}

class TabbarColorsStyle extends TabbarColorsInfo {
  TabbarColorsStyle({
    required super.background,
    required super.foreground,
    required super.selection,
    required super.disabled,
  });
  factory TabbarColorsStyle.override(
    TabbarColorsStyle def,
    TabbarColorsOverride? override,
  ) {
    if (override == null) {
      return def;
    }
    return TabbarColorsStyle(
      background: override.background ?? def.background,
      foreground: override.foreground ?? def.foreground,
      selection: override.selection ?? def.selection,
      disabled: override.disabled ?? def.disabled,
    );
  }
}
