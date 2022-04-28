import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:legend_design_core/layout/fixed/appBar.dart/appbar_config.dart';
import 'package:legend_design_core/layout/fixed/appBar.dart/legend_appbar.dart';
import 'package:legend_design_core/layout/scaffold/scaffoldInfo.dart';
import 'package:provider/provider.dart';
import '../../../styles/layouts/layout_type.dart';
import '../../../styles/legend_theme.dart';
import '../legend_scaffold.dart';

class ScaffoldHeader extends StatelessWidget {
  const ScaffoldHeader({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    LegendTheme theme = context.watch<LegendTheme>();
    LegendScaffold scaffold = ScaffoldInfo.of(context).scaffold;

    bool bottomBar = theme.sizing.showBottomBar;
    bool showMenu = !bottomBar && (scaffold.whether.showAppBarMenu ?? false);
    bool siderCollapsed = theme.sizing.hideSider;
    print(siderCollapsed);
    switch (scaffold.layoutType) {
      case LayoutType.FixedHeaderSider:
        return LegendAppBar(
          type: scaffold.appBarLayoutType,
          actions: scaffold.builders.appBarActions,
          showLogo: siderCollapsed,
          showTitle: siderCollapsed,
          config: LegendAppBarConfig(
            appBarHeight: theme.appBarSizing.appBarHeight,
            showSubMenu: scaffold.whether.showTopSubMenu ?? false,
            elevation: 1,
            pinned: true,
            horizontalPadding: theme.appBarSizing.contentPadding.left,
          ),
        );
      case LayoutType.FixedHeader:
        return LegendAppBar(
          type: scaffold.appBarLayoutType,
          actions: scaffold.builders.appBarActions,
          config: LegendAppBarConfig(
            appBarHeight: theme.appBarSizing.appBarHeight,
            elevation: 1,
            showSubMenu: scaffold.whether.showTopSubMenu ?? false,
            pinned: true,
            horizontalPadding: theme.appBarSizing.contentPadding.left,
          ),
        );
      case LayoutType.FixedSider:
        return siderCollapsed
            ? LegendAppBar(
                type: scaffold.appBarLayoutType,
                actions: scaffold.builders.appBarActions,
                config: LegendAppBarConfig(
                  appBarHeight: theme.appBarSizing.appBarHeight,
                  elevation: 1,
                  showSubMenu: scaffold.whether.showTopSubMenu ?? false,
                  pinned: true,
                  horizontalPadding: theme.appBarSizing.contentPadding.left,
                ),
              )
            : SliverToBoxAdapter(
                child: Container(),
              );
      default:
        return SliverToBoxAdapter(
          child: Container(),
        );
    }
  }
}