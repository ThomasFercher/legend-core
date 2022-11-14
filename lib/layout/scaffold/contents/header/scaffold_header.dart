import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:legend_design_core/layout/appBar.dart/appbar_config.dart';
import 'package:legend_design_core/layout/appBar.dart/appbar_provider.dart';
import 'package:legend_design_core/layout/appBar.dart/legend_appbar.dart';
import 'package:legend_design_core/layout/menu_drawer/menu_drawer_layout.dart';
import 'package:legend_design_core/layout/scaffold/contents/header/bottom/scaffold_header_bottom.dart';
import 'package:legend_design_core/legend_design_core.dart';
import 'package:legend_design_core/styles/platform_info.dart';
import '../../../appBar.dart/appbar_layout_config.dart';
import 'package:legend_design_core/state/legend_state.dart';
import '../../scaffoldInfo.dart';

class ScaffoldHeader extends StatelessWidget {
  final BuildContext context;

  ScaffoldHeader({
    super.key,
    required this.context,
  });

  @override
  Widget build(BuildContext context) {
    final scaffold = ScaffoldInfo.of(context).scaffold;
    final theme = LegendTheme.of(context);
    final layout = ScaffoldInfo.of(context).getLayout(theme).appBarLayout;
    final showBackButton = !PlatformInfo.isWeb &&
        !LegendRouter.of(context).isFirstOnStack() &&
        scaffold.whether.showBackButton;

    if (layout == null || layout.layout == AppBarLayoutConfig.body) {
      return PreferredSize(
        preferredSize: Size.zero,
        child: SizedBox.shrink(),
      );
    }

    return LegendAppBar(
      type: layout.aligment,
      actions: scaffold.builders.appBarActions,
      showBackButton: showBackButton,
      bottom: ScaffoldHeaderBottom(),
      config: LegendAppBarConfig(
        appBarHeight: theme.appBarSizing.appBarHeight,
        showSubMenu: scaffold.whether.showTopSubMenu,
        elevation: 1,
        pinned: true,
        horizontalPadding: theme.appBarSizing.contentPadding.left,
      ),
    );
  }
}
