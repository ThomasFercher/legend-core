import 'package:flutter/widgets.dart';
import 'package:legend_utils/functions/functions.dart';

abstract class FooterColorInfo {
  final Color? background;
  final Color? foreground;

  const FooterColorInfo({
    this.background,
    this.foreground,
  });
}

class FooterColorOverride extends FooterColorInfo {
  const FooterColorOverride({
    super.background,
    super.foreground,
  });
}

class FooterColors implements FooterColorInfo {
  @override
  final Color background;
  @override
  final Color foreground;

  factory FooterColors.override(
    FooterColors def,
    FooterColorOverride? override,
  ) {
    if (override == null) {
      return def;
    }
    return FooterColors(
      background: override.background ?? def.background,
      foreground: override.foreground ?? def.foreground,
    );
  }

  const FooterColors({
    required this.background,
    required this.foreground,
  });
}
