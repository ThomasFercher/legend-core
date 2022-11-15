// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'footer_sizing.dart';

// **************************************************************************
// StyleGenerator
// **************************************************************************

abstract class FooterSizingInfoNull {
  final double? height;
  final double? maxWidth;
  final EdgeInsets? padding;
  const FooterSizingInfoNull({
    required this.height,
    required this.maxWidth,
    required this.padding,
  });
}

abstract class FooterSizingInfo implements FooterSizingInfoNull {
  @override
  final double height;
  @override
  final double maxWidth;
  @override
  final EdgeInsets padding;
  const FooterSizingInfo({
    required this.height,
    required this.maxWidth,
    required this.padding,
  });
}

class FooterSizingOverride extends FooterSizingInfoNull {
  FooterSizingOverride({
    super.height,
    super.maxWidth,
    super.padding,
  });
}

class FooterSizingStyle extends FooterSizingInfo {
  FooterSizingStyle({
    required super.height,
    required super.maxWidth,
    required super.padding,
  });
  FooterSizingStyle.copy({
    required super.height,
    required super.maxWidth,
    required super.padding,
  });

// **************************************************************************
// Override
// **************************************************************************
  factory FooterSizingStyle.override(
    FooterSizingStyle def,
    FooterSizingOverride? override,
  ) {
    if (override == null) {
      return def;
    }
    return FooterSizingStyle(
      height: override.height ?? def.height,
      maxWidth: override.maxWidth ?? def.maxWidth,
      padding: override.padding ?? def.padding,
    );
  }

// **************************************************************************
// Copy With
// **************************************************************************
  FooterSizingStyle copyWith({
    double? height,
    double? maxWidth,
    EdgeInsets? padding,
  }) {
    return FooterSizingStyle.copy(
      height: height ?? this.height,
      maxWidth: maxWidth ?? this.maxWidth,
      padding: padding ?? this.padding,
    );
  }
}
