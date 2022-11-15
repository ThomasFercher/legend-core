// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'typography_sizing.dart';

// **************************************************************************
// StyleGenerator
// **************************************************************************

abstract class TypographySizingInfoNull {
  final double? h0;
  final double? h1;
  final double? h2;
  final double? h3;
  final double? h4;
  final double? h5;
  const TypographySizingInfoNull({
    required this.h0,
    required this.h1,
    required this.h2,
    required this.h3,
    required this.h4,
    required this.h5,
  });
}

abstract class TypographySizingInfo implements TypographySizingInfoNull {
  @override
  final double h0;
  @override
  final double h1;
  @override
  final double h2;
  @override
  final double h3;
  @override
  final double h4;
  @override
  final double h5;
  const TypographySizingInfo({
    required this.h0,
    required this.h1,
    required this.h2,
    required this.h3,
    required this.h4,
    required this.h5,
  });
}

class TypographySizingOverride extends TypographySizingInfoNull {
  TypographySizingOverride({
    super.h0,
    super.h1,
    super.h2,
    super.h3,
    super.h4,
    super.h5,
  });
}

class TypographySizingStyle extends TypographySizingInfo {
  TypographySizingStyle({
    required super.h0,
    required super.h1,
    required super.h2,
    required super.h3,
    required super.h4,
    required super.h5,
  });
  TypographySizingStyle.copy({
    required super.h0,
    required super.h1,
    required super.h2,
    required super.h3,
    required super.h4,
    required super.h5,
  });

// **************************************************************************
// Override
// **************************************************************************
  factory TypographySizingStyle.override(
    TypographySizingStyle def,
    TypographySizingOverride? override,
  ) {
    if (override == null) {
      return def;
    }
    return TypographySizingStyle(
      h0: override.h0 ?? def.h0,
      h1: override.h1 ?? def.h1,
      h2: override.h2 ?? def.h2,
      h3: override.h3 ?? def.h3,
      h4: override.h4 ?? def.h4,
      h5: override.h5 ?? def.h5,
    );
  }

// **************************************************************************
// Copy With
// **************************************************************************
  TypographySizingStyle copyWith({
    double? h0,
    double? h1,
    double? h2,
    double? h3,
    double? h4,
    double? h5,
  }) {
    return TypographySizingStyle.copy(
      h0: h0 ?? this.h0,
      h1: h1 ?? this.h1,
      h2: h2 ?? this.h2,
      h3: h3 ?? this.h3,
      h4: h4 ?? this.h4,
      h5: h5 ?? this.h5,
    );
  }
}
