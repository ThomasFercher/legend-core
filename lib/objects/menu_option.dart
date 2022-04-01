import 'package:flutter/material.dart';
import 'package:legend_design_core/modals/legendPopups.dart';
import 'package:legend_design_core/objects/drawer_menu_tile.dart';
import 'package:legend_design_core/router/route_info_provider.dart';
import 'package:legend_design_core/styles/legend_theme.dart';
import 'package:legend_design_core/typography/legend_text.dart';
import 'package:legend_design_core/utils/legend_utils.dart';
import 'package:provider/provider.dart';

import '../router/legend_router.dart';

class MenuOption {
  final String? title;
  final String page;
  final IconData? icon;
  final void Function(String page)? onSelected;
  late final bool isUnderlying;
  final List<MenuOption>? children;
  final bool showSubMenu;
  final bool showInAppBar;

  MenuOption({
    this.title,
    required this.page,
    this.icon,
    this.onSelected,
    bool? isUnderlying,
    this.children,
    this.showSubMenu = false,
    this.showInAppBar = true,
  }) {
    this.isUnderlying = isUnderlying ?? false;
  }
}

class MenuOptionHeader extends StatefulWidget {
  final MenuOption option;
  Color? color;
  final Color? activeColor;
  final Color? backgroundColor;
  final bool forceColor;
  late final bool showSubMenu;
  final double maxHeight = 360;

  MenuOptionHeader({
    required this.option,
    this.color,
    this.activeColor,
    this.backgroundColor,
    bool? showSubMenu,
    this.forceColor = false,
  }) {
    if (option.children != null) {
      this.showSubMenu = showSubMenu ?? false;
    } else {
      this.showSubMenu = false;
    }

    if (forceColor) {
      color = activeColor;
    }
  }

  @override
  _MenuOptionHeaderState createState() => _MenuOptionHeaderState();
}

class _MenuOptionHeaderState extends State<MenuOptionHeader>
    with SingleTickerProviderStateMixin {
  late bool _isHovered;
  late bool _isClicked;
  late AnimationController controller;
  late Animation<Color?> animation;
  late Animation<Color?> animation2;
  late Color color = widget.color ?? Colors.black87;
  late Color borderColor;
  late Color activeColor;
  final GlobalKey key = GlobalKey();
  double width = 80;
  bool subMenuShown = false;
  bool poppedFromtTop = false;

  @override
  void dispose() {
    controller.dispose();

    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _isHovered = false;
    _isClicked = false;
    borderColor = widget.backgroundColor ?? Colors.red;
    activeColor = widget.activeColor ?? Colors.blueAccent;
    controller = AnimationController(
      vsync: this,
      duration: Duration(
        milliseconds: 260,
      ),
    );
    animation = ColorTween(
      begin: color,
      end: activeColor,
    ).animate(controller);

    animation2 = ColorTween(
      begin: borderColor,
      end: activeColor,
    ).animate(controller);

    animation2.addListener(() {
      setState(() {
        borderColor = animation2.value ?? Colors.transparent;
      });
    });

    animation.addListener(() {
      setState(() {
        color = animation.value ?? Colors.transparent;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    LegendTheme theme = context.watch<LegendTheme>();
    width =
        LegendUtils.calcTextSize(widget.option.title ?? '', theme.typography.h2)
                .width +
            (theme.appBarSizing.iconSize ?? 24) * 2.22;

    double menuWidth = 200;

    MenuOption? sel = RouteInfoProvider.getCurrentMenuOption(context);
    List<Widget>? menuItems;
    if (widget.showSubMenu) {
      menuItems = widget.option.children!
          .map(
            (option) => DrawerMenuTile(
              icon: option.icon,
              title: option.title,
              path: option.page,
              left: false,
              backgroundColor: theme.colors.foreground[1],
              activeColor: theme.colors.selection,
              color: theme.colors.textOnDark,
              collapsed: false,
              onClicked: () => poppedFromtTop = true,
              forceColor: option == sel,
              bottomSpacing: 16,
            ),
          )
          .toList();
    }

    return Container(
      key: key,
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(
            color: borderColor,
            width: 4,
            style: BorderStyle.solid,
          ),
          bottom: BorderSide(
            color: borderColor,
            width: 4,
            style: BorderStyle.none,
          ),
        ),
      ),
      height: theme.appBarSizing.appBarHeight,
      width: width,
      child: MouseRegion(
        onEnter: (value) {
          controller.forward();
          if (widget.showSubMenu) {
            subMenuShown = true;
            LegendPopups.showSubMenu(
              theme: theme,
              menuWidth: menuWidth,
              menuItems: menuItems,
              context: context,
              itemWidth: width,
              maxHeight: widget.maxHeight,
              parentHeight: theme.appBarSizing.appBarHeight,
              key: key,
              onParentTap: () {
                poppedFromtTop = true;
                LegendRouter.of(context).pushPage(
                  settings: RouteSettings(name: widget.option.page),
                );
              },
              onExit: (event) {
                if (poppedFromtTop == false) {
                  Navigator.pop(context);
                } else {
                  poppedFromtTop = false;
                }
                controller.reverse();
                subMenuShown = false;
              },
              onParentExit: (event, p) {
                if (p.dy <= theme.appBarSizing.appBarHeight) {
                  Navigator.of(context).pop();
                  poppedFromtTop = true;
                }
              },
            );
          }
        },
        onExit: (event) {
          if (!subMenuShown) controller.reverse();
        },
        child: GestureDetector(
          onTap: () {
            _isClicked = !_isClicked;
            if (widget.option.onSelected != null) {
              widget.option.onSelected!(widget.option.page);
            }
            LegendRouter.of(context).pushPage(
              settings: RouteSettings(name: widget.option.page),
            );
          },
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                widget.option.icon,
                color: color,
                size: theme.appBarSizing.iconSize,
              ),
              if (widget.option.title != null)
                Padding(
                  padding: const EdgeInsets.only(top: 2.0, left: 8.0),
                  child: LegendText(
                    text: widget.option.title!,
                    selectable: false,
                    textStyle: theme.typography.h2.copyWith(
                      color: color,
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
