import 'package:flutter/widgets.dart';

abstract class FixedFooterSizingInfo {
  final double? height;
  final double? maxWidth;
  final EdgeInsets? padding;

  const FixedFooterSizingInfo({
    this.height,
    this.maxWidth,
    this.padding,
  });
}

class FixedFooterSizingOverride extends FixedFooterSizingInfo {
  const FixedFooterSizingOverride({
    super.height,
    super.maxWidth,
    super.padding,
  });
}

class FixedFooterSizing implements FixedFooterSizingInfo {
  @override
  final double height;
  @override
  final double maxWidth;
  @override
  final EdgeInsets padding;

  const FixedFooterSizing({
    required this.height,
    required this.maxWidth,
    required this.padding,
  });

  factory FixedFooterSizing.override(
    FixedFooterSizing def,
    FixedFooterSizingOverride? override,
  ) {
    if (override == null) {
      return def;
    }
    return FixedFooterSizing(
      height: override.height ?? def.height,
      maxWidth: override.maxWidth ?? def.maxWidth,
      padding: override.padding ?? def.padding,
    );
  }
}
