import 'package:flutter/widgets.dart';

abstract class SiderColorInfo {
  final Color? background;
  final Color? backgroundMenu;
  final Color? foreground;
  final Color? selection;

  const SiderColorInfo({
    this.background,
    this.backgroundMenu,
    this.foreground,
    this.selection,
  });
}

class SiderColorOverride extends SiderColorInfo {
  const SiderColorOverride({
    super.background,
    super.backgroundMenu,
    super.foreground,
    super.selection,
  });
}

class SiderColors implements SiderColorInfo {
  @override
  final Color background;
  @override
  final Color backgroundMenu;
  @override
  final Color foreground;
  @override
  final Color selection;

  const SiderColors({
    required this.background,
    required this.backgroundMenu,
    required this.foreground,
    required this.selection,
  });

  factory SiderColors.override(
    SiderColors def,
    SiderColorOverride? override,
  ) {
    if (override == null) {
      return def;
    }
    return SiderColors(
      background: override.background ?? def.background,
      backgroundMenu: override.backgroundMenu ?? def.backgroundMenu,
      foreground: override.foreground ?? def.foreground,
      selection: override.selection ?? def.selection,
    );
  }
}
