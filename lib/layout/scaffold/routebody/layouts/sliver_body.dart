import 'package:flutter/widgets.dart';
import 'package:legend_design_core/layout/scaffold/routebody/widgets/fill_remaining_footer.dart';
import 'package:legend_design_core/layout/scaffold/routebody/route_body_info.dart';
import 'package:legend_design_core/libraries/scaffold.dart';
import 'package:legend_design_core/state/legend_state.dart';

class SliverBody extends LegendWidget {
  final SliverBuilder slivers;

  const SliverBody({required this.slivers, super.key});

  @override
  Widget build(BuildContext context, theme) {
    final routeBodyInfo = RouteBodyInfo.of(context);
    final routeBody = routeBodyInfo.info;
    final scrollController = routeBodyInfo.scrollController;
    final width = routeBodyInfo.constraints.maxWidth;
    final maxWidth = routeBody.maxContentWidth;

    final hasToBeCentered = maxWidth != null && width > maxWidth;
    final inset = hasToBeCentered ? (width - maxWidth) / 2 : 0.0;
    final _padding = routeBodyInfo.info.contentPadding ?? EdgeInsets.zero;
    final padding = _padding.copyWith(
      left: _padding.left + inset,
      right: _padding.right + inset,
    );

    final widget = SizedBox(
      height: routeBodyInfo.constraints.maxHeight,
      width: width,
      child: CustomScrollView(
        physics: routeBody.physics,
        controller: routeBodyInfo.scrollController,
        slivers: [
          if (routeBodyInfo.showSliverBar) routeBody.sliverAppBar!,
          if (routeBody.sliverPersistentHeader != null)
            SliverPersistentHeader(
              delegate: routeBody.sliverPersistentHeader!,
            ),
          ...slivers(scrollController).map(
            (sliver) => SliverPadding(
              padding: padding,
              sliver: sliver,
            ),
          ),
          if (routeBodyInfo.showFooter) FillRemainingFooter()
        ],
      ),
    );

    if (routeBody.listWrapper != null) {
      return routeBody.listWrapper!(
        widget,
        scrollController,
        context,
      );
    }
    return widget;
  }
}
