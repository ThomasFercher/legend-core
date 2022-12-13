import 'package:flutter/material.dart';
import 'package:legend_design_core/layout/appBar.dart/appbar_layout.dart';
import 'package:legend_design_core/layout/config/route_layout.dart';
import 'package:legend_design_core/layout/scaffold/routebody/route_body_info.dart';
import 'package:legend_design_core/layout/scaffold/scaffold_info.dart';
import 'package:legend_design_core/layout/sider/sider_layout.dart';
import 'package:legend_design_core/state/legend_state.dart';
import 'package:legend_design_core/widgets/shadow/inner_box_decoration.dart';
import 'package:legend_design_core/widgets/shadow/inner_box_shadow.dart';

class InnerElevation extends LegendWidget {
  final Widget child;
  final double? width;

  const InnerElevation({
    required this.child,
    this.width,
  });

  @override
  Widget build(BuildContext context, LegendTheme theme) {
    final side = getShadowSide(ScaffoldInfo.of(context)!.routeLayout,
        !RouteBodyInfo.of(context).showSliverBar);
    if (side == null) {
      return child;
    }

    return Container(
      width: width,
      decoration: InnerBoxDecoration(
        shadowSide: side,
        boxShadow: const [
          InnerBoxShadow(
            color: Colors.black,
            spreadRadius: 0.6,
            blurRadius: 6,
          )
        ],
      ),
      child: child,
    );
  }
}

ShadowSide leftRight(bool top, SiderLayout layout) {
  if (top) {
    return layout.left ? ShadowSide.topleft : ShadowSide.topright;
  }
  return layout.left ? ShadowSide.left : ShadowSide.right;
}

ShadowSide? getShadowSide(RouteLayout layout, bool appbar) {
  bool sider = layout.siderLayout != null;
  final fixedAppBar =
      layout.appBarLayout?.layout == AppBarLayoutConfig.fixedAbove;
  final siderLayout = layout.siderLayout;

  if (appbar && fixedAppBar && sider) {
    return leftRight(true, siderLayout!);
  }

  if (appbar && fixedAppBar) {
    return ShadowSide.top;
  }

  if (sider) {
    return leftRight(false, siderLayout!);
  }

  return null;
}
