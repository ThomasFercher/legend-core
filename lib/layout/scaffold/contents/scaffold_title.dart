import 'package:flutter/material.dart';
import 'package:legend_design_core/styles/legend_theme.dart';
import 'package:legend_router/router/legend_router.dart';
import 'package:legend_router/router/route_info_provider.dart';
import 'package:provider/provider.dart';
import '../../layout_provider.dart';

class ScaffoldTitle extends StatelessWidget {
  const ScaffoldTitle({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    LegendTheme theme = context.watch<LegendTheme>();

    return GestureDetector(
      onTap: () {
        if (RouteInfoProvider.of(context).route.name != '/') {
          LegendRouter.of(context).pushPage(
            settings: const RouteSettings(name: '/'),
          );
        }
      },
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxHeight: theme.appBarSizing.logoSize,
        ),
        child: LayoutProvider.of(context).logo,
      ),
    );
  }
}
