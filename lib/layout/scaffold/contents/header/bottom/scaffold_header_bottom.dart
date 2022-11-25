import 'package:flutter/material.dart';
import 'package:legend_design_core/layout/menu_drawer/menu_drawer_appbar.dart';
import 'package:legend_design_core/layout/menu_drawer/menu_drawer_layout.dart';
import 'package:legend_design_core/layout/scaffold/contents/header/bottom/scaffold_tabbar.dart';
import 'package:legend_design_core/layout/scaffold/scaffold_info.dart';
import 'package:legend_design_core/state/legend_state.dart';

class ScaffoldHeaderBottom extends StatelessWidget {
  const ScaffoldHeaderBottom({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final theme = LegendTheme.of(context);
    final layout = ScaffoldInfo.of(context)!.getLayout(theme);
    final appBarLayout = layout.appBarLayout;

    final showTabbar = (appBarLayout?.showTabbar ?? false) &&
        theme.appBarSizing.tabbarSizing != null;
    final showMenudrawer =
        layout.menuDrawerLayout?.type == MenuDrawerLayoutType.beneathAppBar;

    return Column(
      children: [
        if (showTabbar) ScaffoldTabbar(),
        if (showMenudrawer) MenuDrawerAppBar(),
      ],
    );
  }
}
