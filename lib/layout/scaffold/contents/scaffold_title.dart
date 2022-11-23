import 'package:flutter/material.dart';
import 'package:legend_router/legend_router.dart';
import '../../layout_provider.dart';
import 'package:legend_design_core/state/legend_state.dart';

class ScaffoldTitle extends LegendWidget {
  const ScaffoldTitle({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, LegendTheme theme) {
    final logo = LayoutProvider.of(context).getLogo(context);
    return GestureDetector(
      onTap: () {
        if (RouteInfoProvider.of(context).route.name != '/') {
          LegendRouter.of(context).pushPage('/');
        }
      },
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxHeight: theme.appBarSizing.logoSize,
        ),
        child: logo,
      ),
    );
  }
}
