// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tabbar_colors.dart';

// **************************************************************************
// SubSizingGenerator
// **************************************************************************

abstract class TabbarColorsInfoNull {
  final Color? background;
  const TabbarColorsInfoNull({
    required this.background,
  });
}

abstract class TabbarColorsInfo implements TabbarColorsInfoNull {
  @override
  final Color background;
  const TabbarColorsInfo({
    required this.background,
  });
}

class TabbarColorsOverride extends TabbarColorsInfoNull {
  TabbarColorsOverride({
    super.background,
  });
}

class TabbarColorsStyle extends TabbarColorsInfo {
  TabbarColorsStyle({
    required super.background,
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
    );
  }
}
