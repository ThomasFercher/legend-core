import 'package:flutter/widgets.dart';
import 'package:legend_design_core/layout/scaffold/contents/scaffold_footer.dart';
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

    return CustomScrollView(
      controller: routeBodyInfo.scrollController,
      slivers: [
        if (routeBody.sliverAppBar != null) routeBody.sliverAppBar!,
        SliverToBoxAdapter(
          child: Padding(
            padding: contentPadding,
            child: Builder(
              builder: (context) => routeBody.builder!(
                context,
                Size(routeBodyInfo.constraints.maxWidth, double.infinity),
              ),
            ),
          ),
        ),
        SliverFillRemaining(
          hasScrollBody: false,
        ),
      ],
    );
  }
}
