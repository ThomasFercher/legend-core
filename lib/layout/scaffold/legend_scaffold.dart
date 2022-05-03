export 'package:legend_design_core/layout/scaffold/scaffoldInfo.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:legend_design_core/layout/fixed/appBar.dart/layout/appbar_layout.dart';
import 'package:legend_design_core/layout/fixed/bottomBar.dart/legend_bottom_bar.dart';
import 'package:legend_design_core/layout/scaffold/contents/scaffold_header_fixed.dart';
import 'package:legend_design_core/layout/scaffold/scaffoldInfo.dart';
import 'package:legend_design_core/layout/scaffold/scaffold_frame.dart';
import 'package:legend_design_core/router/legend_router.dart';
import 'package:legend_design_core/styles/layouts/layout_type.dart';
import 'package:legend_design_core/styles/legend_theme.dart';
import 'package:legend_design_core/layout/scaffold/config/scaffold_config.dart';
import 'package:legend_design_core/styles/sizing/size_info.dart';
import 'package:legend_design_core/utils/extensions.dart';
import 'package:provider/provider.dart';

import '../drawers/menu_drawer.dart';
import 'contents/scaffold_sider.dart';

class LegendScaffold extends StatelessWidget {
  // Layout
  final LayoutType layoutType;
  final AppBarLayoutType appBarLayoutType;

  // Core
  final String pageName;
  final Widget child;

  // Configs
  final ScaffoldBuilders builders;
  final ScaffoldWhether whether;
  final ScaffoldSizing sizing;

  LegendScaffold({
    required this.pageName,
    required this.child,
    this.layoutType = LayoutType.FixedHeader,
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
      appBarLayoutType: config.appBarLayoutType != null
          ? config.appBarLayoutType!
          : base.appBarLayoutType,
      pageName: base.pageName,
      layoutType:
          config.layoutType != null ? config.layoutType! : base.layoutType,
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
          bool showBottomBar = theme.sizing.showBottomBar;
          return Scaffold(
            bottomNavigationBar: LegendBottomBar(
              colors: theme.bottomBarPalette,
              sizing: theme.bottomBarSizing!,
              options: LegendRouter.of(context).menuOptions,
            ).boolInit(showBottomBar),
            endDrawerEnableOpenDragGesture: false,
            appBar: PreferredSize(
              preferredSize: Size(
                MediaQuery.of(context).size.width,
                theme.appBarSizing.appBarHeight,
              ),
              child: ScaffoldHeaderFixed(),
            ).boolInit(
              layoutType == LayoutType.FixedHeader ||
                  layoutType == LayoutType.FixedHeaderSider,
            ),
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
}
