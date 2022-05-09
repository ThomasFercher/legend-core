import 'dart:developer';

import 'package:flutter/widgets.dart';
import 'package:legend_design_core/layout/layout_provider.dart';
import 'package:legend_design_core/layout/scaffold/contents/scaffold_title.dart';
import 'package:legend_design_core/styles/legend_theme.dart';
import 'package:legend_utils/functions/functions.dart';
import 'package:provider/provider.dart';

import 'appbar_layout_renderbox.dart';

enum AppBarItem {
  TITLE,

  MENU,
  ACTIONS,
}

enum AppBarLayoutType {
  TiMeAc,
  MeTiAc,
}

class AppBarLayout extends RenderObjectWidget
    with SlottedMultiChildRenderObjectWidgetMixin<AppBarItem> {
  final Map<AppBarItem, Widget> children;
  final Color? background;
  final AppBarLayoutType type;

  AppBarLayout({
    Key? key,
    required this.children,
    required this.type,
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
      type: type,
    );
  }

  double calculateOverlap(BuildContext context) {
    LegendTheme theme = context.watch<LegendTheme>();
    double siderWidth = theme.siderSizing.width;
    String title = LayoutProvider.of(context)?.title ?? "";
    double titleWidth =
        LegendFunctions.getTitleIndent(theme.typography.h6, title);
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
