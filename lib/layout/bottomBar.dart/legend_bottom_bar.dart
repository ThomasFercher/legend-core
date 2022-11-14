import 'package:flutter/material.dart';
import 'package:legend_design_core/layout/bottomBar.dart/behind/behind_icon.dart';
import 'package:legend_design_core/layout/bottomBar.dart/bottom_bar_info.dart';
import 'package:legend_design_core/layout/bottomBar.dart/bottom_bar_item.dart';
import 'package:legend_design_core/layout/bottomBar.dart/bottom_bar_layout.dart';
import 'package:legend_design_core/layout/bottomBar.dart/bottom_bar_provider.dart';
import 'package:legend_design_core/layout/scaffold/scaffoldInfo.dart';
import 'package:legend_design_core/state/legend_state.dart';
import 'package:legend_design_core/widgets/size_info.dart';
import 'package:legend_router/router/legend_router.dart';
import 'package:legend_design_core/styles/platform_info.dart';
import 'package:legend_utils/legend_utils.dart';
import 'package:provider/provider.dart';

import 'behind/behind_whole.dart';

const double iosBottomPadding = 12;
const Duration anmimationDuration = Duration(milliseconds: 220);

class LegendBottomBar extends LegendWidget {
  final bool? fit;
  final BottomBarSizingStyle sizing;
  final BottomBarColorsStyle colors;
  final List<RouteInfo> options;

  const LegendBottomBar({
    Key? key,
    this.fit,
    required this.sizing,
    required this.colors,
    required this.options,
  }) : super(key: key);

  List<BottomBarItem> getItems(
    BuildContext context,
    BottomBarProvider provider,
    double itemWidth,
    int selected,
  ) {
    return [
      for (int i = 0; i < options.length; i++)
        BottomBarItem(
          width: itemWidth,
          isSelected: i == selected,
          option: options[i],
          onSelected: (o) {
            provider.selected = i;
            LegendRouter.of(context).pushPage(
              settings: RouteSettings(name: options[i].name),
            );
          },
        )
    ];
  }

  Widget _getBehind(
    BottomBarSelectionType type,
    double left,
    double itemWidth,
  ) {
    switch (type) {
      case BottomBarSelectionType.icon:
        return BehindIcon(
          left: left,
          itemWidth: itemWidth,
        );
      case BottomBarSelectionType.whole:
        return BehindWhole(
          left: left,
          itemWidth: itemWidth,
        );
    }
  }

  @override
  Widget build(BuildContext context, LegendTheme theme) {
    double padding = MediaQuery.of(context).padding.bottom;
    final RouteInfo? current = LegendRouter.of(context).routerDelegate.current;
    if (PlatformInfo.isIos && (padding - iosBottomPadding) > 0) {
      padding = padding - iosBottomPadding;
    } else {
      padding = 0;
    }
    final width = SizeInfo.of(context).logicalWidth - sizing.padding.horizontal;
    final length = options.length;
    var itemWidth = sizing.itemWidth;
    var spacing = (width - (length * itemWidth)) / (length + 1);

    assert(length <= 5, 'To many Routes provided'); //TODO: Rethink

    if (spacing <= 0) {
      itemWidth = width * 0.9 / length;
      spacing = width * 0.1 / (length + 1);
    }
    assert(
      spacing >= 0,
      'Not enough space for Routes . Occurred at width ${width}px.',
    );

    return BottomBarInfo(
      bottomBar: this,
      child: SizedBox(
        height: sizing.margin.vertical + sizing.height + padding,
        width: SizeInfo.of(context).logicalWidth,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Expanded(
              child: Container(
                margin: sizing.margin,
                height: sizing.height,
                decoration: sizing.decoration.copyWith(
                  color: colors.backgroundColor,
                ),
                padding: sizing.padding,
                child: Consumer<BottomBarProvider>(
                  builder: (context, provider, child) {
                    final layout = ScaffoldInfo.of(context)
                        .getLayout(theme)
                        .bottomBarLayout!;
                    var selected = provider.selectedIndex;

                    if (current != null && current != provider.current) {
                      selected = provider.routes.indexOf(current);
                    }
                    final left =
                        selected * itemWidth + (selected + 1) * spacing;
                    return Stack(
                      children: [
                        _getBehind(layout.selectionType, left, itemWidth),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children:
                              getItems(context, provider, itemWidth, selected),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ),
            Container(
              color: sizing.fillBottom
                  ? colors.backgroundColor
                  : Colors.transparent,
              height: padding,
            ),
          ],
        ),
      ),
    );
  }

  Widget getAnimationObject(double left) {
    return AnimatedPositioned(
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
    );
  }
}
