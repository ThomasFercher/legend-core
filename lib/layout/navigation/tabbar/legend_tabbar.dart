import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:legend_design_core/layout/navigation/tabbar/tab_option.dart';
import 'package:legend_design_core/router/scaffold_route_info.dart';
import 'package:legend_design_core/styles/legend_theme.dart';
import 'package:legend_design_core/widgets/gestures/detector.dart';
import 'package:legend_router/router/legend_router.dart';
import 'package:legend_router/router/route_info_provider.dart';

import 'package:legend_utils/extensions/extensions.dart';
import '../../scaffold/scaffoldInfo.dart';

class TabBarStyle {
  final Color background;
  final double height;
  final MainAxisAlignment alignment;

  TabBarStyle({
    required this.background,
    required this.height,
    required this.alignment,
  });
}

class LegendTabBar extends StatefulWidget {
  final List<RouteInfo> displays;
  late final Color border;

  LegendTabBar({
    Key? key,
    required this.style,
    required this.displays,
  }) : super(key: key) {
    border = style.background.lighten();
  }

  final TabBarStyle style;

  @override
  State<LegendTabBar> createState() => _LegendTabBarState();
}

class _LegendTabBarState extends State<LegendTabBar> {
  List<Widget> getOptions() {
    List<Widget> items = [];
    RouteInfo? info = ScaffoldInfo.of(context).routeInfo;

    TabviewPageInfo route;

    if (info is TabviewChildPageInfo) {
      RouteInfo? parentInfo =
          RouteInfoProvider.getParentRouteInfo(context, info);
      route = parentInfo as TabviewPageInfo;
    } else if (info is TabviewPageInfo) {
      route = info;
    } else {
      return [];
    }
    LegendTheme theme = LegendTheme.of(context);
    final double height = route.style.height;

    for (int i = 0; i < widget.displays.length; i++) {
      final RouteInfo display = widget.displays[i];
      Widget item = LegendDetector(
        padding: EdgeInsets.zero,
        onTap: () {
          LegendRouter.of(context).pushPage(
            settings: RouteSettings(
              name: display.name,
            ),
          );
        },
        child: TabOption(
          selected: display.name == info.name,
          icon: display.icon,
          title: display.title,
          background: widget.style.background,
          border: widget.border,
          padding: EdgeInsets.symmetric(
            horizontal: height / 2,
          ),
          height: height,
        ),
      );
      items.add(item);
    }
    return items;
  }

  @override
  Widget build(BuildContext context) {
    LegendTheme theme = LegendTheme.of(context);
    return LayoutBuilder(builder: (context, constraints) {
      double width = constraints.maxWidth;
      double height = constraints.maxHeight;

      return Container(
        width: width,
        height: height,
        color: widget.style.background,
        child: Container(
          height: height,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: getOptions().paddingRow(8),
          ),
        ),
      );
    });
  }
}
