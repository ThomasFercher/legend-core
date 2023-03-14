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

    if (routeBody.listWrapper != null) {
      return routeBody.listWrapper!(
        CustomScrollView(
          physics: routeBody.physics,
          controller: routeBodyInfo.scrollController,
          slivers: [
            if (routeBodyInfo.showSliverBar) routeBody.sliverAppBar!,
            if (routeBody.sliverPersistentHeader != null)
              SliverPersistentHeader(
                delegate: routeBody.sliverPersistentHeader!,
              ),
            ...slivers(scrollController),
            if (routeBodyInfo.showFooter) FillRemainingFooter()
          ],
        ),
      );
    }

    return SizedBox(
      height: routeBodyInfo.constraints.maxHeight,
      child: CustomScrollView(
        physics: routeBody.physics,
        controller: routeBodyInfo.scrollController,
        slivers: [
          if (routeBodyInfo.showSliverBar) routeBody.sliverAppBar!,
          if (routeBody.sliverPersistentHeader != null)
            SliverPersistentHeader(
              delegate: routeBody.sliverPersistentHeader!,
            ),
          ...slivers(scrollController),
          if (routeBodyInfo.showFooter) FillRemainingFooter()
        ],
      ),
    );
  }
}
