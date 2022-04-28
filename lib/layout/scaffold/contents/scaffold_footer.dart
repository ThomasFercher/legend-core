import 'package:flutter/cupertino.dart';
import 'package:legend_design_core/layout/scaffold/scaffoldInfo.dart';
import 'package:legend_design_core/layout/scaffold/legend_scaffold.dart';

import '../../layout_provider.dart';

class ScaffoldFooter extends StatelessWidget {
  const ScaffoldFooter({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return getFooter(context);
  }

  Widget getFooter(BuildContext context) {
    LegendScaffold scaffold = ScaffoldInfo.of(context).scaffold;

    if (scaffold.builders.customFooter == null) {
      return LayoutProvider.of(context)?.globalFooter ?? Container();
    } else {
      return scaffold.builders.customFooter!;
    }
  }
}
