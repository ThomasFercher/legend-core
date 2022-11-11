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

    // Dumb Fix TODO: Something
    final appbarLayout = ScaffoldInfo.of(context).getLayout(theme).appBarLayout;
    bool showLogo = appbarLayout?.layout != AppBarLayoutConfig.fixedAbove;

    double maxWidth = theme.siderSizing.width;
    String? current = LegendRouter.of(context).routerDelegate.current?.name;

    return Container(
      width: maxWidth,
      height: MediaQuery.of(context).size.height,
      color: theme.colors.sider.background,
      padding: sizing.padding,
      child: Column(
        children: [
          if (showLogo && LayoutProvider.of(context).logo != null)
            Padding(
              padding: EdgeInsets.only(top: sizing.spacing),
              child: LayoutProvider.of(context).logo!,
            ),
          SizedBox(
            height: menuSizing.itemHeight / 2,
          ),
          if (fixedSider.showMenu)
            SingleChildScrollView(
              child: FixedSiderMenu(
                current: current,
                sizing: menuSizing,
                colors: menuColors,
                depth: current?.allMatches('/').length ?? 0,
                options: LegendRouter.of(context)
                    .routes
                    .get<PageInfo>()
                    .where((element) => element.depth == 1)
                    .toList(),
                showMenuSubItems: true,
                width: maxWidth - sizing.padding.horizontal,
                textStyle: theme.typography.h2,
              ),
            ),
          if (fixedSider.builder != null)
            Expanded(
              child: LegendScaffoldBuilder(
                builder: fixedSider.builder!,
              ),
            ),
        ],
      ),
    );
  }
}
