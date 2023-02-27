import 'package:flutter/cupertino.dart';
import 'package:legend_design_core/layout/footer/fixed_footer.dart';
import 'package:legend_design_core/layout/footer/footer_layout.dart';
import 'package:legend_design_core/layout/scaffold/legend_scaffold.dart';
import 'package:legend_design_core/state/legend_state.dart';
import '../scaffold_info.dart';

class ScaffoldFooter extends LegendWidget {
  const ScaffoldFooter({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, LegendTheme theme) {
    LegendScaffold scaffold = ScaffoldInfo.of(context).scaffold;

    final layout =
        scaffold.dynamicLayout.getLayout(theme.sizing.key).footerLayout;

    FixedFooter? override = scaffold.builders.customFooter;

    if (layout is NoFooterLayout || override == null) {
      return SizedBox.shrink();
    }

    return override;
  }
}
