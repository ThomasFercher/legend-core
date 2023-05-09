import 'package:flutter/material.dart';
import 'package:legend_design_core/layout/bottomBar.dart/behind/behind_icon.dart';
import 'package:legend_design_core/layout/bottomBar.dart/bottom_bar_info.dart';
import 'package:legend_design_core/layout/bottomBar.dart/bottom_bar_item.dart';
import 'package:legend_design_core/layout/bottomBar.dart/bottom_bar_layout.dart';
import 'package:legend_design_core/layout/bottomBar.dart/bottom_bar_provider.dart';
import 'package:legend_design_core/layout/scaffold/scaffold_info.dart';
import 'package:legend_design_core/state/provider/legend_provider.dart';
import 'package:legend_design_core/state/legend_state.dart';
import 'package:legend_design_core/widgets/size_info.dart';
import 'package:legend_router/legend_router.dart';
import 'package:legend_design_core/styles/platform_info.dart';
import 'behind/behind_whole.dart';

const double iosBottomPadding = 12;
const Duration anmimationDuration = Duration(milliseconds: 220);

class LegendBottomBar extends StatefulWidget {
  final bool? fit;
  final List<RouteInfo> options;

  const LegendBottomBar({
    super.key,
    this.fit,
    required this.options,
  });

  @override
  State<LegendBottomBar> createState() => _LegendBottomBarState();
}

class _LegendBottomBarState extends State<LegendBottomBar> {
  List<BottomBarItem> getItems(
    BuildContext context,
    double itemWidth,
    int selected,
  ) {
    return [
      for (int i = 0; i < widget.options.length; i++)
        BottomBarItem(
          width: itemWidth,
          isSelected: i == selected,
          option: widget.options[i],
          onSelected: (o) {
            //provider.selected = i;

            ProviderWrapper.of<BottomBarState>(context).update(
              (p0) => p0.copyWith(selectedIndex: i),
            );
            LegendRouter.of(context).pushPage(
              widget.options[i].name,
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
  void didChangeDependencies() {
    final current = LegendRouter.of(context).current;
    final provider = LegendProvider.of<BottomBarState>(context);
    if (current != null && current != provider.current) {
      final index = provider.routes.indexWhere((r) => r.name == current.name);
      Future.microtask(() => ProviderWrapper.of<BottomBarState>(context).update(
            (p0) => p0.copyWith(selectedIndex: index),
          ));
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final theme = LegendTheme.of(context);
    final sizing = theme.bottomBarSizing;
    final colors = theme.bottomBarColors;

    double padding = MediaQuery.of(context).padding.bottom;
    final layout = ScaffoldInfo.of(context).getLayout(theme).bottomBarLayout;

    if (PlatformInfo.isIos && (padding - iosBottomPadding) > 0) {
      padding = padding - iosBottomPadding;
    } else {
      padding = 0;
    }
    final width = SizeInfo.of(context).logicalWidth - sizing.padding.horizontal;

    final length = widget.options.length;
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

    final provider = LegendProvider.of<BottomBarState>(context);
    final index = provider.selectedIndex;
    final left = index * itemWidth + (index + 1) * spacing;

    return BottomBarInfo(
      colors: colors,
      sizing: sizing,
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
                child: Stack(
                  children: [
                    _getBehind(layout.selectionType, left, itemWidth),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: getItems(
                        context,
                        itemWidth,
                        index,
                      ),
                    ),
                  ],
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
}
