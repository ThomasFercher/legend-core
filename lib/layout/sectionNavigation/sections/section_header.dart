import 'package:flutter/material.dart';
import 'package:legend_design_core/styles/legend_theme.dart';
import 'package:legend_design_core/typography/legend_text.dart';
import 'package:provider/provider.dart';

class SectionHeader extends StatelessWidget {
  final String text;
  final TextStyle? textStyle;
  const SectionHeader({Key? key, required this.text, this.textStyle})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    LegendTheme theme = context.watch<LegendTheme>();
    return Container(
      padding: EdgeInsets.only(bottom: 8.0),
      child: LegendText(
        text: text,
        textStyle: textStyle ??
            theme.typography.h4.copyWith(
              color: theme.colors.textOnLight,
            ),
      ),
    );
  }
}
