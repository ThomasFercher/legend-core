import 'package:flutter/material.dart';
import 'package:legend_design_core/layout/scaffold/legend_scaffold.dart';
import 'package:legend_design_core/layout/scaffold/scaffoldInfo.dart';

class ScaffoldActionButton extends StatelessWidget {
  const ScaffoldActionButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    LegendScaffold scaffold = ScaffoldInfo.of(context).scaffold;
    return FloatingActionButton(
      onPressed: () {
        scaffold.onActionButtonPressed!(context);
      },
    );
  }
}
