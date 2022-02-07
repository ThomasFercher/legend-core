import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import '../../styles/theming/sizing/size_provider.dart';
import '../drawers/legend_drawer.dart';
import '../drawers/legend_drawer_info.dart';
import '../drawers/legend_drawer_provider.dart';

class ScaffoldDrawer extends StatelessWidget {
  const ScaffoldDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return getDrawer(context);
  }

  Widget getDrawer(BuildContext context) {
    List<LegendDrawerRoute> routes = Provider.of<LegendDrawerProvider>(context)
        .drawerRoutes
        .cast<LegendDrawerRoute>();
    for (final LegendDrawerRoute route in routes) {
      if (route.visible) {
        return LegendDrawer(
          route: route,
          isMobile: SizeProvider.of(context).isMobile,
        );
      }
    }
    return Container();
  }
}
