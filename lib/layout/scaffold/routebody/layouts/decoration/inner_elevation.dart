import 'package:flutter/material.dart';
import 'package:legend_design_core/widgets/shadow/inner_box_decoration.dart';
import 'package:legend_design_core/widgets/shadow/inner_box_shadow.dart';

class InnerElevation extends StatelessWidget {
  final Widget? child;
  final double? width;
  final double? height;
  final ShadowSide? shadowSide;
  final bool combineShadows;

  const InnerElevation({
    this.child,
    required this.shadowSide,
    this.combineShadows = false,
    this.width,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    if (shadowSide == null) {
      return child ?? SizedBox.shrink();
    }

    return Container(
      width: width,
      height: height,
      decoration: InnerBoxDecoration(
        color: Colors.transparent,
        shadowSide: shadowSide!,
        combine: combineShadows,
        boxShadow: const [
          InnerBoxShadow(
            color: Colors.black,
            spreadRadius: 0.6,
            blurRadius: 6,
          )
        ],
      ),
      child: child,
    );
  }
}
