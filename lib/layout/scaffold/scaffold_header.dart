import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:legend_design_core/layout/fixed/appBar.dart/appbar_config.dart';
import 'package:legend_design_core/layout/fixed/appBar.dart/legend_appbar.dart';
import 'package:legend_design_core/layout/scaffold/scaffoldInfo.dart';
import 'package:provider/provider.dart';

import '../../styles/layouts/layout_type.dart';
import '../../styles/legend_theme.dart';
import '../fixed/appBar.dart/fixed_appbar.dart';
import 'legend_scaffold.dart';

class ScaffoldHeader extends StatelessWidget {
  const ScaffoldHeader({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    LegendTheme theme = context.watch<LegendTheme>();
    LegendScaffold scaffold = ScaffoldInfo.of(context).scaffold;

    bool bottomBar = theme.sizing.showBottomBar;
    bool showMenu = !bottomBar && scaffold.showAppBarMenu;

    switch (scaffold.layoutType) {
      case LayoutType.FixedHeaderSider:
        return FixedAppBar(
          showMenu: showMenu,
          layoutType: scaffold.layoutType,
          showSubMenu: scaffold.showTopSubMenu,
          forceElevate: scaffold.appBarForceElevate,
          context: context,
        );
      case LayoutType.FixedHeader:
        return LegendAppBar(
          actions: scaffold.appBarActions,
          config: LegendAppBarConfig(
            appBarHeight: theme.appBarSizing.appBarHeight,
            elevation: 1,
            pinned: true,
            horizontalPadding: theme.appBarSizing.contentPadding.left,
          ),
        );
      default:
        return SliverToBoxAdapter(
          child: Container(),
        );
    }
  }
}
