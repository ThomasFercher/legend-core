// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'menuDrawer_sizing.dart';

// **************************************************************************
// StyleGenerator
// **************************************************************************

abstract class MenuDrawerSizingInfoNull {
  final double? width;
  final double? iconSize;
  final double? spacing;
  final double? itemHeight;
  final double? subMenuHeaderHeight;
  final double? subMenuIconSize;
  final EdgeInsets? itemPadding;
  final EdgeInsets? subItemPadding;
  const MenuDrawerSizingInfoNull({
    required this.width,
    required this.iconSize,
    required this.spacing,
    required this.itemHeight,
    required this.subMenuHeaderHeight,
    required this.subMenuIconSize,
    required this.itemPadding,
    required this.subItemPadding,
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
  final double subMenuIconSize;
  @override
  final EdgeInsets itemPadding;
  @override
  final EdgeInsets subItemPadding;
  const MenuDrawerSizingInfo({
    required this.width,
    required this.iconSize,
    required this.spacing,
    required this.itemHeight,
    required this.subMenuHeaderHeight,
    required this.subMenuIconSize,
    required this.itemPadding,
    required this.subItemPadding,
  });
}

class MenuDrawerSizingComponentsInfo {
  final SideMenuSizingInfoNull? sideMenuSizing;
  MenuDrawerSizingComponentsInfo({
    this.sideMenuSizing,
  });
}

class MenuDrawerSizingComponentsOverride
    implements MenuDrawerSizingComponentsInfo {
  @override
  final SideMenuSizingOverride? sideMenuSizing;
  MenuDrawerSizingComponentsOverride({
    this.sideMenuSizing,
  });
}

class MenuDrawerSizingComponents implements MenuDrawerSizingComponentsInfo {
  @override
  final SideMenuSizingStyle sideMenuSizing;
  MenuDrawerSizingComponents({
    required this.sideMenuSizing,
  });
}

class MenuDrawerSizingOverride extends MenuDrawerSizingInfoNull
    implements MenuDrawerSizingComponentsOverride {
  final MenuDrawerSizingComponentsOverride Function(
      MenuDrawerSizingInfoNull sizing)? buildComponents;
  @override
  late final SideMenuSizingOverride? sideMenuSizing;
  MenuDrawerSizingOverride({
    this.buildComponents,
    super.width,
    super.iconSize,
    super.spacing,
    super.itemHeight,
    super.subMenuHeaderHeight,
    super.subMenuIconSize,
    super.itemPadding,
    super.subItemPadding,
  }) {
    MenuDrawerSizingComponentsOverride? components =
        buildComponents?.call(this);
    sideMenuSizing = components?.sideMenuSizing;
  }
}

class MenuDrawerSizingStyle extends MenuDrawerSizingInfo
    implements MenuDrawerSizingComponents {
  @override
  late final SideMenuSizingStyle sideMenuSizing;
  MenuDrawerSizingStyle({
    required MenuDrawerSizingComponents Function(MenuDrawerSizingInfo sizing)
        buildComponents,
    required super.width,
    required super.iconSize,
    required super.spacing,
    required super.itemHeight,
    required super.subMenuHeaderHeight,
    required super.subMenuIconSize,
    required super.itemPadding,
    required super.subItemPadding,
  }) {
    MenuDrawerSizingComponents components = buildComponents.call(this);
    sideMenuSizing = components.sideMenuSizing;
  }
  MenuDrawerSizingStyle.copy({
    required super.width,
    required super.iconSize,
    required super.spacing,
    required super.itemHeight,
    required super.subMenuHeaderHeight,
    required super.subMenuIconSize,
    required super.itemPadding,
    required super.subItemPadding,
    required this.sideMenuSizing,
  });

// **************************************************************************
// Override
// **************************************************************************
  factory MenuDrawerSizingStyle.override(
    MenuDrawerSizingStyle def,
    MenuDrawerSizingOverride? override,
  ) {
    if (override == null) {
      return def;
    }
    return MenuDrawerSizingStyle(
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
          sideMenuSizing: SideMenuSizingStyle.override(
              def.sideMenuSizing, override.sideMenuSizing),
        );
      },
    );
  }

// **************************************************************************
// Copy With
// **************************************************************************
  MenuDrawerSizingStyle copyWith({
    double? width,
    double? iconSize,
    double? spacing,
    double? itemHeight,
    double? subMenuHeaderHeight,
    double? subMenuIconSize,
    EdgeInsets? itemPadding,
    EdgeInsets? subItemPadding,
    SideMenuSizingStyle? sideMenuSizing,
  }) {
    return MenuDrawerSizingStyle.copy(
      width: width ?? this.width,
      iconSize: iconSize ?? this.iconSize,
      spacing: spacing ?? this.spacing,
      itemHeight: itemHeight ?? this.itemHeight,
      subMenuHeaderHeight: subMenuHeaderHeight ?? this.subMenuHeaderHeight,
      subMenuIconSize: subMenuIconSize ?? this.subMenuIconSize,
      itemPadding: itemPadding ?? this.itemPadding,
      subItemPadding: subItemPadding ?? this.subItemPadding,
      sideMenuSizing: sideMenuSizing ?? this.sideMenuSizing,
    );
  }
}
