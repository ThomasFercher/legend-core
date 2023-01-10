import 'package:flutter/widgets.dart';
import 'package:legend_design_core/layout/scaffold/routebody/widgets/fill_remaining_footer.dart';
import 'package:legend_design_core/legend_design_core.dart';
import 'package:legend_design_core/state/legend_state.dart';

import '../route_body_info.dart';

class ChildrenBody extends LegendWidget {
  const ChildrenBody({
    super.key,
  });

  @override
  Widget build(BuildContext context, theme) {
    final routeBodyInfo = RouteBodyInfo.of(context);
    final routeBody = routeBodyInfo.info;
    final children = [
      for (final child in routeBody.children)
        Container(
          padding: EdgeInsets.symmetric(horizontal: theme.sizing.spacing1)
              .boolInit(!routeBody.disableContentDecoration),
          child: child,
        ),
    ];

    return SizedBox(
      height: routeBodyInfo.constraints.maxHeight,
      child: CustomScrollView(
        controller: routeBodyInfo.scrollController,
        slivers: [
          if (routeBodyInfo.showSliverBar) routeBody.sliverAppBar!,
          if (routeBody.sliverPersistentHeader != null)
            SliverPersistentHeader(
              delegate: routeBody.sliverPersistentHeader!,
            ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              childCount: children.length,
              (context, i) => children[i],
            ),
          ),
          if (routeBodyInfo.showFooter) FillRemainingFooter()
        ],
      ),
    );
  }
}
