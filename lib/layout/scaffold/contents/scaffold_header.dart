import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:legend_design_core/layout/appBar.dart/appbar_config.dart';
import 'package:legend_design_core/layout/appBar.dart/legend_appbar.dart';
import '../../config/appbar_layout.dart';
import '../legend_scaffold.dart';
import 'package:legend_design_core/state/legend_state.dart';
import '../scaffoldInfo.dart';

class ScaffoldHeader extends LegendWidget {
  const ScaffoldHeader({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, LegendTheme theme) {
    LegendScaffold scaffold = ScaffoldInfo.of(context).scaffold;

    AppBarLayout layout =
        ScaffoldInfo.of(context).getLayout(theme).appBarLayout;

    switch (layout.layout) {
      case AppBarLayoutConfig.fixedAbove:
        return LegendAppBar(
          type: layout.aligment,
          actions: scaffold.builders.appBarActions,
          config: LegendAppBarConfig(
            appBarHeight: theme.appBarSizing.appBarHeight,
            showSubMenu: scaffold.whether.showTopSubMenu,
            elevation: 1,
            pinned: true,
            horizontalPadding: theme.appBarSizing.contentPadding.left,
          ),
        );
      case AppBarLayoutConfig.none:
        return LegendAppBar(
          type: layout.aligment,
          actions: scaffold.builders.appBarActions,
          config: LegendAppBarConfig(
            appBarHeight: theme.appBarSizing.appBarHeight,
            elevation: 1,
            showSubMenu: scaffold.whether.showTopSubMenu,
            pinned: true,
            horizontalPadding: theme.appBarSizing.contentPadding.left,
          ),
        );

      default:
        return Container();
    }
  }
}
