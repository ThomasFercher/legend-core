// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'footer_sizing.dart';

// **************************************************************************
// StyleGenerator
// **************************************************************************

abstract class FooterSizingInfoNull {
  final double? maxWidth;
  final EdgeInsets? padding;
  const FooterSizingInfoNull({
    required this.maxWidth,
    required this.padding,
  });
}

abstract class FooterSizingInfo implements FooterSizingInfoNull {
  @override
  final double maxWidth;
  @override
  final EdgeInsets padding;
  const FooterSizingInfo({
    required this.maxWidth,
    required this.padding,
  });
}

class FooterSizingOverride extends FooterSizingInfoNull {
  FooterSizingOverride({
    super.maxWidth,
    super.padding,
  });
}

class FooterSizing extends FooterSizingInfo {
  FooterSizing({
    required super.maxWidth,
    required super.padding,
  });
  FooterSizing.copy({
    required super.maxWidth,
    required super.padding,
  });

// **************************************************************************
// Override
// **************************************************************************
  factory FooterSizing.override(
    FooterSizing def,
    FooterSizingOverride? override,
  ) {
    if (override == null) {
      return def;
    }
    return FooterSizing(
      maxWidth: override.maxWidth ?? def.maxWidth,
      padding: override.padding ?? def.padding,
    );
  }

// **************************************************************************
// Copy With
// **************************************************************************
  FooterSizing copyWith({
    double? maxWidth,
    EdgeInsets? padding,
  }) {
    return FooterSizing.copy(
      maxWidth: maxWidth ?? this.maxWidth,
      padding: padding ?? this.padding,
    );
  }
}
