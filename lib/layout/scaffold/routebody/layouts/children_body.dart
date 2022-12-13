import 'package:flutter/widgets.dart';
import 'package:legend_design_core/layout/scaffold/contents/scaffold_footer.dart';
import 'package:legend_design_core/layout/scaffold/routebody/layouts/decoration/inner_elevation.dart';
import 'package:legend_design_core/legend_design_core.dart';
import 'package:legend_design_core/libraries/scaffold.dart';
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
    final bool showFooter = ScaffoldInfo.of(context)!.showFooter(context);
    final double footerHeight = showFooter ? theme.footerSizing.height : 0;

    return Container(
      height: routeBodyInfo.constraints.maxHeight,
      child: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return [
            if (routeBodyInfo.showSliverBar) routeBody.sliverAppBar!,
            if (routeBody.sliverPersistentHeader != null)
              SliverPersistentHeader(
                delegate: routeBody.sliverPersistentHeader!,
              ),
          ];
        },
        controller: routeBodyInfo.scrollController,
        body: InnerElevation(
          child: CustomScrollView(
            slivers: [
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  childCount: children.length,
                  (context, i) => children[i],
                ),
              ),
              SliverFillRemaining(
                child: SizedBox.shrink(),
              ),
              if (showFooter)
                SliverToBoxAdapter(
                  child: ConstrainedBox(
                    constraints: BoxConstraints.tightFor(height: footerHeight),
                    child: const ScaffoldFooter(),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
