import 'package:flutter/material.dart';
import 'package:legend_design_core/styles/legend_theme.dart';
import 'package:legend_design_core/styles/sizing/sub_sizing/footer/footer_sizing.dart';

import 'package:legend_design_core/state/legend_state.dart';

class FixedFooter extends LegendWidget {
  final FooterSizingStyle? sizing;
  final FooterColorsStyle? colors;
  final Widget Function(
    BuildContext context,
    FooterColorsStyle colors,
    FooterSizingStyle sizing,
  ) builder;

  FixedFooter({
    Key? key,
    required this.builder,
    this.sizing,
    this.colors,
  });
  @override
  Widget build(BuildContext context, LegendTheme theme) {
    FooterSizingStyle size = sizing ?? theme.sizing.footerSizing;
    FooterColorsStyle color = colors ?? theme.colors.footer;

    return Container(
      width: MediaQuery.of(context).size.width,
      height: size.height,
      color: color.background,
      alignment: Alignment.center,
      child: Container(
        constraints: BoxConstraints(
          maxWidth: size.maxWidth,
        ),
        padding: size.padding,
        child: Builder(
          builder: (context) => builder(context, color, size),
        ),
      ),
    );
  }
}
