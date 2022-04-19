import 'package:flutter/widgets.dart';

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
      items: children.keys.toList(),
    );
  }

  @override
  void updateRenderObject(
    BuildContext context,
    SlottedContainerRenderObjectMixin<AppBarItem> renderObject,
  ) {
    (renderObject as AppBarLayoutRenderBox);
  }
}
