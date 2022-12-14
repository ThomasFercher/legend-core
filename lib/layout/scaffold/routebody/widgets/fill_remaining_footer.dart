import 'package:flutter/material.dart';
import 'package:legend_design_core/layout/scaffold/contents/scaffold_footer.dart';
import 'package:legend_design_core/state/legend_state.dart';

class FillRemainingFooter extends LegendWidget {
  @override
  Widget build(BuildContext context, LegendTheme theme) {
    final double footerHeight = theme.footerSizing.height;
    return SliverFillRemaining(
      hasScrollBody: false,
      child: Column(
        children: [
          Spacer(),
          ConstrainedBox(
            constraints: BoxConstraints.tightFor(height: footerHeight),
            child: const ScaffoldFooter(),
          ),
        ],
      ),
    );
  }
}
