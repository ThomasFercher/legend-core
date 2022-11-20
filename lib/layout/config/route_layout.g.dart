// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'route_layout.dart';

// **************************************************************************
// StyleGenerator
// **************************************************************************

abstract class RouteLayoutInfoNull {
  final bool? appBarHasTabbar;
  const RouteLayoutInfoNull({
    required this.appBarHasTabbar,
  });
}

abstract class RouteLayoutInfo implements RouteLayoutInfoNull {
  @override
  final bool? appBarHasTabbar;
  const RouteLayoutInfo({
    this.appBarHasTabbar,
  });
}

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
  final AppBarLayout? appBarLayout;
  @override
  final SiderLayout? siderLayout;
  @override
  final FooterLayout? footerLayout;
  @override
  final BottomBarLayout? bottomBarLayout;
  @override
  final MenuDrawerLayout? menuDrawerLayout;
  RouteLayoutComponents({
    this.appBarLayout,
    this.siderLayout,
    this.footerLayout,
    this.bottomBarLayout,
    this.menuDrawerLayout,
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
    super.appBarHasTabbar,
    this.appBarLayout,
    this.siderLayout,
    this.footerLayout,
    this.bottomBarLayout,
    this.menuDrawerLayout,
  });
}

class RouteLayout extends RouteLayoutInfo implements RouteLayoutComponents {
  @override
  final AppBarLayout? appBarLayout;
  @override
  final SiderLayout? siderLayout;
  @override
  final FooterLayout? footerLayout;
  @override
  final BottomBarLayout? bottomBarLayout;
  @override
  final MenuDrawerLayout? menuDrawerLayout;
  RouteLayout({
    super.appBarHasTabbar,
    this.appBarLayout,
    this.siderLayout,
    this.footerLayout,
    this.bottomBarLayout,
    this.menuDrawerLayout,
  });
  RouteLayout.copy({
    super.appBarHasTabbar,
    this.appBarLayout,
    this.siderLayout,
    this.footerLayout,
    this.bottomBarLayout,
    this.menuDrawerLayout,
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
      appBarHasTabbar: override.appBarHasTabbar ?? def.appBarHasTabbar,
      appBarLayout: def.appBarLayout != null
          ? AppBarLayout.override(
              def.appBarLayout!,
              override.appBarLayout,
            )
          : null,
      siderLayout: def.siderLayout != null
          ? SiderLayout.override(
              def.siderLayout!,
              override.siderLayout,
            )
          : null,
      footerLayout: def.footerLayout != null
          ? FooterLayout.override(
              def.footerLayout!,
              override.footerLayout,
            )
          : null,
      bottomBarLayout: def.bottomBarLayout != null
          ? BottomBarLayout.override(
              def.bottomBarLayout!,
              override.bottomBarLayout,
            )
          : null,
      menuDrawerLayout: def.menuDrawerLayout != null
          ? MenuDrawerLayout.override(
              def.menuDrawerLayout!,
              override.menuDrawerLayout,
            )
          : null,
    );
  }

// **************************************************************************
// Copy With
// **************************************************************************
  RouteLayout copyWith({
    bool? appBarHasTabbar,
    AppBarLayout? appBarLayout,
    SiderLayout? siderLayout,
    FooterLayout? footerLayout,
    BottomBarLayout? bottomBarLayout,
    MenuDrawerLayout? menuDrawerLayout,
  }) {
    return RouteLayout.copy(
      appBarHasTabbar: appBarHasTabbar ?? this.appBarHasTabbar,
      appBarLayout: appBarLayout ?? this.appBarLayout,
      siderLayout: siderLayout ?? this.siderLayout,
      footerLayout: footerLayout ?? this.footerLayout,
      bottomBarLayout: bottomBarLayout ?? this.bottomBarLayout,
      menuDrawerLayout: menuDrawerLayout ?? this.menuDrawerLayout,
    );
  }
}
