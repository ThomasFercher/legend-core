import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'appbar_layout.dart';

class AppBarLayoutRenderBox extends RenderBox
    with
        SlottedContainerRenderObjectMixin<AppBarItem>,
        DebugOverflowIndicatorMixin {
  final Color? background;
  late Size contentSize;
  final List<AppBarItem> items;
  late List<Size> sizes;
  final double? siderOverlap;
  final double spacing;
  final AppBarLayoutType type;

  AppBarLayoutRenderBox({
    this.background,
    required this.items,
    this.siderOverlap,
    this.spacing = 6,
    required this.type,
  });

  double getWidthWithoutMenu(BoxConstraints constraints) {
    double width = 0;
    BoxConstraints childConstraints = constraints;

    for (AppBarItem item in items) {
      if (item == AppBarItem.MENU) continue;
      RenderBox? child = childForSlot(item);
      if (child == null) continue;
      child.layout(childConstraints, parentUsesSize: true);
      width += child.size.width;
    }

    return width;
  }

  double getMenuWidth() {
    RenderBox? menu = childForSlot(AppBarItem.MENU);

    if (menu == null) return 0;

    menu.layout(
        BoxConstraints(
          maxWidth: 1000,
        ),
        parentUsesSize: true);

    return menu.size.width;
  }

  double getTitleWidth() {
    RenderBox? menu = childForSlot(AppBarItem.TITLE);

    if (menu == null) return 0;

    menu.layout(BoxConstraints(), parentUsesSize: true);

    return menu.size.width;
  }

  double? getHeight() {
    RenderBox? menu = childForSlot(AppBarItem.MENU);

    if (menu == null) return null;

    menu.layout(BoxConstraints(), parentUsesSize: true);

    return menu.size.width;
  }

  double centerVertically(double maxHeight, Size s) =>
      (maxHeight - s.height) / 2;

  /// Layout

  void LoTiMeAcMe(
    double maxWidth,
    double maxHeight,
    bool isMenuCollapsed,
    double menuCenter,
    double remaining,
    RenderBox? title,
    RenderBox? menu,
    RenderBox? actions,
  ) {
    BoxConstraints childConstraints = this.constraints;

    Offset offset = Offset.zero;

    // Title
    Size titleSize = Size.zero;
    if (title != null) {
      // Layout
      title.layout(childConstraints, parentUsesSize: true);
      titleSize = title.size;

      // Center Vertically
      offset = Offset(offset.dx, centerVertically(maxHeight, titleSize));

      final BoxParentData parentData = title.parentData! as BoxParentData;
      parentData.offset = offset;

      // Update Offset and Constraints
      childConstraints = childConstraints.copyWith(
        maxWidth: childConstraints.maxWidth - titleSize.width,
      );
      offset = offset.translate(titleSize.width, 0);
    }

    if (isMenuCollapsed) {
      offset = offset.translate(remaining, 0);
    }

    // Actions When not collapsed
    Size actionSize = Size.zero;
    if (actions != null && !isMenuCollapsed) {
      // Layout
      actions.layout(childConstraints, parentUsesSize: true);
      actionSize = actions.size;

      // Center Vertically
      Offset offset_action = Offset(
        maxWidth - actionSize.width,
        centerVertically(maxHeight, actionSize),
      );

      final BoxParentData parentData = actions.parentData! as BoxParentData;
      parentData.offset = offset_action;
      childConstraints = childConstraints.copyWith(
        maxWidth: childConstraints.maxWidth - actionSize.width,
      );
    }

    // Menu
    Size menuSize = Size.zero;
    if (menu != null && !isMenuCollapsed) {
      // Center Menu Horizontally
      double left = titleSize.width;
      if (siderOverlap != null && left == 0) left = siderOverlap!;

      double padd = menuCenter - left;
      if (padd < 0) padd = 0;
      offset = offset.translate(padd, 0);

      // Layout
      menu.layout(childConstraints, parentUsesSize: true);
      menuSize = menu.size;

      // Center Vertically
      offset = Offset(
          offset.dx + 4 * spacing, centerVertically(maxHeight, menuSize));

      final BoxParentData parentData = menu.parentData! as BoxParentData;
      parentData.offset = offset;

      childConstraints = childConstraints.copyWith(
        maxWidth: childConstraints.maxWidth - menuSize.width,
      );
    }

    if (menu != null && isMenuCollapsed) {
      // Layout
      menu.layout(BoxConstraints(maxWidth: 32), parentUsesSize: true);
      menuSize = menu.size;

      // Center Vertically
      offset = Offset(
        maxWidth - menuSize.width,
        centerVertically(maxHeight, menuSize),
      );

      final BoxParentData parentData = menu.parentData! as BoxParentData;
      parentData.offset = offset;
    }

    // Actions When Collapsed
    actionSize = Size.zero;
    if (actions != null && isMenuCollapsed) {
      // Layout
      actions.layout(childConstraints, parentUsesSize: true);
      actionSize = actions.size;

      // Center Vertically
      Offset offset_action = Offset(
        maxWidth -
            (isMenuCollapsed ? menuSize.width : 0) -
            actionSize.width -
            spacing,
        centerVertically(maxHeight, actionSize),
      );

      final BoxParentData parentData = actions.parentData! as BoxParentData;
      parentData.offset = offset_action;
      childConstraints = childConstraints.copyWith(
        maxWidth: childConstraints.maxWidth - actionSize.width,
      );
    }
  }

  ///

  void MeLoTiAc(
    double maxWidth,
    double maxHeight,
    double remaining,
    RenderBox? title,
    RenderBox? menu,
    RenderBox? actions,
  ) {
    BoxConstraints childConstraints = this.constraints;

    Offset offset = Offset.zero;
    double titleWidth = getTitleWidth();
    double menuWidth = getMenuWidth();
    double centerTitleDx = (maxWidth - titleWidth) / 2;

    bool isMenuCollapsed;
    if (centerTitleDx > menuWidth * 0.75) {
      isMenuCollapsed = false;
    } else {
      isMenuCollapsed = true;
    }

    // Menu
    Size menuSize = Size.zero;
    if (menu != null && isMenuCollapsed) {
      // Layout
      menu.layout(BoxConstraints(maxWidth: 32), parentUsesSize: true);
      menuSize = menu.size;

      // Center Vertically
      offset = Offset(
        offset.dx,
        centerVertically(maxHeight, menuSize),
      );

      final BoxParentData parentData = menu.parentData! as BoxParentData;
      parentData.offset = offset;

      offset = offset.translate(menuSize.width, 0);
    }

    // Title
    Size titleSize = Size.zero;

    if (title != null) {
      // Layout
      title.layout(childConstraints, parentUsesSize: true);
      titleSize = title.size;

      centerTitleDx = (maxWidth - titleSize.width) / 2;

      // Center Vertically
      offset = Offset(centerTitleDx, centerVertically(maxHeight, titleSize));

      final BoxParentData parentData = title.parentData! as BoxParentData;
      parentData.offset = offset;

      // Update Offset and Constraints
      childConstraints = childConstraints.copyWith(
        maxWidth: childConstraints.maxWidth - titleSize.width,
      );
    }

    if (menu != null && !isMenuCollapsed) {
      // Center Menu Horizontally
      double left = spacing;
      if (siderOverlap != null && left == 0) left = siderOverlap!;

      double width = centerTitleDx * 11 / 12;
      // Layout
      menu.layout(
        constraints.copyWith(
          maxWidth: width,
        ),
        parentUsesSize: true,
      );

      menuSize = menu.size;

      // Center Vertically
      offset = Offset(left, centerVertically(maxHeight, menuSize));

      final BoxParentData parentData = menu.parentData! as BoxParentData;
      parentData.offset = offset;

      childConstraints = childConstraints.copyWith(
        maxWidth: childConstraints.maxWidth - menuSize.width,
      );

      offset = offset.translate(menuSize.width, 0);
    }

    // Actions When not collapsed
    Size actionSize = Size.zero;
    if (actions != null) {
      // Layout
      actions.layout(childConstraints, parentUsesSize: true);
      actionSize = actions.size;

      // Center Vertically
      Offset offset_action = Offset(
        maxWidth - actionSize.width,
        centerVertically(maxHeight, actionSize),
      );

      final BoxParentData parentData = actions.parentData! as BoxParentData;
      parentData.offset = offset_action;
      childConstraints = childConstraints.copyWith(
        maxWidth: childConstraints.maxWidth - actionSize.width,
      );
    }
  }

  ///

  @override
  void performLayout() {
    // Children are allowed to be as big as they want (= unconstrained).
    BoxConstraints constraints = this.constraints;
    double maxWidth = constraints.maxWidth;
    double maxHeight = constraints.maxHeight;
    contentSize = Size(maxWidth, constraints.maxHeight);

    BoxConstraints childConstraints = constraints;

    //RenderBoxes
    bool isMenuCollapsed = false;
    double menuWidth = 0;
    double spaceFilled = 0;

    RenderBox? actions = childForSlot(AppBarItem.ACTIONS);
    RenderBox? title = childForSlot(AppBarItem.TITLE);
    RenderBox? menu = childForSlot(AppBarItem.MENU);

    if (menu != null) {
      menuWidth = getMenuWidth();
      spaceFilled = getWidthWithoutMenu(constraints) + 9 * spacing;

      if (menuWidth != 0) {
        if ((maxWidth - spaceFilled) < menuWidth) {
          isMenuCollapsed = true;
          menuWidth = 64;
        }
      }
    }

    // Menu not collapsed
    double menuCenter = (maxWidth - menuWidth) / 2;
    double remaining = maxWidth - menuWidth - spaceFilled;

    print(isMenuCollapsed);

    switch (type) {
      case AppBarLayoutType.MeTiAc:
        MeLoTiAc(
          maxWidth,
          maxHeight,
          remaining,
          title,
          menu,
          actions,
        );
        break;
      case AppBarLayoutType.TiMeAc:
        LoTiMeAcMe(
          maxWidth,
          maxHeight,
          isMenuCollapsed,
          menuCenter,
          remaining,
          title,
          menu,
          actions,
        );
        break;
    }

    size = contentSize;
  }

  // PAINT
  @override
  void paint(PaintingContext context, Offset offset) {
    // Paint the background.

    context.canvas.drawRect(
      offset & size,
      Paint()..color = background ?? Colors.transparent,
    );

    void paintChild(RenderBox child, PaintingContext context, Offset offset) {
      final BoxParentData childParentData = child.parentData! as BoxParentData;
      context.paintChild(child, childParentData.offset + offset);
    }

    for (RenderBox box in children) {
      paintChild(box, context, offset);
    }

    // Paint an overflow indicator in debug mode if the children want to be
    // larger than the incoming constraints allow.
    assert(() {
      paintOverflowIndicator(
        context,
        offset,
        Offset.zero & size,
        Offset.zero & contentSize,
      );
      return true;
    }());
  }

  // HIT TEST
  @override
  bool hitTestChildren(BoxHitTestResult result, {required Offset position}) {
    for (final RenderBox child in children) {
      final BoxParentData parentData = child.parentData! as BoxParentData;
      final bool isHit = result.addWithPaintOffset(
        offset: parentData.offset,
        position: position,
        hitTest: (BoxHitTestResult result, Offset transformed) {
          assert(transformed == position - parentData.offset);
          return child.hitTest(result, position: transformed);
        },
      );
      if (isHit) {
        return true;
      }
    }
    return false;
  }

  // INTRINSICS

  // Incoming height/width are ignored as children are always laid out unconstrained.

  @override
  double computeMinIntrinsicWidth(double height) {
    double width = 0;
    for (RenderBox box in children) {
      width += box.getMinIntrinsicWidth(double.infinity);
    }

    return width;
  }

  @override
  double computeMaxIntrinsicWidth(double height) {
    double width = 0;
    for (RenderBox box in children) {
      width += box.getMaxIntrinsicWidth(double.infinity);
    }

    return width;
  }

  @override
  double computeMinIntrinsicHeight(double width) {
    double height = 0;
    for (RenderBox box in children) {
      height += box.getMinIntrinsicHeight(double.infinity);
    }

    return height;
  }

  @override
  double computeMaxIntrinsicHeight(double width) {
    double height = 0;
    for (RenderBox box in children) {
      height += box.getMaxIntrinsicHeight(double.infinity);
    }

    return height;
  }

  @override
  Size computeDryLayout(BoxConstraints constraints) {
    const BoxConstraints childConstraints = BoxConstraints();
    Size s = Size.zero;
    for (RenderBox box in children) {
      Size boxSize = box.computeDryLayout(childConstraints);
      s = Size(s.width + boxSize.width, s.height + boxSize.height);
    }

    return constraints.constrain(s);
  }
}
