import 'package:flutter/material.dart';
import 'package:legend_design_core/layout/config/layout_config.dart';
import 'package:legend_design_core/layout/layout_provider.dart';
import 'package:legend_design_core/layout/navigation/siderMenu/fixed_sider_menu.dart';
import 'package:legend_design_core/layout/navigation/siderMenu/siderMenuStyle.dart';
import 'package:legend_design_core/layout/scaffold/scaffoldInfo.dart';
import 'package:legend_design_core/layout/sider/fixed_sider.dart';
import 'package:legend_design_core/layout/sider/siderInfo.dart';
import 'package:legend_router/router/legend_router.dart';
import 'package:legend_router/router/route_info_provider.dart';
import 'package:legend_design_core/styles/legend_theme.dart';
import 'package:legend_design_core/styles/sizing/sub_sizing/sider_sizing.dart';
import 'package:legend_design_core/styles/typography/legend_text.dart';
import 'package:legend_utils/extensions/extensions.dart';

import 'package:provider/provider.dart';

class Sider extends StatelessWidget {
  const Sider({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    LegendSider fixedSider = SiderInfo.of(context)!.fixedSider;
    LegendTheme theme = Provider.of<LegendTheme>(context);
    SiderPalette colors = theme.siderPalette;
    SiderSizing sizing = theme.siderSizing;

    AppbarLayout appbarLayout = ScaffoldInfo.of(context)
        .scaffold
        .layout
        .getLayout(theme.sizingTheme.key)
        .appBarLayout;
    bool showLogo = appbarLayout != AppbarLayout.FixedAbove;

    double maxWidth = theme.siderSizing.width;

    SiderMenuStyle style = SiderMenuStyle(
      background: colors.background,
      foreground: colors.foreground,
      activeBackground: colors.backgroundMenu,
      activeForeground: colors.selection,
      spacing: sizing.spacing,
      padding: sizing.itemPadding,
      itemHeight: sizing.itemHeight,
      subMenuHeaderHeight: sizing.subMenuHeaderHeight,
      iconSize: sizing.iconSize,
    );

    SiderSubMenuStyle subMenuStyle = SiderSubMenuStyle(
      itemPadding: sizing.itemPadding,
      spacing: sizing.spacing,
      background: colors.backgroundMenu,
      activeForeground: colors.selection,
      activeBackground: colors.backgroundMenu.darken(),
      foreground: colors.foreground,
      borderRadius: theme.sizing.borderRadius[1],
      headerHeight: sizing.subMenuHeaderHeight,
      itemHeight: sizing.itemHeight,
      iconSize: sizing.iconSize,
      subMenuIconSize: sizing.iconSize - 2,
    );

    return Container(
      width: maxWidth,
      height: MediaQuery.of(context).size.height,
      color: theme.colors.siderPalette.background,
      child: Column(
        children: [
          if (showLogo)
            Container(
              color: theme.colors.siderPalette.background,
              padding: EdgeInsets.only(
                left: 24,
                right: 24,
                top: 24,
                bottom: 14,
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  if (LayoutProvider.of(context).logo != null)
                    Container(
                      height: 36,
                      width: 36,
                      child: Center(
                        child: LayoutProvider.of(context).logo,
                      ),
                    ),
                  const SizedBox(
                    width: 6,
                  ),
                  if (LayoutProvider.of(context).title != null)
                    Expanded(
                      child: LegendText(
                        dynamicSizing: true,
                        text: LayoutProvider.of(context).title!,
                        textStyle: theme.typography.h6.copyWith(
                          color: theme.colors.siderPalette.foreground,
                        ),
                      ),
                    ),
                ],
              ),
            ),
          Container(
            height: 10,
            color: theme.colors.onPrimary,
            margin: EdgeInsets.only(
              bottom: 24,
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: sizing.horizontalPadding,
              ),
              child: Column(
                children: [
                  if (fixedSider.showMenu)
                    Expanded(
                      child: FixedSiderMenu(
                        style: style,
                        options: LegendRouter.of(context).routeDisplays,
                        showMenuSubItems: true,
                        collapsed: false,
                        subMenuStyle: subMenuStyle,
                      ),
                    ),
                  if (fixedSider.showParentMenu && !fixedSider.showMenu)
                    Expanded(
                      child: FixedSiderMenu(
                        style: style,
                        subMenuStyle: subMenuStyle,
                        options:
                            RouteInfoProvider.getParentRouteDisplay(context)
                                    ?.children
                                    ?.toList() ??
                                [],
                        showMenuSubItems: true,
                        collapsed: false,
                      ),
                    ),
                  if (fixedSider.showChildMenu && !fixedSider.showMenu)
                    Expanded(
                      child: FixedSiderMenu(
                        style: style,
                        subMenuStyle: subMenuStyle,
                        options: RouteInfoProvider.getRouteDisplay(context)
                                ?.children
                                ?.toList() ??
                            [],
                        showMenuSubItems: true,
                        collapsed: false,
                      ),
                    ),
                ],
              ),
            ),
          ),
          if (fixedSider.builder != null)
            Builder(
              builder: fixedSider.builder!,
            ),
        ],
      ),
    );
  }
}