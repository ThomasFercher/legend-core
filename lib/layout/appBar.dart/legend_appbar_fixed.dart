import 'package:flutter/material.dart';
import 'package:legend_design_core/layout/appBar.dart/appbar_config.dart';
import 'package:legend_design_core/layout/appBar.dart/layout/appbar_layout.dart';
import 'package:legend_design_core/layout/navigation/menu/fixed_menu.dart';
import 'package:legend_design_core/layout/navigation/tabbar/legend_tabbar.dart';
import 'package:legend_design_core/layout/scaffold/contents/scaffold_title.dart';
import 'package:legend_design_core/layout/scaffold/legend_scaffold.dart';
import 'package:legend_design_core/router/scaffold_route_info.dart';
import 'package:legend_router/router/legend_router.dart';
import 'package:legend_design_core/styles/legend_theme.dart';
import 'package:legend_router/router/route_info_provider.dart';
import 'package:legend_router/router/routes/route_display.dart';
import 'package:legend_utils/extensions/extensions.dart';
import 'package:provider/provider.dart';

const List<Widget> actionsFiller = [
  SizedBox(
    height: 0,
    width: 0,
  )
];

class LegendAppBarFixed extends StatelessWidget {
  final LegendAppBarConfig config;
  final WidgetBuilder? actions;
  final Widget? title;
  final Widget? logo;
  final bool showMenu;
  final bool showTitle;
  final bool showLogo;
  final AppBarLayoutType type;

  const LegendAppBarFixed({
    required this.config,
    this.actions,
    this.logo,
    this.title,
    this.showMenu = true,
    this.showLogo = true,
    this.showTitle = true,
    required this.type,
  });

  FixedMenu getMenu(BuildContext context) {
    LegendTheme theme = context.watch<LegendTheme>();
    switch (type) {
      case AppBarLayoutType.MeTiAc:
        return FixedMenu(
          height: 48,
          // showSubMenu: config.showSubMenu,
          itemPadding: EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 8,
          ),
          borderRadius: theme.sizing.radius1.asRadius(),
          showMenuSubItems: false,
          background: theme.colors.appBar.background,
          foreground: theme.colors.appBar.foreground,
          activeForeground: theme.colors.appBar.selected,
          options: LegendRouter.of(context).routeDisplays,
          activeBackground: theme.appBar.background.lighten(),
          iconSize: theme.appBarSizing.iconSize,
          spacing: theme.appBarSizing.spacing ?? 12,
        );
      case AppBarLayoutType.TiMeAc:
        return FixedMenu(
          height: 48,
          // showSubMenu: config.showSubMenu,
          itemPadding: EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 8,
          ),
          borderRadius: theme.sizing.radius1.asRadius(),
          showMenuSubItems: false,
          background: theme.colors.appBar.background,
          foreground: theme.colors.appBar.foreground,
          activeForeground: theme.colors.appBar.selected,
          options: LegendRouter.of(context).routeDisplays,
          activeBackground: theme.appBar.background.lighten(),
          iconSize: theme.appBarSizing.iconSize,
          spacing: theme.appBarSizing.spacing ?? 12,
        );
    }
  }

  PreferredSize _bottom(BuildContext context) {
    RouteInfo? route = RouteInfoProvider.getRouteInfo(context);
    RouteDisplay? display = ScaffoldInfo.of(context).display;

    if (route is TabviewPageInfo) {
      List<RouteDisplay> displays = [if (display != null) display];
      displays.addAll(display?.children?.toList() ?? []);
      return PreferredSize(
        preferredSize: Size.fromHeight(route.style.height),
        child: ConstrainedBox(
          constraints: BoxConstraints(maxHeight: route.style.height),
          child: LegendTabBar(
            style: route.style,
            displays: displays,
          ),
        ),
      );
    } else if (route is TabviewChildPageInfo) {
      RouteInfo? parent = RouteInfoProvider.getParentRouteInfo(context, route);
      TabviewPageInfo info = parent as TabviewPageInfo;
      RouteDisplay? parentDisplay =
          RouteInfoProvider.getParentRouteDisplay(context);
      List<RouteDisplay> displays = [if (parentDisplay != null) parentDisplay];
      displays.addAll(parentDisplay?.children?.toList() ?? []);
      return PreferredSize(
        preferredSize: Size.fromHeight(parent.style.height),
        child: ConstrainedBox(
          constraints: BoxConstraints(maxHeight: parent.style.height),
          child: LegendTabBar(
            style: parent.style,
            displays: displays,
          ),
        ),
      );
    } else {
      return PreferredSize(child: Container(), preferredSize: Size.zero);
    }
  }

  @override
  Widget build(BuildContext context) {
    LegendTheme theme = context.watch<LegendTheme>();
    return AppBar(
      leadingWidth: 0,
      titleSpacing: 0,
      elevation: config.elevation,
      //  toolbarHeight: config.appBarHeight,
      actions: actionsFiller,
      backgroundColor: theme.appBar.background,
      toolbarHeight: 200,
      bottom: _bottom(context),
      title: Container(
        height: 200,
        color: theme.colors.appBar.background,
        //   constraints: BoxConstraints(maxHeight: config.appBarHeight),
        padding: EdgeInsets.symmetric(horizontal: config.horizontalPadding),
        child: AppBarDelegate(
          type: type,
          children: {
            if (showTitle) AppBarItem.TITLE: title ?? ScaffoldTitle(),
            if (showMenu) AppBarItem.MENU: getMenu(context),
            if (actions != null) AppBarItem.ACTIONS: Builder(builder: actions!),
          },
        ),
      ),
    );
  }
}
