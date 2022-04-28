export 'package:legend_design_core/layout/scaffold/scaffoldInfo.dart';

import 'package:flutter/material.dart';
import 'package:legend_design_core/layout/scaffold/scaffoldInfo.dart';
import 'package:legend_design_core/layout/scaffold/scaffold_frame.dart';
import 'package:legend_design_core/styles/layouts/layout_type.dart';
import 'package:legend_design_core/styles/legend_theme.dart';
import 'package:legend_design_core/layout/scaffold/config/scaffold_config.dart';
import 'package:legend_design_core/styles/sizing/size_info.dart';
import 'package:provider/provider.dart';

class LegendScaffold extends StatelessWidget {
  // Core
  final LayoutType layoutType;
  final String pageName;
  final Widget Function(BuildContext context, Size size)? contentBuilder;
  final List<Widget> children;
  final void Function(BuildContext context)? onActionButtonPressed;

  // Configs
  final ScaffoldBuilders builders;
  final ScaffoldWhether whether;
  final ScaffoldSizing sizing;

  LegendScaffold({
    required this.pageName,
    required this.layoutType,
    this.onActionButtonPressed,
    this.contentBuilder,
    this.children = const [],
    this.whether = const ScaffoldWhether(),
    this.builders = const ScaffoldBuilders(),
    this.sizing = const ScaffoldSizing(),
  });

  /// Copies the config onto to the base
  /// If one attribute is not null in config it will override the same attribute from base
  factory LegendScaffold.withConfig(
      LegendScaffold base, ScaffoldConfig config) {
    return LegendScaffold(
      pageName: base.pageName,
      layoutType: base.layoutType,
      children: base.children,
      onActionButtonPressed: base.onActionButtonPressed,
      contentBuilder: base.contentBuilder,
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
        useMobilDesign: true,
        child: ScaffoldFrame(),
      ),
    );
  }
}
