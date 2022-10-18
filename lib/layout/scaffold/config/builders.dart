import 'package:flutter/widgets.dart';
import 'package:legend_design_core/layout/footer/fixed_footer.dart';
import 'package:legend_design_core/layout/scaffold/config/scaffold_config.dart';
import 'package:legend_design_core/styles/legend_theme.dart';

typedef ScaffoldBuilder = Widget Function(
    BuildContext context, LegendTheme theme);

class LegendScaffoldBuilder extends StatelessWidget {
  final ScaffoldBuilder builder;
  const LegendScaffoldBuilder({
    super.key,
    required this.builder,
  });

  @override
  Widget build(BuildContext context) {
    LegendTheme theme = LegendTheme.of(context);
    return Builder(
      builder: (context) => builder(context, theme),
    );
  }
}

class ScaffoldBuilders {
  final ScaffoldBuilder? appBarActions;
  final ScaffoldBuilder? menuDrawerActions;
  final FixedFooter? customFooter;
  final Widget? appBarBottom;
  final ScaffoldBuilder? siderBuilder;

  const ScaffoldBuilders({
    this.appBarActions,
    this.menuDrawerActions,
    this.customFooter,
    this.appBarBottom,
    this.siderBuilder,
  });

  factory ScaffoldBuilders.copyWith(
      ScaffoldBuilders base, ScaffoldBuilders copy) {
    return ScaffoldBuilders(
      appBarActions: base.appBarActions ?? copy.appBarActions,
      appBarBottom: base.appBarBottom ?? copy.appBarBottom,
      customFooter: base.customFooter ?? copy.customFooter,
      menuDrawerActions: base.menuDrawerActions ?? copy.menuDrawerActions,
      siderBuilder: base.siderBuilder ?? copy.siderBuilder,
    );
  }
}
