// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'route_layout.dart';

// **************************************************************************
// StyleGenerator
// **************************************************************************

abstract class RouteLayoutInfoNull {
  final dynamic? appBarLayout;
  final SiderLayout? siderLayout;
  final FooterLayout? footerLayout;
  final BottomBarLayout? bottomBarLayout;
  final MenuDrawerLayout? menuDrawerLayout;
  const RouteLayoutInfoNull({
    required this.appBarLayout,
    this.siderLayout,
    this.footerLayout,
    this.bottomBarLayout,
    this.menuDrawerLayout,
  });
}

abstract class RouteLayoutInfo implements RouteLayoutInfoNull {
  @override
  final dynamic appBarLayout;
  @override
  final SiderLayout? siderLayout;
  @override
  final FooterLayout? footerLayout;
  @override
  final BottomBarLayout? bottomBarLayout;
  @override
  final MenuDrawerLayout? menuDrawerLayout;
  const RouteLayoutInfo({
    required this.appBarLayout,
    this.siderLayout,
    this.footerLayout,
    this.bottomBarLayout,
    this.menuDrawerLayout,
  });
}

class RouteLayoutOverride extends RouteLayoutInfoNull {
  RouteLayoutOverride({
    super.appBarLayout,
    super.siderLayout,
    super.footerLayout,
    super.bottomBarLayout,
    super.menuDrawerLayout,
  });
}

class RouteLayoutStyle extends RouteLayoutInfo {
  RouteLayoutStyle({
    required super.appBarLayout,
    super.siderLayout,
    super.footerLayout,
    super.bottomBarLayout,
    super.menuDrawerLayout,
  });
  RouteLayoutStyle.copy({
    required super.appBarLayout,
    super.siderLayout,
    super.footerLayout,
    super.bottomBarLayout,
    super.menuDrawerLayout,
  });

// **************************************************************************
// Override
// **************************************************************************
  factory RouteLayoutStyle.override(
    RouteLayoutStyle def,
    RouteLayoutOverride? override,
  ) {
    if (override == null) {
      return def;
    }
    return RouteLayoutStyle(
      appBarLayout: override.appBarLayout ?? def.appBarLayout,
      siderLayout: override.siderLayout ?? def.siderLayout,
      footerLayout: override.footerLayout ?? def.footerLayout,
      bottomBarLayout: override.bottomBarLayout ?? def.bottomBarLayout,
      menuDrawerLayout: override.menuDrawerLayout ?? def.menuDrawerLayout,
    );
  }

// **************************************************************************
// Copy With
// **************************************************************************
  RouteLayoutStyle copyWith({
    dynamic? appBarLayout,
    SiderLayout? siderLayout,
    FooterLayout? footerLayout,
    BottomBarLayout? bottomBarLayout,
    MenuDrawerLayout? menuDrawerLayout,
  }) {
    return RouteLayoutStyle.copy(
      appBarLayout: appBarLayout ?? this.appBarLayout,
      siderLayout: siderLayout ?? this.siderLayout,
      footerLayout: footerLayout ?? this.footerLayout,
      bottomBarLayout: bottomBarLayout ?? this.bottomBarLayout,
      menuDrawerLayout: menuDrawerLayout ?? this.menuDrawerLayout,
    );
  }
}
