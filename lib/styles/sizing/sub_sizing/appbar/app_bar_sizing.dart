import 'package:flutter/widgets.dart';
import 'package:legend_design_core/styles/sizing/sub_sizing/appbar/app_bar_components.dart';
import 'package:legend_design_core/styles/sizing/sub_sizing/micros/menu/menu_sizing.dart';

abstract class AppBarSizingInfo implements AppBarSizingInfoNull {
  @override
  final EdgeInsets contentPadding;

  @override
  final double logoSize;
  @override
  final bool pinned;
  @override
  final bool floating;
  @override
  final double spacing;
  @override
  final double appBarHeight;
  @override
  final double iconSize;

  const AppBarSizingInfo({
    required this.contentPadding,
    required this.logoSize,
    required this.pinned,
    required this.floating,
    required this.spacing,
    required this.appBarHeight,
    required this.iconSize,
  });
}

abstract class AppBarSizingInfoNull {
  final EdgeInsets? contentPadding;

  final double? logoSize;
  final bool? pinned;
  final bool? floating;
  final double? spacing;
  final double? appBarHeight;
  final double? iconSize;

  const AppBarSizingInfoNull({
    this.contentPadding,
    this.logoSize,
    this.pinned,
    this.floating,
    this.spacing,
    this.appBarHeight,
    this.iconSize,
  });
}

class AppBarSizingOverride extends AppBarSizingInfoNull
    implements AppBarSizingComponentsOverride {
  @override
  late final MenuSizingOverride? menuSizing;
  final AppBarSizingComponentsOverride Function(AppBarSizingInfoNull sizing)?
      buildComponents;

  AppBarSizingOverride({
    super.contentPadding,
    super.logoSize,
    super.pinned,
    super.floating,
    super.spacing,
    super.appBarHeight,
    super.iconSize,
    this.buildComponents,
  }) {
    AppBarSizingComponentsOverride? components = buildComponents?.call(this);
    menuSizing = components?.menuSizing;
  }
}

class AppBarSizing implements AppBarSizingInfo, AppBarSizingComponents {
  @override
  final EdgeInsets contentPadding;
  @override
  final double logoSize;
  @override
  late final bool pinned;
  @override
  late final bool floating;
  @override
  final double spacing;
  @override
  final double appBarHeight;
  @override
  final double iconSize;

  ///
  /// Sub
  ///
  final AppBarSizingComponents Function(AppBarSizingInfo sizing)
      buildComponents;
  @override
  late final MenuSizing menuSizing;

  AppBarSizing({
    required this.appBarHeight,
    required this.contentPadding,
    required this.iconSize,
    required this.spacing,
    required this.logoSize,
    required this.buildComponents,
    bool? pinned,
    bool? floating,
  }) {
    AppBarSizingComponents components = buildComponents.call(this);
    menuSizing = components.menuSizing;

    this.floating = floating ?? false;

    if (this.floating) {
      this.pinned = false;
    } else {
      this.pinned = pinned ?? true;
    }
  }

  factory AppBarSizing.override(
    AppBarSizing def,
    AppBarSizingOverride? override,
  ) {
    if (override == null) {
      return def;
    }

    return AppBarSizing(
      appBarHeight: override.appBarHeight ?? def.appBarHeight,
      contentPadding: override.contentPadding ?? def.contentPadding,
      floating: override.floating ?? def.floating,
      iconSize: override.iconSize ?? def.iconSize,
      logoSize: override.logoSize ?? def.logoSize,
      pinned: override.pinned ?? def.pinned,
      spacing: override.spacing ?? def.spacing,
      buildComponents: (AppBarSizingInfo sizing) {
        return AppBarSizingComponents(
          menuSizing: MenuSizing.override(def.menuSizing, override.menuSizing),
        );
      },
    );
  }
}
