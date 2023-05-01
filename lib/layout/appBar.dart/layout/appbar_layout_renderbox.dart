import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import '../appbar_layout.dart';
import 'appbar_layout.dart';

class AppBarLayoutRenderBox extends RenderBox
    with
        SlottedContainerRenderObjectMixin<AppBarItem>,
        DebugOverflowIndicatorMixin {
  final Color? background;
  late Size contentSize;
  final List<AppBarItem> items;
  late List<Size> sizes;

  final double spacing;
  final AppBarLayoutType type;

  AppBarLayoutRenderBox({
    this.background,
    required this.items,
    this.spacing = 6,
    required this.type,
  });

  double getWidthWithoutMenu(BoxConstraints constraints) {
    double width = 0;
    BoxConstraints childConstraints = constraints;

    for (final AppBarItem item in items) {
      if (item == AppBarItem.menu) continue;
      RenderBox? child = childForSlot(item);
      if (child == null) continue;
      child.layout(childConstraints, parentUsesSize: true);
      width += child.size.width;
    }

    return width;
  }

  double getWidthForSlot(RenderBox? renderBox) {
    if (renderBox == null) return 0;
    renderBox.layout(constraints, parentUsesSize: true);
    return renderBox.size.width;
  }

  double getMenuWidth() {
    RenderBox? menu = childForSlot(AppBarItem.menu);

    if (menu == null) return 0;

    menu.layout(constraints, parentUsesSize: true);

    return menu.size.width;
  }

  double getTitleWidth() {
    RenderBox? menu = childForSlot(AppBarItem.title);

    if (menu == null) return 0;

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
    RenderBox? backButton,
  ) {
    BoxConstraints childConstraints = constraints;

    Offset offset = Offset.zero;

    //BackButton
    var backButtonSize = Size.zero;
    if (backButton != null) {
      //Layout
      backButton.layout(childConstraints, parentUsesSize: true);
      backButtonSize = backButton.size;

      // Center Vertically
      offset = Offset(offset.dx, centerVertically(maxHeight, backButtonSize));

      final BoxParentData parentData = backButton.parentData! as BoxParentData;
      parentData.offset = offset;

      // Update Offset and Constraints
      childConstraints = childConstraints.copyWith(
        maxWidth: childConstraints.maxWidth - backButtonSize.width,
      );
      offset = offset.translate(backButtonSize.width, 0);
    }

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
      offset = Offset(
        menuCenter,
        centerVertically(maxHeight, menuSize),
      );

      // Layout
      menu.layout(childConstraints, parentUsesSize: true);
      menuSize = menu.size;

      // Center Vertically
      offset = Offset(offset.dx, centerVertically(maxHeight, menuSize));

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
        maxWidth - menuSize.width - actionSize.width - spacing,
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
    RenderBox? backButton,
  ) {
    BoxConstraints childConstraints = constraints;

    Offset offset = Offset.zero;
    double titleWidth = getTitleWidth();
    double menuWidth = getMenuWidth();
    double centerTitleDx = (maxWidth - titleWidth) / 2;

    //BackButton
    var backButtonSize = Size.zero;
    if (backButton != null) {
      //Layout
      backButton.layout(childConstraints, parentUsesSize: true);
      backButtonSize = backButton.size;

      // Center Vertically
      offset = Offset(offset.dx, centerVertically(maxHeight, backButtonSize));

      final BoxParentData parentData = backButton.parentData! as BoxParentData;
      parentData.offset = offset;

      // Update Offset and Constraints
      childConstraints = childConstraints.copyWith(
        maxWidth: childConstraints.maxWidth - backButtonSize.width,
      );
      offset = offset.translate(backButtonSize.width, 0);
    }

    // Menu Collapse Check
    bool isMenuCollapsed;
    if (centerTitleDx > menuWidth + backButtonSize.width + 2 * spacing) {
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
      double left = spacing + backButtonSize.width;

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
    final maxWidth = constraints.maxWidth;
    final maxHeight = constraints.maxHeight;
    contentSize = Size(maxWidth, constraints.maxHeight);

    //RenderBoxes
    bool isMenuCollapsed = false;

    final actions = childForSlot(AppBarItem.actions);
    final title = childForSlot(AppBarItem.title);
    final menu = childForSlot(AppBarItem.menu);
    final backButton = childForSlot(AppBarItem.backButton);

    final menuWidth = menu != null ? getMenuWidth() : 0;

    switch (type) {
      case AppBarLayoutType.MeTiAc:
        final spaceRight = getWidthForSlot(actions);
        final spaceLeft = getWidthForSlot(backButton) + getWidthForSlot(title);
        final spaceFilled = spaceLeft + spaceRight;
        final remaining = maxWidth - menuWidth - spaceFilled;
        MeLoTiAc(
          maxWidth,
          maxHeight,
          remaining,
          title,
          menu,
          actions,
          backButton,
        );
        break;
      case AppBarLayoutType.TiMeAc:
        final spaceRight = getWidthForSlot(actions);
        final spaceLeft = getWidthForSlot(backButton) + getWidthForSlot(title);
        final spaceFilled = spaceLeft + spaceRight;
        final remaining = maxWidth - menuWidth - spaceFilled;
        final biggestIndent = max(spaceLeft, spaceRight) + spacing;
        final indent = (maxWidth - menuWidth - 2 * biggestIndent) / 2;
        final menuCenter = biggestIndent + indent;

        if (indent <= 0) {
          isMenuCollapsed = true;
        }
        LoTiMeAcMe(
          maxWidth,
          maxHeight,
          isMenuCollapsed,
          menuCenter,
          remaining,
          title,
          menu,
          actions,
          backButton,
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
