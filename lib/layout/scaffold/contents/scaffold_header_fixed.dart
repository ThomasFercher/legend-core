import 'package:flutter/material.dart';
import 'package:legend_design_core/layout/fixed/appBar.dart/appbar_config.dart';
import 'package:legend_design_core/layout/fixed/appBar.dart/legend_appbar.dart';
import 'package:legend_design_core/layout/fixed/appBar.dart/legend_appbar_fixed.dart';
import 'package:legend_design_core/layout/scaffold/legend_scaffold.dart';
import 'package:legend_design_core/styles/layouts/layout_type.dart';
import 'package:legend_design_core/styles/legend_theme.dart';
import 'package:provider/provider.dart';

class ScaffoldHeaderFixed extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    LegendTheme theme = context.watch<LegendTheme>();
    LegendScaffold scaffold = ScaffoldInfo.of(context).scaffold;

    bool siderCollapsed = theme.sizing.collapsedSider;

    switch (scaffold.layoutType) {
      case LayoutType.FixedHeaderSider:
        return LegendAppBarFixed(
          type: scaffold.appBarLayoutType,
          actions: scaffold.builders.appBarActions,
          showLogo: siderCollapsed,
          config: LegendAppBarConfig(
            appBarHeight: theme.appBarSizing.appBarHeight,
            showSubMenu: scaffold.whether.showTopSubMenu,
            elevation: 1,
            pinned: true,
            horizontalPadding: theme.appBarSizing.contentPadding.left,
          ),
        );
      case LayoutType.FixedHeader:
        return LegendAppBarFixed(
          type: scaffold.appBarLayoutType,
          actions: scaffold.builders.appBarActions,
          config: LegendAppBarConfig(
            appBarHeight: theme.appBarSizing.appBarHeight,
            elevation: 1,
            showSubMenu: scaffold.whether.showTopSubMenu,
            pinned: true,
            horizontalPadding: theme.appBarSizing.contentPadding.left,
          ),
        );
      case LayoutType.FixedSider:
        return siderCollapsed
            ? LegendAppBarFixed(
                type: scaffold.appBarLayoutType,
                actions: scaffold.builders.appBarActions,
                config: LegendAppBarConfig(
                  appBarHeight: theme.appBarSizing.appBarHeight,
                  elevation: 1,
                  showSubMenu: scaffold.whether.showTopSubMenu,
                  pinned: true,
                  horizontalPadding: theme.appBarSizing.contentPadding.left,
                ),
              )
            : Container();

      default:
        return Container();
    }
  }
}
