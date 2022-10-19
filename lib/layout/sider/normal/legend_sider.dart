import 'package:flutter/material.dart';
import 'package:legend_design_core/layout/config/appbar_layout.dart';
import 'package:legend_design_core/layout/layout_provider.dart';
import 'package:legend_design_core/layout/navigation/siderMenu/fixed_sider_menu.dart';
import 'package:legend_design_core/layout/scaffold/scaffoldInfo.dart';
import 'package:legend_design_core/layout/sider/fixed_sider.dart';
import 'package:legend_design_core/layout/sider/siderInfo.dart';
import 'package:legend_design_core/styles/colors/subcolors/micros/sidemenu/sidemenu_colors.dart';
import 'package:legend_design_core/styles/sizing/sub_sizing/micros/sidemenu/sidemenu_sizing.dart';
import 'package:legend_router/router/legend_router.dart';
import 'package:legend_router/router/route_info_provider.dart';

import 'package:legend_design_core/state/legend_state.dart';
import 'package:legend_router/router/routes/extensions.dart';

import '../../../router/scaffold_route_info.dart';
import '../../scaffold/config/scaffold_config.dart';

class Sider extends LegendWidget {
  const Sider({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, LegendTheme theme) {
    LegendSider fixedSider = SiderInfo.of(context)!.fixedSider;
    LegendTheme theme = LegendTheme.of(context);
    SiderColorsStyle colors = theme.siderColors;
    SiderSizingStyle sizing = theme.siderSizing;
    SideMenuSizingStyle menuSizing = sizing.sideMenuSizing;
    SideMenuColorsStyle menuColors = colors.menuColors;

    // Dumb Fix
    AppBarLayout appbarLayout =
        ScaffoldInfo.of(context).getLayout(theme).appBarLayout;
    bool showLogo = appbarLayout.layout != AppBarLayoutConfig.fixedAbove;

    double maxWidth = theme.siderSizing.width;
    String current = RouteInfoProvider.getRouteInfo(context)?.name ?? '';

    return Container(
      width: maxWidth,
      height: MediaQuery.of(context).size.height,
      color: theme.colors.sider.background,
      child: Column(
        children: [
          if (showLogo && LayoutProvider.of(context).logo != null)
            LayoutProvider.of(context).logo!,
          SizedBox(
            height: sizing.itemHeight / 2,
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: sizing.horizontalPadding,
              ),
              child: Column(
                children: [
                  if (fixedSider.showMenu)
                    FixedSiderMenu(
                      current: current,
                      sizing: menuSizing,
                      colors: menuColors,
                      depth: current.allMatches('/').length,
                      options: LegendRouter.of(context).routes.get<PageInfo>(),
                      showMenuSubItems: true,
                      width: maxWidth - sizing.horizontalPadding,
                      textStyle: theme.typography.h2,
                    ),

                  /*   RouteInfoProvider.getParentRouteDisplay(context)
                                    ?.children
                                    ?.toList() ??
                             RouteInfoProvider.getRouteDisplay(context)
                                ?.children
                                ?.toList() ??
                            [],
                     */
                ],
              ),
            ),
          ),
          if (fixedSider.builder != null)
            LegendScaffoldBuilder(
              builder: fixedSider.builder!,
            ),
        ],
      ),
    );
  }
}
