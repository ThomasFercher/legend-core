import 'package:flutter/widgets.dart';
import 'package:legend_design_core/layout/footer/fixed_footer.dart';

class ScaffoldBuilders {
  final Widget Function(BuildContext context)? appBarActions;
  final Widget Function(BuildContext context)? menuDrawerActions;
  final FixedFooter? customFooter;
  final Widget? appBarBottom;
  final WidgetBuilder? siderBuilder;

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
