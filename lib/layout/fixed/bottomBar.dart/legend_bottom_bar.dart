import 'package:flutter/material.dart';
import 'package:legend_design_core/layout/fixed/bottomBar.dart/bottom_bar_item.dart';
import 'package:legend_design_core/layout/fixed/bottomBar.dart/bottom_bar_provider.dart';
import 'package:legend_design_core/router/legend_router.dart';
import 'package:legend_design_core/styles/colors/sub_palettes/bottom_bar_palette.dart';
import 'package:legend_design_core/styles/legend_theme.dart';
import 'package:legend_design_core/styles/platform_info.dart';
import 'package:legend_design_core/styles/sizing/sub_sizing/bottom_bar_sizing.dart';
import 'package:provider/provider.dart';

const double iosBottomPadding = 12;

class LegendBottomBar extends StatelessWidget {
  final bool? fit;
  final BottomBarSizing sizing;
  final BottomBarPalette colors;
  final List<MenuOption> options;

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
    final MenuOption selected = provider.selected;

    for (final MenuOption option in options) {
      BottomBarItem w = BottomBarItem(
        isSelected: option == selected,
        option: option,
        onSelected: (o) {
          provider.selectOption(option);
          LegendRouter.of(context).pushPage(
            settings: RouteSettings(name: option.page),
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
  Widget build(BuildContext context) {
    double padding = MediaQuery.of(context).padding.bottom;
    if (PlatformInfo.isIos) {
      padding =
          (padding - iosBottomPadding) > 0 ? (padding - iosBottomPadding) : 0;
    }

    bool fillBottom = sizing.fillBottom;

    LegendTheme theme = context.watch<LegendTheme>();
    return Consumer<BottomBarProvider>(
      builder: (context, provider, child) {
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
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: getItems(context, provider),
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
