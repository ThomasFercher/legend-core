import 'package:flutter/cupertino.dart';
import 'package:legend_design_core/layout/config/layout_config.dart';
import 'package:legend_design_core/layout/footer/fixed_footer.dart';
import 'package:legend_design_core/layout/scaffold/legend_scaffold.dart';
import 'package:provider/provider.dart';
import '../../../styles/legend_theme.dart';

class ScaffoldFooter extends StatelessWidget {
  const ScaffoldFooter({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    LegendScaffold scaffold = ScaffoldInfo.of(context).scaffold;
    LegendTheme theme = context.watch<LegendTheme>();
    FooterLayout layout =
        scaffold.layout.getLayout(theme.sizingTheme.key).footerLayout;

    FixedFooter? override = scaffold.builders.customFooter;

    switch (layout) {
      case FooterLayout.None:
        return Container();
      case FooterLayout.Show:
        return override ?? Container();
    }
  }
}
