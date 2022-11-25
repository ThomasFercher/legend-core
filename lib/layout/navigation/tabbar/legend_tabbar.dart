import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:legend_design_core/layout/navigation/tabbar/tab_option.dart';
import 'package:legend_design_core/state/legend_state.dart';
import 'package:legend_design_core/widgets/gestures/detector.dart';
import 'package:legend_router/legend_router.dart';
import 'package:legend_utils/extensions/extensions.dart';
import '../../scaffold/scaffold_info.dart';

class LegendTabBar extends LegendWidget {
  final List<RouteInfo> routes;

  const LegendTabBar({
    super.key,
    required this.routes,
  });

  List<Widget> getOptions(BuildContext context) {
    List<Widget> items = [];
    final theme = LegendTheme.of(context);
    final routeLayout = ScaffoldInfo.of(context)!.getLayout(theme);
    final current = ScaffoldInfo.of(context)!.routeInfo;

    if (routeLayout.appBarLayout?.showTabbar == true) {
      final double height = theme.appBarSizing.tabbarSizing?.height ?? 56;

      for (int i = 0; i < routes.length; i++) {
        final RouteInfo route = routes[i];
        Widget item = LegendDetector(
          padding: EdgeInsets.zero,
          onTap: () {
            LegendRouter.of(context).pushPage(
              route.name,
            );
          },
          child: TabOption(
            selected: route.name == current.name,
            icon: route.icon,
            title: route.title,
            background: theme.appBarColors.tabbarColors?.background ??
                theme.colors.background1,
            border: theme.appBarColors.tabbarColors?.background ??
                theme.colors.background1,
            padding: EdgeInsets.symmetric(
              horizontal: height / 2,
            ),
            height: height,
          ),
        );
        items.add(item);
      }
    }

    return items;
  }

  @override
  Widget build(BuildContext context, theme) {
    final colors = theme.appBarColors.tabbarColors;
    return LayoutBuilder(builder: (context, constraints) {
      double width = constraints.maxWidth;
      double height = constraints.maxHeight;

      return Container(
        width: width,
        height: height,
        color: colors?.background ?? theme.colors.background1,
        child: Container(
          height: height,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: getOptions(context).paddingRow(8),
          ),
        ),
      );
    });
  }
}
