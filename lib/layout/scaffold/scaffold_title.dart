import 'package:flutter/material.dart';
import 'package:legend_design_core/styles/theming/theme_provider.dart';
import 'package:legend_design_core/typography/legend_text.dart';
import 'package:provider/provider.dart';

import '../layout_provider.dart';

class ScaffoldTitle extends StatelessWidget {
  const ScaffoldTitle({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeProvider theme = context.watch<ThemeProvider>();

    return Positioned(
      left: theme.appBarSizing.contentPadding.horizontal,
      top: theme.appBarSizing.contentPadding.top,
      child: Material(
        color: Colors.transparent,
        child: Hero(
          tag: ValueKey('title'),
          child: SizedBox(
            height: theme.sizing.appBarSizing.appBarHeight,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                if (LayoutProvider.of(context)?.logo != null)
                  Container(
                    margin: const EdgeInsets.only(
                      right: 12.0,
                      left: 16.0,
                    ),
                    child: Container(
                      height: theme.appBarSizing.titleSize,
                      child: LayoutProvider.of(context)!.logo,
                    ),
                  ),
                if (LayoutProvider.of(context)?.title != null)
                  Container(
                    alignment: Alignment.center,
                    height: theme.appBarSizing.titleSize,
                    child: LegendText(
                      text: LayoutProvider.of(context)!.title!,
                      textStyle: theme.typography.h6.copyWith(
                        color: theme.colors.appBarColors.foreground,
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
