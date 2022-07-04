import 'package:flutter/material.dart';
import 'package:legend_design_core/styles/sizing/sub_sizing/menuDrawer/menu_drawer_components.dart';
import 'package:legend_design_core/styles/sizing/sub_sizing/micros/sidemenu/sidemenu_sizing.dart';

abstract class MenuDrawerSizingInfoNull {
  final double? width;
  final double? iconSize;
  final double? spacing;
  final double? itemHeight;
  final double? subMenuHeaderHeight;
  final EdgeInsets? itemPadding;
  final EdgeInsets? subItemPadding;
  final double? subMenuIconSize;

  const MenuDrawerSizingInfoNull({
    this.width,
    this.iconSize,
    this.spacing,
    this.itemHeight,
    this.subMenuHeaderHeight,
    this.itemPadding,
    this.subItemPadding,
    this.subMenuIconSize,
  });
}

abstract class MenuDrawerSizingInfo implements MenuDrawerSizingInfoNull {
  @override
  final double width;
  @override
  final double iconSize;
  @override
  final double spacing;
  @override
  final double itemHeight;
  @override
  final double subMenuHeaderHeight;
  @override
  final EdgeInsets itemPadding;
  @override
  final EdgeInsets subItemPadding;
  @override
  final double subMenuIconSize;

  const MenuDrawerSizingInfo({
    required this.width,
    required this.iconSize,
    required this.spacing,
    required this.itemHeight,
    required this.subMenuHeaderHeight,
    required this.itemPadding,
    required this.subItemPadding,
    required this.subMenuIconSize,
  });
}

class MenuDrawerSizingOverride extends MenuDrawerSizingInfoNull
    implements MenuDrawerSizingComponentsOverride {
  @override
  late final SideMenuSizingOverride? sideMenuSizing;
  final MenuDrawerSizingComponentsOverride Function(
      MenuDrawerSizingInfoNull sizing)? buildComponents;
  MenuDrawerSizingOverride({
    super.width,
    super.iconSize,
    super.spacing,
    super.itemHeight,
    super.subMenuHeaderHeight,
    super.itemPadding,
    super.subItemPadding,
    this.sideMenuSizing,
    this.buildComponents,
  }) {
    MenuDrawerSizingComponentsOverride? components =
        buildComponents?.call(this);
    sideMenuSizing = components?.sideMenuSizing;
  }
}

class MenuDrawerSizing
    implements MenuDrawerSizingInfo, MenuDrawerSizingComponents {
  @override
  final double width;
  @override
  final double iconSize;
  @override
  final double spacing;
  @override
  final double itemHeight;
  @override
  final double subMenuHeaderHeight;
  @override
  final double subMenuIconSize;
  @override
  final EdgeInsets itemPadding;
  @override
  final EdgeInsets subItemPadding;

  ///
  /// Sub
  ///
  final MenuDrawerSizingComponents Function(MenuDrawerSizingInfo sizing)
      buildComponents;
  @override
  late final SideMenuSizing sideMenuSizing;

  MenuDrawerSizing({
    required this.width,
    required this.iconSize,
    required this.spacing,
    required this.itemHeight,
    required this.subMenuHeaderHeight,
    required this.subMenuIconSize,
    required this.subItemPadding,
    required this.itemPadding,
    required this.buildComponents,
  }) {
    MenuDrawerSizingComponents sizing = buildComponents.call(this);
    sideMenuSizing = sizing.sideMenuSizing;
  }

  factory MenuDrawerSizing.override(
    MenuDrawerSizing def,
    MenuDrawerSizingOverride? override,
  ) {
    if (override == null) {
      return def;
    }
    return MenuDrawerSizing(
        width: override.width ?? def.width,
        iconSize: override.iconSize ?? def.iconSize,
        spacing: override.spacing ?? def.spacing,
        itemHeight: override.itemHeight ?? def.itemHeight,
        subMenuHeaderHeight:
            override.subMenuHeaderHeight ?? def.subMenuHeaderHeight,
        subMenuIconSize: override.subMenuIconSize ?? def.subMenuIconSize,
        itemPadding: override.itemPadding ?? def.itemPadding,
        subItemPadding: override.subItemPadding ?? def.subItemPadding,
        buildComponents: (_) {
          return MenuDrawerSizingComponents(
            sideMenuSizing: SideMenuSizing.override(
              def.sideMenuSizing,
              override.sideMenuSizing,
            ),
          );
        });
  }
}
