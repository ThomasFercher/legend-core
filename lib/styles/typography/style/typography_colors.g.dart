// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'typography_colors.dart';

// **************************************************************************
// StyleGenerator
// **************************************************************************

abstract class TypographyColorsInfoNull {
  final Color? h0;
  final Color? h1;
  final Color? h2;
  final Color? h3;
  final Color? h4;
  final Color? h5;
  const TypographyColorsInfoNull({
    required this.h0,
    required this.h1,
    required this.h2,
    required this.h3,
    required this.h4,
    required this.h5,
  });
}

abstract class TypographyColorsInfo implements TypographyColorsInfoNull {
  @override
  final Color h0;
  @override
  final Color h1;
  @override
  final Color h2;
  @override
  final Color h3;
  @override
  final Color h4;
  @override
  final Color h5;
  const TypographyColorsInfo({
    required this.h0,
    required this.h1,
    required this.h2,
    required this.h3,
    required this.h4,
    required this.h5,
  });
}

class TypographyColorsOverride extends TypographyColorsInfoNull {
  TypographyColorsOverride({
    super.h0,
    super.h1,
    super.h2,
    super.h3,
    super.h4,
    super.h5,
  });
}

class TypographyColorsStyle extends TypographyColorsInfo {
  TypographyColorsStyle({
    required super.h0,
    required super.h1,
    required super.h2,
    required super.h3,
    required super.h4,
    required super.h5,
  });
  factory TypographyColorsStyle.override(
    TypographyColorsStyle def,
    TypographyColorsOverride? override,
  ) {
    if (override == null) {
      return def;
    }
    return TypographyColorsStyle(
      h0: override.h0 ?? def.h0,
      h1: override.h1 ?? def.h1,
      h2: override.h2 ?? def.h2,
      h3: override.h3 ?? def.h3,
      h4: override.h4 ?? def.h4,
      h5: override.h5 ?? def.h5,
    );
  }
}
