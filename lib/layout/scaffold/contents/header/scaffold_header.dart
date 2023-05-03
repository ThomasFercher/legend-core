import 'package:flutter/material.dart';
import 'package:legend_design_core/layout/appBar.dart/appbar_config.dart';
import 'package:legend_design_core/layout/appBar.dart/legend_appbar.dart';
import 'package:legend_design_core/layout/scaffold/contents/header/bottom/scaffold_header_bottom.dart';
import 'package:legend_design_core/legend_design_core.dart';
import 'package:legend_design_core/styles/platform_info.dart';
import '../../../appBar.dart/appbar_layout.dart';
import 'package:legend_design_core/state/legend_state.dart';
import '../../scaffold_info.dart';

class ScaffoldHeader extends StatelessWidget {
  final BuildContext context;
  final AppBarLayout layout;

  ScaffoldHeader({super.key, required this.context, required this.layout});

  @override
  Widget build(BuildContext context) {
    final info = ScaffoldInfo.of(context);
    final scaffold = info.scaffold;
    final theme = LegendTheme.of(context);
    final showBackButton = !PlatformInfo.isWeb &&
        !LegendRouter.of(context).isFirstOnStack &&
        scaffold.config.whether.showBackButton;

    return LegendAppBar(
      type: layout.aligment,
      actions: scaffold.config.builders.appBarActions,
      showBackButton: showBackButton,
      showMenu: scaffold.config.whether.showAppBarMenu,
      bottom: ScaffoldHeaderBottom(
        appbarLayout: info.routeLayout.appBarLayout,
        menuDrawerLayout: info.routeLayout.menuDrawerLayout,
      ),
      config: LegendAppBarConfig(
        appBarHeight: theme.appBarSizing.appBarHeight,
        showSubMenu: scaffold.config.whether.showTopSubMenu,
        elevation: 1,
        pinned: true,
        horizontalPadding: theme.appBarSizing.contentPadding.left,
      ),
    );
  }
}
