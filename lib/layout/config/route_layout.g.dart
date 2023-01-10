// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'route_layout.dart';

// **************************************************************************
// StyleGenerator
// **************************************************************************

abstract class RouteLayoutInfoNull {}

abstract class RouteLayoutInfo implements RouteLayoutInfoNull {}

class RouteLayoutComponentsInfo {
  final AppBarLayoutInfoNull? appBarLayout;
  final SiderLayoutInfoNull? siderLayout;
  final FooterLayoutInfoNull? footerLayout;
  final BottomBarLayoutInfoNull? bottomBarLayout;
  final MenuDrawerLayoutInfoNull? menuDrawerLayout;
  RouteLayoutComponentsInfo({
    this.appBarLayout,
    this.siderLayout,
    this.footerLayout,
    this.bottomBarLayout,
    this.menuDrawerLayout,
  });
}

class RouteLayoutComponentsOverride implements RouteLayoutComponentsInfo {
  @override
  final AppBarLayoutOverride? appBarLayout;
  @override
  final SiderLayoutOverride? siderLayout;
  @override
  final FooterLayoutOverride? footerLayout;
  @override
  final BottomBarLayoutOverride? bottomBarLayout;
  @override
  final MenuDrawerLayoutOverride? menuDrawerLayout;
  RouteLayoutComponentsOverride({
    this.appBarLayout,
    this.siderLayout,
    this.footerLayout,
    this.bottomBarLayout,
    this.menuDrawerLayout,
  });
}

class RouteLayoutComponents implements RouteLayoutComponentsInfo {
  @override
  final AppBarLayout appBarLayout;
  @override
  final SiderLayout siderLayout;
  @override
  final FooterLayout footerLayout;
  @override
  final BottomBarLayout bottomBarLayout;
  @override
  final MenuDrawerLayout menuDrawerLayout;
  RouteLayoutComponents({
    required this.appBarLayout,
    required this.siderLayout,
    required this.footerLayout,
    required this.bottomBarLayout,
    required this.menuDrawerLayout,
  });
}

class RouteLayoutOverride extends RouteLayoutInfoNull
    implements RouteLayoutComponentsOverride {
  @override
  final AppBarLayoutOverride? appBarLayout;
  @override
  final SiderLayoutOverride? siderLayout;
  @override
  final FooterLayoutOverride? footerLayout;
  @override
  final BottomBarLayoutOverride? bottomBarLayout;
  @override
  final MenuDrawerLayoutOverride? menuDrawerLayout;
  RouteLayoutOverride({
    this.appBarLayout,
    this.siderLayout,
    this.footerLayout,
    this.bottomBarLayout,
    this.menuDrawerLayout,
  });
}

class RouteLayout extends RouteLayoutInfo implements RouteLayoutComponents {
  @override
  final AppBarLayout appBarLayout;
  @override
  final SiderLayout siderLayout;
  @override
  final FooterLayout footerLayout;
  @override
  final BottomBarLayout bottomBarLayout;
  @override
  final MenuDrawerLayout menuDrawerLayout;
  RouteLayout({
    required this.appBarLayout,
    required this.siderLayout,
    required this.footerLayout,
    required this.bottomBarLayout,
    required this.menuDrawerLayout,
  });
  RouteLayout.copy({
    required this.appBarLayout,
    required this.siderLayout,
    required this.footerLayout,
    required this.bottomBarLayout,
    required this.menuDrawerLayout,
  });

// **************************************************************************
// Override
// **************************************************************************
  factory RouteLayout.override(
    RouteLayout def,
    RouteLayoutOverride? override,
  ) {
    if (override == null) {
      return def;
    }
    return RouteLayout(
      appBarLayout: AppBarLayout.override(
        def.appBarLayout,
        override.appBarLayout,
      ),
      siderLayout: SiderLayout.override(
        def.siderLayout,
        override.siderLayout,
      ),
      footerLayout: FooterLayout.override(
        def.footerLayout,
        override.footerLayout,
      ),
      bottomBarLayout: BottomBarLayout.override(
        def.bottomBarLayout,
        override.bottomBarLayout,
      ),
      menuDrawerLayout: MenuDrawerLayout.override(
        def.menuDrawerLayout,
        override.menuDrawerLayout,
      ),
    );
  }

// **************************************************************************
// Copy With
// **************************************************************************
  RouteLayout copyWith({
    AppBarLayout? appBarLayout,
    SiderLayout? siderLayout,
    FooterLayout? footerLayout,
    BottomBarLayout? bottomBarLayout,
    MenuDrawerLayout? menuDrawerLayout,
  }) {
    return RouteLayout.copy(
      appBarLayout: appBarLayout ?? this.appBarLayout,
      siderLayout: siderLayout ?? this.siderLayout,
      footerLayout: footerLayout ?? this.footerLayout,
      bottomBarLayout: bottomBarLayout ?? this.bottomBarLayout,
      menuDrawerLayout: menuDrawerLayout ?? this.menuDrawerLayout,
    );
  }
}
