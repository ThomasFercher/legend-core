import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:legend_design_core/layout/navigation/tabbar/tab_option.dart';
import 'package:legend_design_core/layout/scaffold/legend_scaffold.dart';
import 'package:legend_design_core/router/scaffold_route_info.dart';
import 'package:legend_design_core/styles/typography/legend_text.dart';
import 'package:legend_design_core/widgets/gestures/detector.dart';
import 'package:legend_router/router/legend_router.dart';
import 'package:legend_router/router/route_info_provider.dart';
import 'package:legend_router/router/routes/route_display.dart';
import 'package:legend_utils/extensions/extensions.dart';

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
  final List<RouteDisplay> displays;
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

    final double height = route.style.height / 3 * 2;

    return widget.displays.map((display) {
      return LegendDetector(
        onTap: () {
          LegendRouter.of(context).pushPage(
            settings: RouteSettings(
              name: display.route,
            ),
          );
          setState(() {});
        },
        child: TabOption(
          children: [
            Icon(
              display.icon,
              color: widget.border,
            ),
            LegendText(
              text: display.title,
            ),
          ],
          background: widget.style.background,
          border: widget.border,
          padding: EdgeInsets.symmetric(
            horizontal: height / 2,
          ),
          height: height,
        ),
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      double width = constraints.maxWidth;
      double height = constraints.maxHeight;

      return Container(
        height: height,
        width: width,
        color: widget.style.background,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: widget.style.alignment,
          children: getOptions().traillingPaddingRow(
            height / 4,
          ),
        ),
      );
    });
  }
}
