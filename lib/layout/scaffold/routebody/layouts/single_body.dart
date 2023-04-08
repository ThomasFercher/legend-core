import 'package:flutter/widgets.dart';
import 'package:legend_design_core/layout/scaffold/contents/scaffold_footer.dart';
import 'package:legend_design_core/layout/scaffold/routebody/route_body_info.dart';
import 'package:legend_design_core/layout/scaffold/scaffold_info.dart';
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
    final showFooter = ScaffoldInfo.of(context).showFooter(context);

    return Column(
      children: [
        Expanded(
          child: Padding(
            padding: contentPadding,
            child: LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) {
                return routeBody.builder!(context, constraints.biggest);
              },
            ),
          ),
        ),
        if (showFooter) ScaffoldFooter()
      ],
    );
  }
}
