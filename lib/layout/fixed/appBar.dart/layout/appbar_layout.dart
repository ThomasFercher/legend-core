import 'dart:developer';

import 'package:flutter/widgets.dart';
import 'package:legend_design_core/layout/layout_provider.dart';
import 'package:legend_design_core/layout/scaffold/scaffold_title.dart';
import 'package:legend_design_core/styles/legend_theme.dart';
import 'package:legend_design_core/utils/legend_utils.dart';
import 'package:provider/provider.dart';

import 'appbar_layout_renderbox.dart';

enum AppBarItem {
  TITLE,
  LOGO,
  MENU,
  ACTIONS,
}

class AppBarLayout extends RenderObjectWidget
    with SlottedMultiChildRenderObjectWidgetMixin<AppBarItem> {
  final Map<AppBarItem, Widget> children;
  final Color? background;

  AppBarLayout({
    Key? key,
    required this.children,
    this.background,
  }) : super(key: ValueKey(children.hashCode));

  @override
  Iterable<AppBarItem> get slots => children.keys;

  @override
  Widget? childForSlot(AppBarItem slot) {
    return children[slot];
  }

  @override
  SlottedContainerRenderObjectMixin<AppBarItem> createRenderObject(
    BuildContext context,
  ) {
    return AppBarLayoutRenderBox(
      background: background,
      siderOverlap: calculateOverlap(context),
      items: children.keys.toList(),
    );
  }

  double calculateOverlap(BuildContext context) {
    LegendTheme theme = context.watch<LegendTheme>();
    double siderWidth = theme.siderSizing.width;
    String title = LayoutProvider.of(context)?.title ?? "";
    double titleWidth = LegendUtils.getTitleIndent(theme.typography.h6, title);
    double paddingLeft = theme.appBarSizing.contentPadding.left + spacing;
    double logoWidth = theme.appBarSizing.logoSize;
    return (titleWidth + paddingLeft + logoWidth) - siderWidth;
  }

  @override
  void updateRenderObject(
    BuildContext context,
    SlottedContainerRenderObjectMixin<AppBarItem> renderObject,
  ) {
    (renderObject as AppBarLayoutRenderBox);
  }
}
