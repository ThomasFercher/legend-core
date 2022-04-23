import 'package:flutter/material.dart';
import 'package:legend_design_core/layout/fixed/bottomBar.dart/bottom_bar_item.dart';
import 'package:legend_design_core/layout/fixed/bottomBar.dart/bottom_bar_provider.dart';
import 'package:legend_design_core/router/legend_router.dart';
import 'package:legend_design_core/styles/colors/sub_palettes/bottom_bar_palette.dart';
import 'package:legend_design_core/styles/sizing/sub_sizing/bottom_bar_sizing.dart';
import 'package:provider/provider.dart';

class FixedBottomBar extends StatelessWidget {
  final bool? fit;
  late BottomBarSizing sizing;
  late BottomBarPalette colors;

  FixedBottomBar({
    Key? key,
    this.fit,
    required this.sizing,
    required this.colors,
  }) : super(key: key);

  late int index;
  late List<BottomBarItem> items;

  List<BottomBarItem> getOptions(BuildContext c) {
    List<MenuOption> options = LegendRouter.of(c).menuOptions;
    List<BottomBarItem> it = [];

    for (final MenuOption o in options) {
      BottomBarItem w = BottomBarItem(
        option: o,
        onSelected: (selOption) {
          Provider.of<BottomBarProvider>(c, listen: false).selectOption(o);
        },
        sizing: sizing,
        colors: colors,
      );
      it.add(w);
    }

    return it;
  }

  List<BottomBarItem> getItems(BuildContext context) {
    List<MenuOption> options = LegendRouter.of(context).menuOptions;
    List<BottomBarItem> it = [];
    for (var i = 0; i < options.length; i++) {
      MenuOption option = options[i];
      BottomBarItem item = BottomBarItem(
        option: option,
        sizing: sizing,
        onSelected: (o) {
          Provider.of<BottomBarProvider>(context, listen: false)
              .selectOption(option);
        },
        colors: colors,
      );
      it.add(item);
    }

    return it;
  }

  @override
  Widget build(BuildContext context) {
    List<MenuOption> options = LegendRouter.of(context).menuOptions;

    return Material(
      color: colors.backgroundColor,
      child: Hero(
        tag: ValueKey('BottomBar'),
        child: Container(
          padding: sizing.margin,
          decoration: sizing.decoration.copyWith(
            color: colors.backgroundColor,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: getItems(context),
          ),
          height: sizing.height,
        ),
      ),
    );
  }
}
