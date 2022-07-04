import 'package:flutter/widgets.dart';
import 'package:legend_design_core/styles/colors/subcolors/micros/sidemenu/sidemenu_colors.dart';
import 'package:legend_design_core/styles/colors/subcolors/sider/sider_color_components.dart';

abstract class SiderColorInfo implements SiderColorInfoNull {
  @override
  final Color background;
  @override
  final Color backgroundMenu;
  @override
  final Color foreground;
  @override
  final Color selection;

  const SiderColorInfo({
    required this.background,
    required this.backgroundMenu,
    required this.foreground,
    required this.selection,
  });
}

abstract class SiderColorInfoNull {
  final Color? background;
  final Color? backgroundMenu;
  final Color? foreground;
  final Color? selection;

  const SiderColorInfoNull({
    this.background,
    this.backgroundMenu,
    this.foreground,
    this.selection,
  });
}

class SiderColorOverride extends SiderColorInfoNull
    implements SiderColorComponentsOverride {
  @override
  late final SideMenuColorsOverride? sideMenuColors;

  final SiderColorComponentsOverride Function(SiderColorInfoNull colors)?
      buildComponents;

  SiderColorOverride({
    super.background,
    super.backgroundMenu,
    super.foreground,
    super.selection,
    this.buildComponents,
  }) {
    SiderColorComponentsOverride? components = buildComponents?.call(this);
    sideMenuColors = components?.sideMenuColors;
  }
}

class SiderColors implements SiderColorInfo, SiderColorComponents {
  @override
  final Color background;
  @override
  final Color backgroundMenu;
  @override
  final Color foreground;
  @override
  final Color selection;

  @override
  late final SideMenuColors sideMenuColors;

  final SiderColorComponents Function(SiderColorInfo colors) buildComponents;

  SiderColors({
    required this.background,
    required this.backgroundMenu,
    required this.foreground,
    required this.selection,
    required this.buildComponents,
  }) {
    SiderColorComponents components = buildComponents.call(this);
    sideMenuColors = components.sideMenuColors;
  }

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
        buildComponents: (_) {
          return SiderColorComponents(
            sideMenuColors: SideMenuColors.override(
              def.sideMenuColors,
              override.sideMenuColors,
            ),
          );
        });
  }
}
