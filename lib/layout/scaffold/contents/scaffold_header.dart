import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:legend_design_core/layout/appBar.dart/appbar_config.dart';
import 'package:legend_design_core/layout/appBar.dart/layout/appbar_layout.dart';
import 'package:legend_design_core/layout/appBar.dart/legend_appbar_fixed.dart';
import 'package:legend_design_core/layout/config/layout_config.dart';
import 'package:provider/provider.dart';
import '../../../styles/legend_theme.dart';
import '../../config/appbar_layout.dart';
import '../legend_scaffold.dart';

class ScaffoldHeader extends StatelessWidget {
  const ScaffoldHeader({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    LegendTheme theme = context.watch<LegendTheme>();
    LegendScaffold scaffold = ScaffoldInfo.of(context).scaffold;

    AppBarLayout layout =
        ScaffoldInfo.of(context).getLayout(theme).appBarLayout;

    switch (layout.layout) {
      case AppBarLayoutConfig.fixedAbove:
        return LegendAppBarFixed(
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
        return LegendAppBarFixed(
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
