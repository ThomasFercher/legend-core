// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'footer_colors.dart';

// **************************************************************************
// StyleGenerator
// **************************************************************************

abstract class FooterColorsInfoNull {
  final Color? background;
  final Color? foreground;
  const FooterColorsInfoNull({
    required this.background,
    required this.foreground,
  });
}

abstract class FooterColorsInfo implements FooterColorsInfoNull {
  @override
  final Color background;
  @override
  final Color foreground;
  const FooterColorsInfo({
    required this.background,
    required this.foreground,
  });
}

class FooterColorsOverride extends FooterColorsInfoNull {
  FooterColorsOverride({
    super.background,
    super.foreground,
  });
}

class FooterColorsStyle extends FooterColorsInfo {
  FooterColorsStyle({
    required super.background,
    required super.foreground,
  });
  factory FooterColorsStyle.override(
    FooterColorsStyle def,
    FooterColorsOverride? override,
  ) {
    if (override == null) {
      return def;
    }
    return FooterColorsStyle(
      background: override.background ?? def.background,
      foreground: override.foreground ?? def.foreground,
    );
  }
}
