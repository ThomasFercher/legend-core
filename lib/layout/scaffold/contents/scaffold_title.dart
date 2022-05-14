import 'package:flutter/material.dart';
import 'package:legend_design_core/styles/legend_theme.dart';
import 'package:legend_design_core/styles/typography/legend_text.dart';
import 'package:legend_router/router/legend_router.dart';
import 'package:legend_router/router/route_info_provider.dart';
import 'package:provider/provider.dart';
import '../../layout_provider.dart';

const double spacing = 6;

class ScaffoldTitle extends StatelessWidget {
  const ScaffoldTitle({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    LegendTheme theme = context.watch<LegendTheme>();
    LayoutProvider layoutProvider = LayoutProvider.of(context);
    Widget? logo = layoutProvider.logo;
    String? title = layoutProvider.title;

    bool showLogo = logo != null;
    bool showTitle = title != null;

    return GestureDetector(
      onTap: () {
        if (RouteInfoProvider.of(context).route.name != '/') {
          LegendRouter.of(context).pushPage(
            settings: const RouteSettings(name: '/'),
          );
        }
      },
      child: SizedBox(
        height: theme.sizing.appBarSizing.appBarHeight,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if (showLogo)
              Container(
                height: theme.appBarSizing.logoSize,
                child: LayoutProvider.of(context).logo,
              ),
            if (showLogo)
              const SizedBox(
                width: spacing,
              ),
            if (showTitle)
              LegendText(
                text: LayoutProvider.of(context).title!,
                textStyle: theme.typography.h6.copyWith(
                  color: theme.colors.appBarPalette.foreground,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
