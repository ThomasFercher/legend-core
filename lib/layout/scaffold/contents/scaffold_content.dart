import 'package:flutter/material.dart';
import 'package:legend_design_core/layout/scaffold/scaffoldInfo.dart';
import 'package:legend_design_core/utils/extensions.dart';
import 'package:provider/provider.dart';

import '../../../styles/legend_theme.dart';
import '../legend_scaffold.dart';

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
    double paddingHeight = scaffold.whether.disableContentDecoration ?? false
        ? 0
        : theme.sizing.padding[1] * 2;
    double height = maxHeight - paddingHeight;

    Decoration? decoration = BoxDecoration(
      color: theme.colors.background[1],
      borderRadius: theme.sizing.borderRadius[0],
    ).boolInit(scaffold.whether.disableContentDecoration ?? false);

    EdgeInsetsGeometry? padding = EdgeInsets.all(
      theme.sizing.padding[1],
    ).boolInit(scaffold.whether.disableContentDecoration ?? false);

    BoxConstraints? constraints = BoxConstraints(
      minHeight: height,
    ).boolInit(scaffold.whether.singlePage ?? false);

    return Container(
      decoration: decoration,
      padding: padding,
      child: LayoutBuilder(
        builder: (context, constraints) {
          return Builder(
            builder: (context) {
              return scaffold.contentBuilder!(
                context,
                Size(
                  scaffold.sizing.maxContentWidth ?? constraints.maxWidth,
                  height,
                ),
              );
            },
          );
        },
      ),
    ).expandIf(scaffold.whether.singlePage ?? false);
  }
}
