import 'dart:math';

import 'package:flutter/widgets.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:legend_design_core/widgets/elevation/elevated_card.dart';

class AnimatedCard extends HookWidget {
  final double elevation;
  final BorderRadius? borderRadius;
  final Color? background;
  final EdgeInsets padding;
  final Widget child;

  final void Function()? onTap;

  final double? width;
  final double? height;
  final Duration duration;
  final BoxBorder? border;

  final double selElevation;

  const AnimatedCard({
    super.key,
    required this.elevation,
    required this.child,
    this.borderRadius,
    this.background,
    this.padding = EdgeInsets.zero,
    this.border,
    this.onTap,
    this.height,
    this.width,
    this.duration = const Duration(milliseconds: 240),
    double? selElevation,
  }) : selElevation = selElevation ?? elevation * 2;

  @override
  Widget build(BuildContext context) {
    AnimationController controller = useAnimationController(
      duration: duration,
      initialValue: 0,
    );

    Animation<double> offset =
        Tween<double>(begin: elevation, end: selElevation).animate(controller);

    return AnimatedBuilder(
      animation: offset,
      builder: (context, _) {
        return ElevatedCard(
          width: width,
          height: height,
          padding: padding,
          border: border,
          borderRadius: borderRadius,
          background: background,
          elevation: offset.value,
          onHover: (hovered) {
            if (hovered) {
              controller.forward();
            } else {
              controller.reverse();
            }
          },
          onTap: onTap,
          child: child,
        );
      },
    );
  }
}
