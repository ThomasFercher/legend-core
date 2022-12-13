import 'package:flutter/widgets.dart';
import 'package:legend_design_core/layout/scaffold/routebody/layouts/decoration/inner_elevation.dart';
import 'package:legend_design_core/layout/scaffold/routebody/route_body_info.dart';
import 'package:legend_design_core/state/legend_state.dart';

class SliverBody extends LegendWidget {
  const SliverBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, theme) {
    final routeBodyInfo = RouteBodyInfo.of(context);
    final routeBody = routeBodyInfo.info;

    return Container(
      height: routeBodyInfo.constraints.maxHeight,
      child: InnerElevation(
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
          body: InnerElevation(
            child: CustomScrollView(
              controller: routeBodyInfo.scrollController,
              slivers: routeBody.slivers,
            ),
          ),
        ),
      ),
    );
  }
}
