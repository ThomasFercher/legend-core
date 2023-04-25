import 'package:flutter/widgets.dart';
import 'package:legend_design_core/layout/scaffold/routebody/legend_route_body.dart';
import 'package:legend_design_core/layout/scaffold/routebody/widgets/fill_remaining_footer.dart';
import 'package:legend_design_core/state/legend_state.dart';

import '../route_body_info.dart';

class ChildrenBody extends LegendWidget {
  final ChildrenBuilder children;

  const ChildrenBody({
    required this.children,
    super.key,
  });

  @override
  Widget build(BuildContext context, theme) {
    final routeBodyInfo = RouteBodyInfo.of(context);
    final routeBody = routeBodyInfo.info;
    final scrollController = routeBodyInfo.scrollController;
    final _children =
        children(scrollController, routeBodyInfo.constraints.biggest);

    if (routeBody.listWrapper != null) {
      return routeBody.listWrapper!(
        CustomScrollView(
          physics: routeBody.physics,
          controller: scrollController,
          slivers: [
            if (routeBodyInfo.showSliverBar) routeBody.sliverAppBar!,
            if (routeBody.sliverPersistentHeader != null)
              SliverPersistentHeader(
                delegate: routeBody.sliverPersistentHeader!,
              ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                childCount: _children.length,
                (context, i) => _children[i],
              ),
            ),
            if (routeBodyInfo.showFooter) FillRemainingFooter()
          ],
        ),
        scrollController,
        context,
      );
    }
    final maxWidth = routeBodyInfo.constraints.maxWidth;
    final maxContentWidth = routeBody.maxContentWidth;
    final hasToBeCentered =
        maxContentWidth != null && maxWidth > maxContentWidth;
    final inset = hasToBeCentered ? (maxWidth - maxContentWidth) / 2 : 0.0;
    final _padding = routeBodyInfo.info.contentPadding ?? EdgeInsets.zero;
    final padding = _padding.copyWith(
      left: _padding.left + inset,
      right: _padding.right + inset,
    );

    return SizedBox(
      height: routeBodyInfo.constraints.maxHeight,
      width: maxWidth,
      child: CustomScrollView(
        physics: routeBody.physics,
        controller: scrollController,
        slivers: [
          if (routeBodyInfo.showSliverBar) routeBody.sliverAppBar!,
          if (routeBody.sliverPersistentHeader != null)
            SliverPersistentHeader(
              delegate: routeBody.sliverPersistentHeader!,
            ),
          SliverPadding(
            padding: padding,
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
                childCount: _children.length,
                (context, i) => _children[i],
              ),
            ),
          ),
          if (routeBodyInfo.showFooter) FillRemainingFooter()
        ],
      ),
    );
  }
}
