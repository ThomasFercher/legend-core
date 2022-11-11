import 'package:flutter/widgets.dart';
import 'package:legend_design_core/layout/bottomBar.dart/bottom_bar_info.dart';
import 'package:legend_design_core/layout/bottomBar.dart/legend_bottom_bar.dart';
import 'package:legend_design_core/state/legend_state.dart';

class BehindIcon extends LegendWidget {
  final double left;
  final double itemWidth;

  const BehindIcon({
    super.key,
    required this.left,
    required this.itemWidth,
  });

  @override
  Widget build(BuildContext context, theme) {
    final info = BottomBarInfo.of(context);
    final sizing = info.sizing;
    final colors = info.colors;
    final topFactor = (sizing.height -
            sizing.padding.vertical -
            sizing.iconSize -
            (sizing.showText ? theme.typography.h0.fontSize ?? 0 : 0)) /
        3;

    return AnimatedPositioned(
      duration: anmimationDuration,
      curve: Curves.easeInOutCubic,
      left: left,
      child: Container(
        height: info.sizing.iconSize * 1.25,
        width: itemWidth,
        margin: EdgeInsets.only(
          top: topFactor / 1.5,
        ),
        decoration: BoxDecoration(
          color: colors.activeColor.withOpacity(0.2),
          borderRadius: BorderRadius.all(
            Radius.circular(sizing.height / 3.6),
          ),
        ),
      ),
    );
  }
}
