import 'package:flutter/material.dart';
import 'package:legend_design_core/layout/appBar.dart/appbar_layout.dart';
import 'package:legend_design_core/layout/config/route_layout.dart';
import 'package:legend_design_core/layout/layout_provider.dart';
import 'package:legend_design_core/layout/navigation/siderMenu/fixed_sider_menu.dart';
import 'package:legend_design_core/layout/scaffold/scaffold_info.dart';
import 'package:legend_design_core/layout/sider/fixed_sider.dart';
import 'package:legend_design_core/layout/sider/sider_info.dart';
import 'package:legend_design_core/router/extension.dart';
import 'package:legend_design_core/state/legend_state.dart';
import 'package:legend_design_core/widgets/size_info.dart';
import 'package:legend_router/legend_router.dart';
import '../../scaffold/config/scaffold_config.dart';

class Sider extends LegendWidget {
  const Sider({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, LegendTheme theme) {
    LegendSider fixedSider = SiderInfo.of(context)!.fixedSider;
    RouteLayout layout = ScaffoldInfo.of(context).getLayout(theme);

    final colors = theme.siderColors;
    final sizing = theme.siderSizing;
    final menuSizing = sizing.sideMenuSizing;
    final menuColors = colors.menuColors;

    bool showLogo = layout.appBarLayout is NoAppBarLayout;

    double maxWidth = theme.siderSizing.width;
    String? current = LegendRouter.of(context).routerDelegate.current?.name;

    return Container(
      width: maxWidth,
      height: SizeInfo.of(context).height,
      color: theme.colors.sider.background,
      padding: sizing.padding,
      child: Column(
        children: [
          if (showLogo)
            Padding(
              padding: EdgeInsets.only(top: sizing.spacing),
              child: LayoutProvider.of(context).getLogo(context),
            ),
          if (fixedSider.showMenu) ...[
            SizedBox(
              height: menuSizing.itemHeight / 2,
            ),
            SingleChildScrollView(
              child: FixedSiderMenu(
                current: current,
                sizing: menuSizing,
                colors: menuColors,
                options: context.menuRoutes,
                showMenuSubItems: true,
                width: maxWidth - sizing.padding.horizontal,
                textStyle: theme.typography.h2,
              ),
            ),
          ],
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
