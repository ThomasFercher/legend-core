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
    double paddingHeight =
        scaffold.disableContentDecoration ? 0 : theme.sizing.padding[1] * 2;
    double height = maxHeight - paddingHeight;

    Decoration? decoration = BoxDecoration(
      color: theme.colors.background[0],
      borderRadius: theme.sizing.borderRadius[0],
    ).boolInit(!scaffold.disableContentDecoration);

    EdgeInsetsGeometry? padding = EdgeInsets.all(
      theme.sizing.padding[1],
    ).boolInit(!scaffold.disableContentDecoration);

    BoxConstraints? constraints = BoxConstraints(
      minHeight: height,
    ).boolInit(scaffold.singlePage);

    return Container(
      decoration: decoration,
      padding: padding,
      constraints: constraints,
      child: LayoutBuilder(
        builder: (context, constraints) {
          return Builder(
            builder: (context) {
              return scaffold.contentBuilder!(
                context,
                Size(
                  scaffold.maxContentWidth ?? constraints.maxWidth,
                  height,
                ),
              );
            },
          );
        },
      ),
    ).expandIf(scaffold.singlePage);
  }
}
