import 'package:flutter/widgets.dart';
import 'package:legend_design_core/styles/sizing/sub_sizing/micros/sidemenu/sidemenu_sizing.dart';
import 'package:legend_design_core/styles/sizing/sub_sizing/sider/sider_components.dart';

abstract class SiderSizingNotNull implements SiderSizingInfo {
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
  final double horizontalPadding;

  SiderSizingNotNull({
    required this.width,
    required this.iconSize,
    required this.spacing,
    required this.itemHeight,
    required this.subMenuHeaderHeight,
    required this.itemPadding,
    required this.subItemPadding,
    required this.horizontalPadding,
  });
}

class SiderSizingInfo {
  final double? width;
  final double? iconSize;
  final double? spacing;
  final double? itemHeight;
  final double? subMenuHeaderHeight;
  final EdgeInsets? itemPadding;
  final EdgeInsets? subItemPadding;
  final double? horizontalPadding;
  SiderSizingInfo({
    this.width,
    this.iconSize,
    this.spacing,
    this.itemHeight,
    this.subMenuHeaderHeight,
    this.itemPadding,
    this.subItemPadding,
    this.horizontalPadding,
  });
}

class SiderSizingOverride extends SiderSizingInfo
    implements SiderSizingComponentsOverride {
  final SiderSizingComponentsOverride Function(SiderSizingInfo sizing)?
      buildComponents;

  @override
  late final SideMenuSizingOverride? sideMenuSizing;

  SiderSizingOverride({
    super.width,
    super.iconSize,
    super.spacing,
    super.itemHeight,
    super.subMenuHeaderHeight,
    super.itemPadding,
    super.subItemPadding,
    super.horizontalPadding,
    this.buildComponents,
  }) {
    SiderSizingComponentsOverride? components = buildComponents?.call(this);
    sideMenuSizing = components?.sideMenuSizing;
  }
}

class SiderSizing implements SiderSizingNotNull, SiderSizingComponentsOverride {
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
  final double horizontalPadding;

  ///
  /// Sub
  ///
  final SiderSizingComponents Function(SiderSizingNotNull sizing)
      buildComponents;
  @override
  late final SideMenuSizing sideMenuSizing;

  SiderSizing({
    required this.width,
    required this.iconSize,
    required this.spacing,
    required this.itemHeight,
    required this.subMenuHeaderHeight,
    required this.subItemPadding,
    required this.itemPadding,
    required this.horizontalPadding,
    required this.buildComponents,
  }) {
    SiderSizingComponents components = buildComponents.call(this);
    sideMenuSizing = components.sideMenuSizing;
  }

  factory SiderSizing.override(
    SiderSizing def,
    SiderSizingOverride? override,
  ) {
    if (override == null) {
      return def;
    }
    return SiderSizing(
        width: override.width ?? def.width,
        iconSize: override.iconSize ?? def.iconSize,
        spacing: override.spacing ?? def.spacing,
        itemHeight: override.itemHeight ?? def.itemHeight,
        subMenuHeaderHeight:
            override.subMenuHeaderHeight ?? def.subMenuHeaderHeight,
        itemPadding: override.itemPadding ?? def.itemPadding,
        subItemPadding: override.subItemPadding ?? def.subItemPadding,
        horizontalPadding: override.horizontalPadding ?? def.horizontalPadding,
        buildComponents: (_) {
          return SiderSizingComponents(
              sideMenuSizing: SideMenuSizing.override(
            def.sideMenuSizing,
            override.sideMenuSizing,
          ));
        });
  }
}
