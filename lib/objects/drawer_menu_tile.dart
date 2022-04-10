import 'package:flutter/material.dart';
import 'package:legend_design_core/router/legend_router.dart';
import 'package:legend_design_core/styles/legend_theme.dart';
import 'package:provider/src/provider.dart';

import '../typography/legend_text.dart';

const Duration duration = Duration(milliseconds: 300);

class DrawerMenuTile extends StatefulWidget {
  late final Color color;
  final IconData? icon;
  final String? title;
  final String path;
  final Color backgroundColor;
  final bool left;
  final Color activeColor;
  final Color activeBackground;
  final bool collapsed;
  final double? height;
  final void Function()? onClicked;
  final double? textSize;
  final bool rectangleIndicator;
  final double iconSize;
  final bool forceColor;
  final BorderRadiusGeometry? borderRadius;
  final double? bottomSpacing;
  final bool forceBackground;

  DrawerMenuTile({
    required Color color,
    required this.icon,
    required this.path,
    required this.title,
    required this.backgroundColor,
    required this.left,
    required this.activeColor,
    required this.collapsed,
    required this.activeBackground,
    this.iconSize = 24,
    this.rectangleIndicator = false,
    this.forceColor = false,
    this.forceBackground = false,
    this.borderRadius,
    this.bottomSpacing,
    this.onClicked,
    this.height,
    this.textSize,
  }) {
    this.color = forceColor ? activeColor : color;
  }
  @override
  _DrawerMenuTileState createState() => _DrawerMenuTileState();
}

class _DrawerMenuTileState extends State<DrawerMenuTile>
    with SingleTickerProviderStateMixin {
  late Animation<Color?> animation;
  late Animation<Color?> banimation;
  late AnimationController controller;
  late bool _isClicked;
  late bool _isHovered;
  late Color? color;

  @override
  void initState() {
    _isClicked = false;
    _isHovered = false;
    color = widget.color;

    controller = AnimationController(
      vsync: this,
      duration: duration,
    );

    animation = ColorTween(
      begin: widget.color,
      end: widget.activeColor,
    ).animate(controller);

    animation.addListener(() {
      setState(() {
        color = animation.value;
      });
    });

    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  Color get backgroundColor =>
      _isHovered ? widget.activeBackground : widget.backgroundColor;

  @override
  Widget build(BuildContext context) {
    LegendTheme theme = context.watch<LegendTheme>();
    return Container(
      height: widget.height,
      child: InkWell(
        hoverColor: Colors.transparent,
        enableFeedback: true,
        onHover: (value) {
          if (value && !_isClicked) {
            if (!controller.isAnimating || !_isHovered) {
              controller.forward();
              _isHovered = true;
            }
          } else {
            if (!controller.isAnimating || _isHovered && !_isClicked) {
              controller.reverse();
              _isHovered = false;
            }
          }
        },
        onTap: () {
          _isClicked = !_isClicked;
          if (widget.onClicked != null) widget.onClicked!();
          LegendRouter.of(context).pushPage(
            settings: RouteSettings(name: widget.path),
          );
        },
        child: AnimatedContainer(
          duration: duration,
          padding: EdgeInsets.only(
            left: widget.collapsed ? 0 : 26.0,
            top: 12,
            bottom: 12,
          ),
          decoration: BoxDecoration(
            borderRadius: widget.borderRadius,
            color: backgroundColor,
          ),
          child: Row(
            mainAxisAlignment:
                widget.left ? MainAxisAlignment.end : MainAxisAlignment.start,
            children: [
              if (!widget.left)
                Icon(
                  widget.icon,
                  color: color,
                  size: widget.iconSize,
                ),
              if (widget.title != null)
                Container(
                  margin: EdgeInsets.only(left: 12.0, right: 12.0),
                  child: LegendText(
                    text: widget.title!,
                    selectable: false,
                    textStyle: theme.typography.h2.copyWith(
                      color: color,
                      fontSize: widget.textSize,
                    ),
                  ),
                ),
              if (widget.left)
                Icon(
                  widget.icon,
                  color: color,
                  size: widget.iconSize,
                ),
            ],
          ),
        ),
      ),
    );
  }
}
