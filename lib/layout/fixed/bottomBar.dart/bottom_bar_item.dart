import 'package:flutter/material.dart';
import 'package:legend_design_core/layout/fixed/bottomBar.dart/bottom_bar_provider.dart';
import 'package:legend_design_core/router/legend_router.dart';
import 'package:legend_design_core/styles/legend_theme.dart';
import 'package:legend_design_core/typography/legend_text.dart';
import 'package:provider/provider.dart';

class BottomBarItem extends StatefulWidget {
  final MenuOption option;
  final BottomBarSizing? sizing;
  final BottomBarPalette colors;
  final void Function(MenuOption option) onSelected;

  const BottomBarItem({
    required this.option,
    required this.sizing,
    required this.colors,
    required this.onSelected,
    Key? key,
  }) : super(key: key);

  @override
  _BottomBarItemState createState() => _BottomBarItemState();
}

class _BottomBarItemState extends State<BottomBarItem>
    with SingleTickerProviderStateMixin {
  late Color _activeColor;
  late Color _disabledColor;
  late bool _isSelected;

  late Animation<Color?> _foregroundAnimation;
  late Animation<Color?> _backgroundAnimation;

  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _disabledColor = widget.colors.disabledColor;
    _activeColor = _disabledColor;
    _isSelected = false;

    _controller = AnimationController(
      vsync: this,
      duration: Duration(
        milliseconds: 400,
      ),
    );
    _foregroundAnimation = ColorTween(
      begin: _disabledColor,
      end: widget.colors.activeColor,
    ).animate(_controller);

    _backgroundAnimation = ColorTween(
      begin: Colors.teal,
      end: Colors.blueAccent,
    ).animate(_controller);

    _backgroundAnimation.addListener(() {
      setState(() {
        _disabledColor = _backgroundAnimation.value ?? Colors.transparent;
      });
    });

    _foregroundAnimation.addListener(() {
      setState(() {
        _activeColor = _foregroundAnimation.value ?? Colors.transparent;
      });
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Widget getText(BuildContext context) {
    LegendTheme theme = context.watch<LegendTheme>();
    return LegendText(
      text: widget.option.title!,
      textStyle: theme.typography.h0.copyWith(
        color: _activeColor,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<BottomBarProvider>(
      builder: (context, sel, c) {
        bool isSelected = sel.selected.page == widget.option.page;

        if (isSelected && !_isSelected) {
          _controller.forward();
          _isSelected = true;
        } else if (!isSelected && _isSelected) {
          _controller.reverse();
          _isSelected = false;
        }

        return Material(
          color: Colors.transparent,
          child: Container(
            child: InkWell(
              borderRadius: BorderRadius.all(
                Radius.circular(widget.sizing?.height ?? 1 / 2),
              ),
              onTap: () {
                widget.onSelected(widget.option);

                LegendRouter.of(context).pushPage(
                  settings: RouteSettings(name: widget.option.page),
                );
              },
              child: Container(
                height: widget.sizing?.height,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          child: Icon(
                            widget.option.icon,
                            size: widget.sizing?.iconSize ?? 28,
                            color: _activeColor,
                          ),
                        ),
                        if ((widget.sizing?.textAtBottom ?? false) &&
                            (widget.sizing?.showText ?? true) &&
                            (widget.option.title != null))
                          Container(
                            padding: EdgeInsets.only(top: 2.0),
                            child: getText(context),
                          ),
                      ],
                    ),
                    if ((widget.sizing?.showText ?? true) &&
                        (!(widget.sizing?.textAtBottom ?? false)) &&
                        (widget.option.title != null))
                      Container(
                        padding: EdgeInsets.only(left: 4.0),
                        child: getText(context),
                      ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
