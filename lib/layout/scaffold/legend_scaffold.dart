export 'package:legend_design_core/layout/scaffold/scaffoldInfo.dart';

import 'package:flutter/material.dart';
import 'package:legend_design_core/layout/appBar.dart/layout/appbar_layout.dart';
import 'package:legend_design_core/layout/bottomBar.dart/legend_bottom_bar.dart';
import 'package:legend_design_core/layout/config/layout_config.dart';
import 'package:legend_design_core/layout/scaffold/contents/scaffold_header.dart';
import 'package:legend_design_core/layout/scaffold/scaffoldInfo.dart';
import 'package:legend_router/router/legend_router.dart';
import 'package:legend_design_core/styles/legend_theme.dart';
import 'package:legend_design_core/layout/scaffold/config/scaffold_config.dart';
import 'package:legend_design_core/styles/sizing/size_info.dart';
import 'package:legend_utils/extensions/extensions.dart';
import 'package:provider/provider.dart';
import 'contents/scaffold_sider.dart';

class LegendScaffold extends StatelessWidget {
  // Layout
  final AppBarLayoutType appBarLayoutType;

  // Core
  final String pageName;
  final Widget child;

  final DynamicRouteLayout layout;

  // Configs
  final ScaffoldBuilders builders;
  final ScaffoldWhether whether;
  final ScaffoldSizing sizing;

  LegendScaffold({
    required this.pageName,
    required this.child,
    required this.layout,
    this.appBarLayoutType = AppBarLayoutType.TiMeAc,
    this.whether = const ScaffoldWhether(),
    this.builders = const ScaffoldBuilders(),
    this.sizing = const ScaffoldSizing(),
  });

  /// Copies the config onto to the base
  /// If one attribute is not null in config it will override the same attribute from base
  factory LegendScaffold.withConfig(
      LegendScaffold base, ScaffoldConfig config) {
    return LegendScaffold(
      layout: base.layout,
      appBarLayoutType: config.appBarLayoutType != null
          ? config.appBarLayoutType!
          : base.appBarLayoutType,
      pageName: base.pageName,
      child: base.child,
      builders: config.builders != null
          ? ScaffoldBuilders.copyWith(base.builders, config.builders!)
          : base.builders,
      sizing: config.sizing != null
          ? ScaffoldSizing.copyWith(base.sizing, config.sizing!)
          : base.sizing,
      whether: config.whether != null
          ? ScaffoldWhether.copyWith(base.whether, config.whether!)
          : base.whether,
    );
  }

  @override
  Widget build(BuildContext context) {
    LegendTheme theme = context.watch<LegendTheme>();
    ScaffoldConfig? config = theme.scaffoldConfig;

    return ScaffoldInfo(
      scaffold: config != null ? LegendScaffold.withConfig(this, config) : this,
      child: SizeInfo(
        sizing: theme.sizingTheme,
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Builder(builder: (context) {
          // Bottom Bar Layout
          BottomBarLayout bottomBarLayout = ScaffoldInfo.of(context)
              .scaffold
              .layout
              .getLayout(theme.sizingTheme.key)
              .bottomBarLayout;
          bool showBottomBar = bottomBarLayout == BottomBarLayout.Show;

          return Scaffold(
            bottomNavigationBar: LegendBottomBar(
              colors: theme.bottomBarPalette,
              sizing: theme.bottomBarSizing!,
              options: LegendRouter.of(context).routeDisplays,
            ).boolInit(showBottomBar),
            endDrawerEnableOpenDragGesture: false,
            appBar: _appBar(context, theme),
            body: ColoredBox(
              color: theme.colors.background[0],
              child: Row(
                children: [
                  ScaffoldSider(),
                  Expanded(
                    child: Container(
                      child: child,
                    ),
                  )
                ],
              ),
            ),
          );
        }),
      ),
    );
  }

  PreferredSize? _appBar(BuildContext context, LegendTheme theme) {
    AppbarLayout l = layout.getLayout(theme.sizingTheme.key).appBarLayout;
    if (l == AppbarLayout.FixedAbove) {
      return PreferredSize(
        child: ScaffoldHeader(),
        preferredSize: Size(
          MediaQuery.of(context).size.width,
          theme.appBarSizing.appBarHeight,
        ),
      );
    } else {
      return null;
    }
  }
}
