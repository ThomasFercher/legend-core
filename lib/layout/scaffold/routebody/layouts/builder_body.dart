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

    final scrollController = routeBodyInfo.scrollController;

    final maxContentWidth = routeBody.maxContentWidth;
    final availableWidth = width - contentPadding.horizontal;
    final contentWidth =
        maxContentWidth != null && maxContentWidth < availableWidth
            ? maxContentWidth
            : availableWidth;
    final contentSize = Size(
      contentWidth,
      double.infinity,
    );

    return CustomScrollView(
      controller: scrollController,
      slivers: [
        if (routeBodyInfo.showSliverBar) routeBody.sliverAppBar!,
        if (routeBody.sliverPersistentHeader != null)
          SliverPersistentHeader(
            delegate: routeBody.sliverPersistentHeader!,
          ),
        SliverToBoxAdapter(
          child: Center(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                maxWidth: contentWidth,
              ),
              child: Padding(
                padding: contentPadding,
                child: Builder(
                  builder: (context) => routeBody.builder!(
                    context,
                    contentSize,
                  ),
                ),
              ),
            ),
          ),
        ),
        if (routeBodyInfo.showFooter) FillRemainingFooter()
      ],
    );
  }
}
