import 'package:flutter/material.dart';
import 'legend_scaffold.dart';
import '../../router/legend_router.dart';

class ScaffoldFrame extends StatelessWidget {
  final PageRouteInfo page;
  final Widget child;

  const ScaffoldFrame({
    Key? key,
    required this.page,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LegendScaffold(
      builders: page.info.builders,
      layoutType: page.info.layoutType,
      appBarLayoutType: page.info.appBarLayoutType,
      sizing: page.info.sizing,
      whether: page.info.whether,
      child: child,
      pageName: "test",
    );
  }
}
