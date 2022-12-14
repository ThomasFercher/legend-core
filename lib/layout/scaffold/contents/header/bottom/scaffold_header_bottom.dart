import 'package:flutter/material.dart';
import 'package:legend_design_core/layout/appBar.dart/appbar_layout.dart';
import 'package:legend_design_core/layout/menu_drawer/menu_drawer_appbar.dart';
import 'package:legend_design_core/layout/menu_drawer/menu_drawer_layout.dart';
import 'package:legend_design_core/layout/scaffold/contents/header/bottom/scaffold_tabbar.dart';
import 'package:legend_design_core/state/legend_state.dart';

class ScaffoldHeaderBottom extends LegendWidget {
  final MenuDrawerLayout? menuDrawerLayout;
  final AppBarLayout appbarLayout;

  ScaffoldHeaderBottom({
    required this.appbarLayout,
    required this.menuDrawerLayout,
    super.key,
  });

  @override
  Widget build(BuildContext context, LegendTheme theme) {
    final showTabbar =
        appbarLayout.showTabbar && theme.appBarSizing.tabbarSizing != null;
    final double tabbarHeight =
        showTabbar ? theme.appBarSizing.tabbarSizing!.height : 0;
    final showMenudrawer =
        menuDrawerLayout?.type == MenuDrawerLayoutType.beneathAppBar;

    return Column(
      children: [
        if (showTabbar)
          ScaffoldTabbar(
            height: tabbarHeight,
          ),
        if (showMenudrawer) MenuDrawerAppBar(),
      ],
    );
  }
}
