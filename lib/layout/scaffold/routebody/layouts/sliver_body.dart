import 'package:flutter/widgets.dart';
import 'package:legend_design_core/layout/scaffold/routebody/route_body_info.dart';

class SliverBody extends StatelessWidget {
  const SliverBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final routeBodyInfo = RouteBodyInfo.of(context);
    final routeBody = routeBodyInfo.info;

    return Container(
      height: routeBodyInfo.constraints.maxHeight,
      child: CustomScrollView(
        controller: routeBodyInfo.scrollController,
        slivers: routeBody.slivers,
      ),
    );
  }
}
