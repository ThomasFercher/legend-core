import 'package:flutter/material.dart';
import 'package:legend_design_core/layout/appBar.dart/appbar_provider.dart';
import 'package:legend_design_core/layout/navigation/menu/tiles/column/column_menu_tile.dart';
import 'package:legend_design_core/layout/navigation/menu/tiles/row/row_menu_tile.dart';
import 'package:legend_design_core/legend_design_core.dart';
import 'package:legend_design_core/state/provider/legend_provider.dart';
import 'package:legend_design_core/styles/colors/subcolors/micros/sidemenu/sidemenu_colors.dart';
import 'package:legend_design_core/styles/sizing/sub_sizing/micros/sidemenu/sidemenu_sizing.dart';
import 'sider_submenu_header.dart';

class SiderSubMenu extends StatefulWidget {
  final RouteInfo option;
  final String? current;

  final void Function(bool val)? onResisize;
  final bool expanded;
  final bool hasToPop;
  final bool hasToPopMenudrawer;
  final bool collapsed;
  final SideMenuColors colors;
  final SideMenuSizing sizing;

  SiderSubMenu({
    required this.colors,
    required this.sizing,
    required this.option,
    required this.expanded,
    required this.hasToPop,
    required this.collapsed,
    required this.hasToPopMenudrawer,
    this.onResisize,
    required this.current,
  });

  @override
  State<SiderSubMenu> createState() => _SiderSubMenuState();
}

class _SiderSubMenuState extends State<SiderSubMenu> {
  late int selected;
  late int? hovered;
  late double contentHeight;
  late bool isExpanded;
  late List<Widget> tiles;

  @override
  void initState() {
    contentHeight = getMaxHeight();

    isExpanded = widget.expanded;
    tiles = [];
    selected = 0;
    hovered = null;
    super.initState();
  }

  double getMaxHeight() =>
      (widget.option.children?.length ?? 0) * sizing.itemHeight;

  SideMenuSizing get sizing => widget.sizing;
  SideMenuColors get colors => widget.colors;

  @override
  void didChangeDependencies() {
    RouteInfo? sel = LegendRouter.of(context).current;
    List<RouteInfo>? routes = widget.option.children?.toList();
    if (routes != null && sel != null) {
      selected = routes.indexWhere((element) => element.name == sel.name);
    }
    tiles = getTiles(context);
    super.didChangeDependencies();
  }

  /// This Method returns the whole menu.
  /// If a [RouteDisplay] has children, a [SiderSubMenu] is added, else
  /// we add a [RowMenuTile].
  List<Widget> getTiles(BuildContext context) {
    List<Widget> tiles = [];

    Iterable<RouteInfo> options = widget.option.children ?? [];
    for (int i = 0; i < options.length; i++) {
      final RouteInfo option = options.elementAt(i);

      bool isSelected = i == hovered || widget.current == option.name;

      BorderRadius? borderRadius = i == options.length - 1
          ? BorderRadius.vertical(bottom: sizing.borderRadius.bottomLeft)
          : null;

      tiles.add(
        ColumnMenuTile(
          background: isSelected ? colors.activeBackground : colors.background,
          foreground: isSelected ? colors.activeForeground : colors.foreground,
          title: widget.collapsed ? null : option.title,
          icon: option.icon,
          padding: widget.collapsed ? null : sizing.padding,
          borderRadius: borderRadius,
          iconSize: sizing.iconSize,
          height: sizing.itemHeight,
          onHover: (value) {
            setState(() {
              hovered = value ? i : null;
            });
          },
          onClicked: () {
            setState(() {
              selected = i;
            });
            if (widget.hasToPop) {
              Navigator.of(context).pop();
            }
            if (widget.hasToPopMenudrawer) {
              ProviderWrapper.of<AppBarProvider>(context).update(
                (s) => s.copyWith(
                  showMenu: false,
                ),
              );
            }
            LegendRouter.of(context).pushPage(option.name);
          },
        ),
      );
    }

    return tiles;
  }

  @override
  Widget build(BuildContext context) {
    int headerIndex = widget.option.children?.length ?? 0;

    return LayoutBuilder(builder: (context, constraints) {
      contentHeight = getMaxHeight();
      final double maxHeight = contentHeight + sizing.itemHeight;
      if (constraints.maxHeight < maxHeight) {
        contentHeight = constraints.maxHeight - sizing.itemHeight;
      }

      return ClipRRect(
        borderRadius: sizing.borderRadius,
        child: Container(
          color: colors.menuBackground,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                HeaderTile(
                  colors: colors,
                  sizing: sizing,
                  option: widget.option,
                  isExpanded: isExpanded,
                  current: widget.current,
                  onExpanded: () {
                    isExpanded = !isExpanded;
                    if (widget.onResisize != null) {
                      widget.onResisize!(isExpanded);
                    }
                  },
                  onHover: (value) {
                    setState(() {
                      hovered = value ? headerIndex : null;
                    });
                  },
                  onClicked: () {
                    setState(() {
                      selected = headerIndex;
                    });
                    if (widget.hasToPopMenudrawer) {
                      ProviderWrapper.of<AppBarProvider>(context).update(
                        (s) => s.copyWith(
                          showMenu: false,
                        ),
                      );
                    }
                    if (widget.hasToPop) {
                      Navigator.of(context).pop();
                    }
                    LegendRouter.of(context).pushPage(
                      widget.option.name,
                    );
                  },
                  isHovered: headerIndex == hovered,
                  isSelected: headerIndex == selected,
                  collapsed: widget.collapsed,
                ),
                AnimatedContainer(
                  height: isExpanded ? contentHeight : 0,
                  duration: Duration(
                    milliseconds: 200,
                  ),
                  curve: Curves.ease,
                  child: SingleChildScrollView(
                    controller: ScrollController(),
                    child: SizedBox(
                      height: getMaxHeight(),
                      child: Column(
                        children: getTiles(context),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
