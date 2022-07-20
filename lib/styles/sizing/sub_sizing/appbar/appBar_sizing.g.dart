// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'appBar_sizing.dart';

// **************************************************************************
// SubSizingGenerator
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
  AppBarSizingComponentsInfo({
    this.menuSizing,
    this.subMenuSizing,
  });
}

class AppBarSizingComponentsOverride implements AppBarSizingComponentsInfo {
  @override
  final MenuSizingOverride? menuSizing;
  @override
  final SideMenuSizingOverride? subMenuSizing;
  AppBarSizingComponentsOverride({
    this.menuSizing,
    this.subMenuSizing,
  });
}

class AppBarSizingComponents implements AppBarSizingComponentsInfo {
  @override
  final MenuSizingStyle menuSizing;
  @override
  final SideMenuSizingStyle subMenuSizing;
  AppBarSizingComponents({
    required this.menuSizing,
    required this.subMenuSizing,
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
  }
}

class AppBarSizingStyle extends AppBarSizingInfo
    implements AppBarSizingComponents {
  final AppBarSizingComponents Function(AppBarSizingInfo sizing)
      buildComponents;
  @override
  late final MenuSizingStyle menuSizing;
  @override
  late final SideMenuSizingStyle subMenuSizing;
  AppBarSizingStyle({
    required this.buildComponents,
    required super.contentPadding,
    required super.logoSize,
    required super.spacing,
    required super.appBarHeight,
    required super.iconSize,
  }) {
    AppBarSizingComponents components = buildComponents.call(this);
    menuSizing = components.menuSizing;
    subMenuSizing = components.subMenuSizing;
  }
  factory AppBarSizingStyle.override(
    AppBarSizingStyle def,
    AppBarSizingOverride? override,
  ) {
    if (override == null) {
      return def;
    }
    return AppBarSizingStyle(
      contentPadding: override.contentPadding ?? def.contentPadding,
      logoSize: override.logoSize ?? def.logoSize,
      spacing: override.spacing ?? def.spacing,
      appBarHeight: override.appBarHeight ?? def.appBarHeight,
      iconSize: override.iconSize ?? def.iconSize,
      buildComponents: (_) {
        return AppBarSizingComponents(
          menuSizing:
              MenuSizingStyle.override(def.menuSizing, override.menuSizing),
          subMenuSizing: SideMenuSizingStyle.override(
              def.subMenuSizing, override.subMenuSizing),
        );
      },
    );
  }
}
