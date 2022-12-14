import 'package:flutter/material.dart';
import 'package:legend_design_core/layout/scaffold/routebody/widgets/fill_remaining_footer.dart';
import 'package:legend_design_core/layout/scaffold/routebody/route_body_info.dart';
import 'package:legend_design_core/state/legend_state.dart';

class BuilderBody extends LegendWidget {
  const BuilderBody({super.key});

  @override
  Widget build(BuildContext context, theme) {
    final routeBodyInfo = RouteBodyInfo.of(context);
    final routeBody = routeBodyInfo.info;
    final contentPadding = !routeBody.disableContentDecoration
        ? EdgeInsets.all(theme.sizing.spacing1)
        : EdgeInsets.zero;
    final width = routeBodyInfo.constraints.maxWidth;
    final contentSize = Size(
      width - contentPadding.horizontal,
      double.infinity,
    );
    final scrollController = routeBodyInfo.scrollController;

    return CustomScrollView(
      controller: scrollController,
      slivers: [
        if (routeBodyInfo.showSliverBar) routeBody.sliverAppBar!,
        if (routeBody.sliverPersistentHeader != null)
          SliverPersistentHeader(
            delegate: routeBody.sliverPersistentHeader!,
          ),
        SliverToBoxAdapter(
          child: Container(
            color: Colors.red,
            padding: contentPadding,
            child: Builder(
              builder: (context) => routeBody.builder!(
                context,
                contentSize,
              ),
            ),
          ),
        ),
        if (routeBodyInfo.showFooter) FillRemainingFooter()
      ],
    );
  }
}
