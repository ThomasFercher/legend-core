// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'builders.dart';

// **************************************************************************
// StyleGenerator
// **************************************************************************

abstract class ScaffoldBuildersInfoNull {
  final Widget Function(BuildContext, LegendTheme)? appBarActions;
  final Widget Function(BuildContext, LegendTheme)? menuDrawerActions;
  final Widget? customFooter;
  final Widget? appBarBottom;
  final Widget Function(BuildContext, LegendTheme)? siderBuilder;
  final Widget Function(BuildContext, List<RouteInfo>, RouteInfo?)?
      fixedMenuBuilder;
  const ScaffoldBuildersInfoNull({
    this.appBarActions,
    this.menuDrawerActions,
    this.customFooter,
    this.appBarBottom,
    this.siderBuilder,
    this.fixedMenuBuilder,
  });
}

abstract class ScaffoldBuildersInfo implements ScaffoldBuildersInfoNull {
  @override
  final Widget Function(BuildContext, LegendTheme)? appBarActions;
  @override
  final Widget Function(BuildContext, LegendTheme)? menuDrawerActions;
  @override
  final Widget? customFooter;
  @override
  final Widget? appBarBottom;
  @override
  final Widget Function(BuildContext, LegendTheme)? siderBuilder;
  @override
  final Widget Function(BuildContext, List<RouteInfo>, RouteInfo?)?
      fixedMenuBuilder;
  const ScaffoldBuildersInfo({
    this.appBarActions,
    this.menuDrawerActions,
    this.customFooter,
    this.appBarBottom,
    this.siderBuilder,
    this.fixedMenuBuilder,
  });
}

class ScaffoldBuildersOverride extends ScaffoldBuildersInfoNull {
  ScaffoldBuildersOverride({
    super.appBarActions,
    super.menuDrawerActions,
    super.customFooter,
    super.appBarBottom,
    super.siderBuilder,
    super.fixedMenuBuilder,
  });
}

class ScaffoldBuilders extends ScaffoldBuildersInfo {
  ScaffoldBuilders({
    super.appBarActions,
    super.menuDrawerActions,
    super.customFooter,
    super.appBarBottom,
    super.siderBuilder,
    super.fixedMenuBuilder,
  });
  ScaffoldBuilders.copy({
    super.appBarActions,
    super.menuDrawerActions,
    super.customFooter,
    super.appBarBottom,
    super.siderBuilder,
    super.fixedMenuBuilder,
  });

// **************************************************************************
// Override
// **************************************************************************
  factory ScaffoldBuilders.override(
    ScaffoldBuilders def,
    ScaffoldBuildersOverride? override,
  ) {
    if (override == null) {
      return def;
    }
    return ScaffoldBuilders(
      appBarActions: override.appBarActions ?? def.appBarActions,
      menuDrawerActions: override.menuDrawerActions ?? def.menuDrawerActions,
      customFooter: override.customFooter ?? def.customFooter,
      appBarBottom: override.appBarBottom ?? def.appBarBottom,
      siderBuilder: override.siderBuilder ?? def.siderBuilder,
      fixedMenuBuilder: override.fixedMenuBuilder ?? def.fixedMenuBuilder,
    );
  }

// **************************************************************************
// Copy With
// **************************************************************************
  ScaffoldBuilders copyWith({
    Widget Function(BuildContext, LegendTheme)? appBarActions,
    Widget Function(BuildContext, LegendTheme)? menuDrawerActions,
    Widget? customFooter,
    Widget? appBarBottom,
    Widget Function(BuildContext, LegendTheme)? siderBuilder,
    Widget Function(BuildContext, List<RouteInfo>, RouteInfo?)?
        fixedMenuBuilder,
  }) {
    return ScaffoldBuilders.copy(
      appBarActions: appBarActions ?? this.appBarActions,
      menuDrawerActions: menuDrawerActions ?? this.menuDrawerActions,
      customFooter: customFooter ?? this.customFooter,
      appBarBottom: appBarBottom ?? this.appBarBottom,
      siderBuilder: siderBuilder ?? this.siderBuilder,
      fixedMenuBuilder: fixedMenuBuilder ?? this.fixedMenuBuilder,
    );
  }
}
