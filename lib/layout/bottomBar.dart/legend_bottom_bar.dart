import 'package:flutter/material.dart';
import 'package:legend_design_core/layout/bottomBar.dart/bottom_bar_item.dart';
import 'package:legend_design_core/layout/bottomBar.dart/bottom_bar_provider.dart';
import 'package:legend_design_core/state/legend_state.dart';
import 'package:legend_design_core/widgets/size_info.dart';
import 'package:legend_router/router/legend_router.dart';
import 'package:legend_design_core/styles/legend_theme.dart';
import 'package:legend_design_core/styles/platform_info.dart';
import 'package:legend_router/router/routes/route_display.dart';
import 'package:legend_utils/legend_utils.dart';
import 'package:provider/provider.dart';

const double iosBottomPadding = 12;
const Duration anmimationDuration = Duration(milliseconds: 220);

class LegendBottomBar extends LegendWidget {
  final bool? fit;
  final BottomBarSizingStyle sizing;
  final BottomBarColorsStyle colors;
  final List<RouteDisplay> options;

  LegendBottomBar({
    Key? key,
    this.fit,
    required this.sizing,
    required this.colors,
    required this.options,
  }) : super(key: key);

  List<BottomBarItem> getItems(
    BuildContext context,
    BottomBarProvider provider,
  ) {
    List<BottomBarItem> items = [];
    final int sel = provider.selectedIndex;

    for (int i = 0; i < options.length; i++) {
      final RouteDisplay option = options[i];
      BottomBarItem w = BottomBarItem(
        width: sizing.itemWidth,
        isSelected: i == sel,
        option: option,
        onSelected: (o) {
          provider.selected = i;
          LegendRouter.of(context).pushPage(
            settings: RouteSettings(name: option.route),
          );
        },
        sizing: sizing,
        colors: colors,
      );
      items.add(w);
    }

    return items;
  }

  @override
  Widget build(BuildContext context, LegendTheme theme) {
    double padding = MediaQuery.of(context).padding.bottom;
    if (PlatformInfo.isIos) {
      padding =
          (padding - iosBottomPadding) > 0 ? (padding - iosBottomPadding) : 0;
    }

    double spacing =
        (SizeInfo.of(context).width - (options.length) * sizing.itemWidth) /
            (options.length + 1);

    bool fillBottom = sizing.fillBottom;

    return Consumer<BottomBarProvider>(
      builder: (context, provider, child) {
        int selected = provider.selectedIndex;
        double left = selected * sizing.itemWidth + (selected + 1) * spacing;

        return SizedBox(
          height: sizing.margin.vertical + sizing.height + padding,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                margin: sizing.margin,
                height: sizing.height,
                decoration: sizing.decoration.copyWith(
                  color: colors.backgroundColor,
                ),
                padding: sizing.padding,
                child: Stack(
                  children: [
                    AnimatedPositioned(
                      duration: anmimationDuration,
                      curve: Curves.easeInOutCubic,
                      left: left,
                      child: SizedBox(
                        height: sizing.height - sizing.padding.vertical,
                        child: Container(
                          width: sizing.itemWidth,
                          decoration: BoxDecoration(
                            color: colors.activeColor.withOpacity(0.2),
                            borderRadius: BorderRadius.all(
                              Radius.circular(sizing.height / 3.6),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Row(
                      children: getItems(context, provider).paddingRow(spacing),
                    ),
                  ],
                ),
              ),
              Container(
                color: fillBottom ? colors.backgroundColor : Colors.transparent,
                height: padding,
              ),
            ],
          ),
        );
      },
    );
  }
}
