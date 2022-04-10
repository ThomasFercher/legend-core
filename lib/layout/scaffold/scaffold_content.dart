import 'package:flutter/material.dart';
import 'package:legend_design_core/layout/scaffold/scaffoldInfo.dart';
import 'package:legend_design_core/utils/extensions.dart';
import 'package:provider/provider.dart';

import '../../styles/legend_theme.dart';
import 'legend_scaffold.dart';

class ScaffoldContent extends StatelessWidget {
  const ScaffoldContent({
    Key? key,
    required this.maxHeight,
  }) : super(key: key);

  final double maxHeight;

  @override
  Widget build(BuildContext context) {
    LegendScaffold scaffold = ScaffoldInfo.of(context).scaffold;
    LegendTheme theme = context.watch<LegendTheme>();

    return Container(
      height: maxHeight,
      decoration: scaffold.disableContentDecoration
          ? null
          : BoxDecoration(
              color: theme.colors.background[0],
              borderRadius: theme.sizing.borderRadius[0],
            ),
      padding: scaffold.disableContentDecoration
          ? null
          : EdgeInsets.all(
              theme.sizing.padding[1],
            ),
      constraints: scaffold.singlePage
          ? BoxConstraints(
              minHeight: maxHeight -
                  (scaffold.disableContentDecoration
                      ? 0
                      : theme.sizing.padding[1] * 2),
            )
          : null,
      child: LayoutBuilder(
        builder: (context, constraints) {
          return Builder(
            builder: (context) {
              return scaffold.contentBuilder!(
                context,
                Size(
                  scaffold.maxContentWidth ?? constraints.maxWidth,
                  maxHeight -
                      (scaffold.disableContentDecoration
                          ? 0
                          : (theme.sizing.padding[1] * 2)),
                ),
              );
            },
          );
        },
      ),
    ).expandIf(scaffold.singlePage);
  }
}
