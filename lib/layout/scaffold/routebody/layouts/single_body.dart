import 'package:flutter/widgets.dart';
import 'package:legend_design_core/layout/scaffold/contents/scaffold_footer.dart';
import 'package:legend_design_core/layout/scaffold/routebody/route_body_info.dart';
import 'package:legend_design_core/state/legend_state.dart';

class SingleBody extends LegendWidget {
  const SingleBody({super.key});

  @override
  Widget build(BuildContext context, theme) {
    final routeBodyInfo = RouteBodyInfo.of(context);
    final routeBody = routeBodyInfo.info;
    final contentPadding = !routeBody.disableContentDecoration
        ? EdgeInsets.all(theme.sizing.spacing1)
        : EdgeInsets.zero;
    final footerHeight = routeBodyInfo.showFooter
        ? theme.scaffoldConfig.builders?.customFooter?.sizing?.height ?? 0
        : 0;
    return Column(
      children: [
        Expanded(
          child: Padding(
            padding: contentPadding,
            child: Builder(
              builder: (BuildContext context) {
                return routeBody.builder!(
                  context,
                  Size(
                    routeBodyInfo.constraints.maxWidth,
                    routeBodyInfo.constraints.maxHeight - footerHeight,
                  ),
                );
              },
            ),
          ),
        ),
        if (routeBodyInfo.showFooter) ScaffoldFooter(),
      ],
    );
  }
}
