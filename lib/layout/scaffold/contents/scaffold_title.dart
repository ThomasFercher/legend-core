import 'package:flutter/material.dart';
import 'package:legend_design_core/styles/legend_theme.dart';
import 'package:legend_design_core/typography/legend_text.dart';
import 'package:provider/provider.dart';

import '../../layout_provider.dart';

const double spacing = 6;

class ScaffoldTitle extends StatelessWidget {
  const ScaffoldTitle({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    LegendTheme theme = context.watch<LegendTheme>();

    return Positioned(
      left: theme.appBarSizing.contentPadding.left,
      // top: theme.appBarSizing.contentPadding.top,
      child: SizedBox(
        height: theme.sizing.appBarSizing.appBarHeight,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            if (LayoutProvider.of(context)?.logo != null)
              Container(
                margin: const EdgeInsets.only(
                  right: spacing,
                ),
                child: Container(
                  height: theme.appBarSizing.logoSize,
                  child: LayoutProvider.of(context)!.logo,
                ),
              ),
            if (LayoutProvider.of(context)?.title != null)
              Container(
                alignment: Alignment.center,
                height: theme.appBarSizing.logoSize,
                child: LegendText(
                  text: LayoutProvider.of(context)!.title!,
                  textStyle: theme.typography.h6.copyWith(
                    color: theme.colors.appBarPalette.foreground,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
