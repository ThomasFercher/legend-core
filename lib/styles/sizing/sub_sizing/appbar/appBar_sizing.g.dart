// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'appBar_sizing.dart';

// **************************************************************************
// StyleGenerator
// **************************************************************************

abstract class AppBarSizingInfoNull {
  final EdgeInsets? contentPadding;
  final double? logoSize;
  final double? spacing;
  final double? appBarHeight;
  final double? iconSize;
  const AppBarSizingInfoNull({
    required this.contentPadding,
    required this.logoSize,
    required this.spacing,
    required this.appBarHeight,
    required this.iconSize,
  });
}

abstract class AppBarSizingInfo implements AppBarSizingInfoNull {
  @override
  final EdgeInsets contentPadding;
  @override
  final double logoSize;
  @override
  final double spacing;
  @override
  final double appBarHeight;
  @override
  final double iconSize;
  const AppBarSizingInfo({
    required this.contentPadding,
    required this.logoSize,
    required this.spacing,
    required this.appBarHeight,
    required this.iconSize,
  });
}

class AppBarSizingComponentsInfo {
  final MenuSizingInfoNull? menuSizing;
  final SideMenuSizingInfoNull? subMenuSizing;
  final TabbarSizingInfoNull? tabbarSizing;
  AppBarSizingComponentsInfo({
    this.menuSizing,
    this.subMenuSizing,
    this.tabbarSizing,
  });
}

class AppBarSizingComponentsOverride implements AppBarSizingComponentsInfo {
  @override
  final MenuSizingOverride? menuSizing;
  @override
  final SideMenuSizingOverride? subMenuSizing;
  @override
  final TabbarSizingOverride? tabbarSizing;
  AppBarSizingComponentsOverride({
    this.menuSizing,
    this.subMenuSizing,
    this.tabbarSizing,
  });
}

class AppBarSizingComponents implements AppBarSizingComponentsInfo {
  @override
  final MenuSizing menuSizing;
  @override
  final SideMenuSizing subMenuSizing;
  @override
  final TabbarSizing? tabbarSizing;
  AppBarSizingComponents({
    required this.menuSizing,
    required this.subMenuSizing,
    this.tabbarSizing,
  });
}

class AppBarSizingOverride extends AppBarSizingInfoNull
    implements AppBarSizingComponentsOverride {
  final AppBarSizingComponentsOverride Function(AppBarSizingInfoNull sizing)?
      buildComponents;
  @override
  late final MenuSizingOverride? menuSizing;
  @override
  late final SideMenuSizingOverride? subMenuSizing;
  @override
  late final TabbarSizingOverride? tabbarSizing;
  AppBarSizingOverride({
    this.buildComponents,
    super.contentPadding,
    super.logoSize,
    super.spacing,
    super.appBarHeight,
    super.iconSize,
  }) {
    AppBarSizingComponentsOverride? components = buildComponents?.call(this);
    menuSizing = components?.menuSizing;
    subMenuSizing = components?.subMenuSizing;
    tabbarSizing = components?.tabbarSizing;
  }
}

class AppBarSizing extends AppBarSizingInfo implements AppBarSizingComponents {
  @override
  late final MenuSizing menuSizing;
  @override
  late final SideMenuSizing subMenuSizing;
  @override
  late final TabbarSizing? tabbarSizing;
  AppBarSizing({
    required AppBarSizingComponents Function(AppBarSizingInfo sizing)
        buildComponents,
    required super.contentPadding,
    required super.logoSize,
    required super.spacing,
    required super.appBarHeight,
    required super.iconSize,
  }) {
    AppBarSizingComponents components = buildComponents.call(this);
    menuSizing = components.menuSizing;
    subMenuSizing = components.subMenuSizing;
    tabbarSizing = components.tabbarSizing;
  }
  AppBarSizing.copy({
    required super.contentPadding,
    required super.logoSize,
    required super.spacing,
    required super.appBarHeight,
    required super.iconSize,
    required this.menuSizing,
    required this.subMenuSizing,
    this.tabbarSizing,
  });

// **************************************************************************
// Override
// **************************************************************************
  factory AppBarSizing.override(
    AppBarSizing def,
    AppBarSizingOverride? override,
  ) {
    if (override == null) {
      return def;
    }
    return AppBarSizing(
      contentPadding: override.contentPadding ?? def.contentPadding,
      logoSize: override.logoSize ?? def.logoSize,
      spacing: override.spacing ?? def.spacing,
      appBarHeight: override.appBarHeight ?? def.appBarHeight,
      iconSize: override.iconSize ?? def.iconSize,
      buildComponents: (_) {
        return AppBarSizingComponents(
          menuSizing: MenuSizing.override(def.menuSizing, override.menuSizing),
          subMenuSizing: SideMenuSizing.override(
              def.subMenuSizing, override.subMenuSizing),
          tabbarSizing: def.tabbarSizing == null
              ? null
              : TabbarSizing.override(def.tabbarSizing!, override.tabbarSizing),
        );
      },
    );
  }

// **************************************************************************
// Copy With
// **************************************************************************
  AppBarSizing copyWith({
    EdgeInsets? contentPadding,
    double? logoSize,
    double? spacing,
    double? appBarHeight,
    double? iconSize,
    MenuSizing? menuSizing,
    SideMenuSizing? subMenuSizing,
    TabbarSizing? tabbarSizing,
  }) {
    return AppBarSizing.copy(
      contentPadding: contentPadding ?? this.contentPadding,
      logoSize: logoSize ?? this.logoSize,
      spacing: spacing ?? this.spacing,
      appBarHeight: appBarHeight ?? this.appBarHeight,
      iconSize: iconSize ?? this.iconSize,
      menuSizing: menuSizing ?? this.menuSizing,
      subMenuSizing: subMenuSizing ?? this.subMenuSizing,
      tabbarSizing: tabbarSizing ?? this.tabbarSizing,
    );
  }
}
