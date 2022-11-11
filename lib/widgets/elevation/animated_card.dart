import 'package:flutter/widgets.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:legend_design_core/widgets/elevation/elevated_card.dart';
import '../../styles/legend_theme.dart';

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

  AnimatedCard({
    Key? key,
    required this.elevation,
    this.borderRadius,
    this.background,
    required this.padding,
    required this.child,
    this.onTap,
    this.height,
    this.width,
    this.duration = const Duration(milliseconds: 240),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AnimationController controller = useAnimationController(
      duration: duration,
      initialValue: 0,
    );

    Animation<double> offset =
        Tween<double>(begin: 1, end: 10).animate(controller);

    return AnimatedBuilder(
      animation: offset,
      builder: (context, _) {
        return ElevatedCard(
          width: width,
          height: height,
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
