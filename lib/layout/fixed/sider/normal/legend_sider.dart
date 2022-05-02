import 'package:flutter/material.dart';
import 'package:legend_design_core/layout/fixed/sider/fixed_sider.dart';
import 'package:legend_design_core/layout/fixed/sider/menu/fixed_sider_menu.dart';
import 'package:legend_design_core/layout/fixed/sider/siderInfo.dart';
import 'package:legend_design_core/layout/layout_provider.dart';
import 'package:legend_design_core/router/legend_router.dart';
import 'package:legend_design_core/router/route_info_provider.dart';
import 'package:legend_design_core/styles/layouts/layout_type.dart';
import 'package:legend_design_core/styles/legend_theme.dart';
import 'package:legend_design_core/typography/legend_text.dart';
import 'package:legend_design_core/utils/extensions.dart';

import 'package:provider/provider.dart';

class Sider extends StatelessWidget {
  const Sider({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    LegendSider fixedSider = SiderInfo.of(context)!.fixedSider;
    LegendTheme theme = Provider.of<LegendTheme>(context);
    double maxWidth = theme.siderSizing.width;

    return Container(
      width: maxWidth,
      height: MediaQuery.of(context).size.height,
      color: theme.colors.siderPalette.background,
      child: Column(
        children: [
          if (fixedSider.layoutType == LayoutType.FixedSider)
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
                  if (LayoutProvider.of(context)?.logo != null)
                    Container(
                      height: 36,
                      width: 36,
                      child: Center(
                        child: LayoutProvider.of(context)!.logo,
                      ),
                    ),
                  const SizedBox(
                    width: 6,
                  ),
                  if (LayoutProvider.of(context)?.title != null)
                    Expanded(
                      child: LegendText(
                        dynamicSizing: true,
                        text: LayoutProvider.of(context)!.title!,
                        textStyle: theme.typography.h6.copyWith(
                          color: theme.colors.siderPalette.foreground,
                        ),
                      ),
                    ),
                ],
              ),
            ),
          Expanded(
            child: Column(
              children: [
                Container(
                  height: 10,
                  color: theme.colors.onPrimary,
                  margin: EdgeInsets.only(
                    bottom: 24,
                  ),
                ),
                if (fixedSider.showMenu)
                  Expanded(
                    child: FixedSiderMenu(
                      activeBackground:
                          theme.colors.siderPalette.background.darken(0.05),
                      foreground: theme.siderPalette.foreground,
                      activeForeground: theme.siderPalette.selection,
                      background: theme.siderPalette.background,
                      options: LegendRouter.of(context).menuOptions,
                      itemHeight: theme.siderSizing.itemHeight,
                      subMenuHeaderHeight:
                          theme.siderSizing.subMenuHeaderHeight,
                      showMenuSubItems: true,
                      spacing: theme.siderSizing.spacing,
                      collapsed: false,
                      iconSize: theme.siderSizing.iconSize,
                    ),
                  ),
                if (fixedSider.showParentMenu && !fixedSider.showMenu)
                  Expanded(
                    child: FixedSiderMenu(
                      activeBackground:
                          theme.colors.siderPalette.background.darken(0.05),
                      foreground: theme.siderPalette.foreground,
                      activeForeground: theme.siderPalette.selection,
                      background: theme.siderPalette.background,
                      options: RouteInfoProvider.getParentMenuOption(context)
                              ?.children ??
                          [],
                      showMenuSubItems: true,
                      spacing: theme.siderSizing.spacing,
                      collapsed: false,
                      itemHeight: theme.siderSizing.itemHeight,
                      subMenuHeaderHeight:
                          theme.siderSizing.subMenuHeaderHeight,
                      iconSize: theme.siderSizing.iconSize,
                    ),
                  ),
                if (fixedSider.showChildMenu && !fixedSider.showMenu)
                  Expanded(
                    child: FixedSiderMenu(
                      activeBackground:
                          theme.colors.siderPalette.background.darken(0.05),
                      foreground: theme.siderPalette.foreground,
                      activeForeground: theme.siderPalette.selection,
                      background: theme.siderPalette.background,
                      options: RouteInfoProvider.getCurrentMenuOption(context)
                              ?.children ??
                          [],
                      showMenuSubItems: true,
                      spacing: theme.siderSizing.spacing,
                      collapsed: false,
                      itemHeight: theme.siderSizing.itemHeight,
                      subMenuHeaderHeight:
                          theme.siderSizing.subMenuHeaderHeight,
                      iconSize: theme.siderSizing.iconSize,
                    ),
                  ),
              ],
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
