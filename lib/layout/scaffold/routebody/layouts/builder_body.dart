import 'package:flutter/widgets.dart';
import 'package:legend_design_core/layout/scaffold/contents/scaffold_footer.dart';
import 'package:legend_design_core/layout/scaffold/routebody/layouts/decoration/inner_elevation.dart';
import 'package:legend_design_core/layout/scaffold/routebody/route_body_info.dart';
import 'package:legend_design_core/libraries/scaffold.dart';
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

    final bool showFooter = ScaffoldInfo.of(context)!.showFooter(context);
    final double footerHeight = showFooter ? theme.footerSizing.height : 0;

    return NestedScrollView(
      headerSliverBuilder: (context, innerBoxIsScrolled) {
        return [
          if (routeBodyInfo.showSliverBar) routeBody.sliverAppBar!,
          if (routeBody.sliverPersistentHeader != null)
            SliverPersistentHeader(
              delegate: routeBody.sliverPersistentHeader!,
            ),
        ];
      },
      controller: scrollController,
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
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
          if (showFooter)
            SliverFillRemaining(
              child: Column(
                children: [
                  Spacer(),
                  ConstrainedBox(
                    constraints: BoxConstraints.tightFor(height: footerHeight),
                    child: const ScaffoldFooter(),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
