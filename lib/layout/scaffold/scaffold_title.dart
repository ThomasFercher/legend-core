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
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              if (LayoutProvider.of(context)?.title != null)
                Container(
                  height: theme.appBarSizing.titleSize ??
                      theme.appBarSizing.appBarHeight,
                  width: theme.appBarSizing.titleSize,
                  margin: EdgeInsets.only(right: 12.0, left: 16.0),
                  child: Center(
                    child: LegendText(
                      text: LayoutProvider.of(context)!.title!,
                      textStyle: theme.typography.h6.copyWith(
                        color: theme.colors.appBarColors.foreground,
                      ),
                    ),
                  ),
                ),
              if (LayoutProvider.of(context)?.logo != null)
                Container(
                  height: theme.appBarSizing.appBarHeight,
                  alignment: Alignment.center,
                  child: LayoutProvider.of(context)!.logo,
                ),
            ],
          ),
        ),
      ),
    );
  }
}
