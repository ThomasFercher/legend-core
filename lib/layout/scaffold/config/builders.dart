import 'package:flutter/widgets.dart';
import 'package:legend_annotations/legend_annotations.dart';
import 'package:legend_design_core/styles/legend_theme.dart';

part 'builders.g.dart';

typedef ScaffoldBuilder = Widget Function(
  BuildContext context,
  LegendTheme theme,
);

ScaffoldBuilder nullBuilder = (_, __) => const SizedBox.shrink();

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

@LegendStyle()
abstract class ScaffoldBuildersStyle {
  final ScaffoldBuilder? appBarActions;
  final ScaffoldBuilder? menuDrawerActions;
  final Widget? customFooter;
  final Widget? appBarBottom;
  final ScaffoldBuilder? siderBuilder;

  const ScaffoldBuildersStyle({
    required this.appBarActions,
    required this.menuDrawerActions,
    required this.customFooter,
    required this.appBarBottom,
    required this.siderBuilder,
  });

  /* factory ScaffoldBuilders.copyWith(
      ScaffoldBuilders base, ScaffoldBuilders copy) {
    return ScaffoldBuilders(
      appBarActions: base.appBarActions ?? copy.appBarActions,
      appBarBottom: base.appBarBottom ?? copy.appBarBottom,
      customFooter: base.customFooter ?? copy.customFooter,
      menuDrawerActions: base.menuDrawerActions ?? copy.menuDrawerActions,
      siderBuilder: base.siderBuilder ?? copy.siderBuilder,
    );
  }*/
}
