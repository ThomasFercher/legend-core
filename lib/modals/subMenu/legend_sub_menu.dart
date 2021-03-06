import 'dart:math';

import 'package:animations/animations.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:legend_design_core/modals/modalSheet.dart';
import 'package:legend_design_core/widgets/size_info.dart';
import 'package:legend_router/router/routes/route_display.dart';
import 'package:legend_utils/legend_utils.dart';

import '../../layout/navigation/siderMenu/fixed_sider_menu.dart';
import '../../styles/colors/subcolors/micros/sidemenu/sidemenu_colors.dart';
import '../../styles/legend_theme.dart';
import '../../styles/sizing/sub_sizing/micros/sidemenu/sidemenu_sizing.dart';
import '../legendPopups.dart';

class LegendSubMenu {
  ///
  /// Returns true if [s] is inside the Triangle which consists of the points [a], [b], [c].
  ///
  static bool pointInTriangle({
    required Point<double> s,
    required Point<double> a,
    required Point<double> b,
    required Point<double> c,
  }) {
    double as_x = s.x - a.x;
    double as_y = s.y - a.y;
    bool s_ab = (b.x - a.x) * as_y - (b.y - a.y) * as_x > 0;
    if ((c.x - a.x) * as_y - (c.y - a.y) * as_x > 0 == s_ab) return false;
    if ((c.x - b.x) * (s.y - b.y) - (c.y - b.y) * (s.x - b.x) > 0 != s_ab) {
      return false;
    }
    return true;
  }

  static void show({
    required List<RouteDisplay> options,
    required BuildContext context,
    required GlobalKey key,
    required LegendTheme theme,
    required double menuWidth,
    required double offsetY,
    required String current,
    required double parentHeight,
    void Function(PointerExitEvent event)? onExit,
    void Function(PointerHoverEvent event, Offset point)? onParentExit,
    void Function()? onParentTap,
    double? maxHeight,
    BorderRadiusGeometry? borderRadius,
    double snappedPadding = 16,
  }) {
    // Usefull Coordinates
    double? itemWidth = LegendFunctions.getWidgetSize(context, key)?.width ?? 0;
    double leftQ = (menuWidth - itemWidth) / 2;
    double rightQ = (menuWidth - leftQ);
    double center =
        LegendFunctions.getVerticalCenter(context, key, menuWidth) ?? 0;

    // Snap Right
    bool snappedRight = false;
    double maxWidth = SizeInfo.of(context).width;
    if (maxWidth < center + menuWidth) {
      center = maxWidth - menuWidth;
      snappedRight = true;
    }

    Point position = Point(center, 0.0);

    // Prevent Multiple calls of parentExit
    bool hasExited = false;

    //Styles
    SideMenuColorsStyle colors = theme.appBar.subMenuColors;
    SideMenuSizingStyle sizing = theme.appBarSizing.subMenuSizing;

    LegendPopups.showLegendModal(
      context: context,
      config: FadeScaleTransitionConfiguration(
        barrierColor: Colors.transparent,
        barrierDismissible: true,
        transitionDuration: Duration(milliseconds: 200),
        barrierLabel: '',
        reverseTransitionDuration: Duration(milliseconds: 100),
      ),
      modal: ModalSheet(
        position: position,
        child: MouseRegion(
          onHover: (event) {
            Offset p = event.localPosition;
            if (p.dy <= (parentHeight)) {
              if (snappedRight) {
                if (event.localDelta.dy < 0) {
                  leftQ = menuWidth - itemWidth - snappedPadding;

                  if (leftQ >= p.dx) {
                    if (onParentExit != null) onParentExit(event, p);
                  }
                }
              } else {
                if (p.dx <= leftQ) {
                  if (!pointInTriangle(
                    s: Point(p.dx, p.dy),
                    a: Point(leftQ, parentHeight),
                    b: Point(leftQ, 0),
                    c: Point(0, parentHeight),
                  )) {
                    if (onParentExit != null && !hasExited) {
                      hasExited = true;
                      onParentExit(event, p);
                    }
                  }
                } else if (p.dx >= rightQ) {
                  if (!pointInTriangle(
                    s: Point(p.dx, p.dy),
                    a: Point(rightQ, parentHeight),
                    b: Point(rightQ, 0),
                    c: Point(menuWidth, parentHeight),
                  )) {
                    if (onParentExit != null && !hasExited) {
                      hasExited = true;
                      onParentExit(event, p);
                    }
                  }
                } else {
                  hasExited = false;
                }
              }
            }
          },
          onExit: (event) {
            if (onExit != null) onExit(event);
          },
          child: Column(
            children: [
              GestureDetector(
                onTap: onParentTap,
                child: Container(
                  margin: snappedRight
                      ? EdgeInsets.only(left: leftQ + snappedPadding)
                      : EdgeInsets.zero,
                  height: parentHeight,
                  width: itemWidth,
                  color: Colors.transparent,
                ),
              ),
              Container(
                width: menuWidth,
                constraints: BoxConstraints(
                  maxHeight: maxHeight ?? double.infinity,
                ),
                child: Card(
                  color: colors.background,
                  shape: RoundedRectangleBorder(
                    borderRadius: theme.sizing.radius4.asRadius(),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(theme.sizing.spacing1),
                    child: FixedSiderMenu(
                      sizing: sizing,
                      colors: colors,
                      depth: current.allMatches('/').length,
                      width: menuWidth,
                      hasToPop: true,
                      options: options,
                      showMenuSubItems: true,
                      textStyle: theme.typography.h2,
                      current: current,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
