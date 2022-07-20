import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:legend_design_core/layout/navigation/menu/tiles/column/column_menu_tile.dart';
import 'package:legend_design_core/layout/navigation/menu/tiles/row/row_menu_tile.dart';
import 'package:legend_design_core/layout/navigation/siderMenu/fixed_sider_menu.dart';
import 'package:legend_design_core/styles/colors/subcolors/micros/sidemenu/sidemenu_colors.dart';
import 'package:legend_design_core/styles/sizing/sub_sizing/micros/sidemenu/sidemenu_sizing.dart';
import 'package:legend_design_core/widgets/icons/legend_animated_icon.dart';
import 'package:legend_router/router/legend_router.dart';
import 'package:legend_design_core/styles/colors/subcolors/menuDrawer/menu_drawer_colors.dart';
import 'package:legend_design_core/styles/legend_theme.dart';
import 'package:legend_design_core/widgets/size_info.dart';
import 'package:legend_design_core/styles/sizing/sub_sizing/menuDrawer/menuDrawer_sizing.dart';
import 'package:legend_router/router/routes/route_display.dart';
import 'package:legend_utils/extensions/extensions.dart';
import 'package:provider/provider.dart';

class MenuDrawer extends StatefulWidget {
  final List<Widget>? actions;

  const MenuDrawer({Key? key, this.actions}) : super(key: key);

  @override
  State<MenuDrawer> createState() => _MenuDrawerState();
}

class _MenuDrawerState extends State<MenuDrawer> {
  late String text;
  late int? hovered;
  late List<int> searchItems;

  @override
  void initState() {
    text = '';
    hovered = null;
    searchItems = [];
    super.initState();
  }

  List<Widget> getSearchItems(List<int> filtered, BuildContext context) {
    LegendTheme theme = context.watch<LegendTheme>();
    List<RouteDisplay> options = LegendRouter.of(context).getRouteDisplays;
    List<Widget> items = [];
    for (var i = 0; i < filtered.length; i++) {
      final Widget widget;
      int index = filtered[i];
      final RouteDisplay menuOption = options[index];

      widget = ColumnMenuTile(
        foreground: theme.colors.foreground2,

        icon: menuOption.icon,

        background: theme.colors.background2,

        iconSize: 22,
        onClicked: () {
          Navigator.pop(context);
          LegendRouter.of(context).pushPage(
            settings: RouteSettings(name: menuOption.route),
          );
        },
        onHover: (val) {
          setState(() {
            hovered = val ? i : null;
          });
        },

        title: menuOption.title,
        //      verticalPadding: 4,

        height: 40,
      );
      items.add(widget);
    }

    return items;
  }

  void filter(String s, BuildContext context) {
    setState(() {
      text = s;
    });

    List<int> items = [];
    List<RouteDisplay> options = LegendRouter.of(context).getRouteDisplays;

    String filter = text.toLowerCase().trim();

    if (text.isNotEmpty) {
      for (int i = 0; i < options.length; i++) {
        final RouteDisplay option = options[i];
        String page = option.route;
        String title = option.title;
        title = title.toLowerCase();

        if (page.contains(filter)) {
          items.add(i);
        } else if (title.contains(filter)) {
          items.add(i);
        }
      }
    }
    setState(() {
      searchItems = items;
    });
  }

  @override
  Widget build(BuildContext context) {
    LegendTheme theme = Provider.of<LegendTheme>(context);
    SizeInfo sizeInfo = SizeInfo.of(context);

    MenuDrawerSizingStyle sizing = theme.menuDrawerSizing;
    MenuDrawerColorsStyle colors = theme.menuDrawerPalette;
    SideMenuSizingStyle menuSizing = sizing.sideMenuSizing;
    SideMenuColorsStyle menuColors = colors.menuColors;

    double topPadding = MediaQuery.of(context).padding.top;

    EdgeInsetsGeometry padding = theme.isMobile
        ? EdgeInsets.only(
            top: topPadding,
            left: 12,
            right: 12,
          )
        : EdgeInsets.symmetric(
            horizontal: 24,
          );
    double search_item_height = 40;
    double decoration = theme.sizing.radius1 * 2;
    double search_height = searchItems.length * search_item_height +
        (searchItems.isEmpty ? 0 : decoration);
    String current = LegendRouter.of(context).getCurrent()?.route ?? '';

    return SizedBox(
      width: theme.menuDrawerSizing.width,
      height: sizeInfo.height,
      child: Container(
        color: colors.background,
        padding: padding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: theme.sizing.spacing1,
            ),
            SizedBox(
              height: theme.sizing.appBarSizing.appBarHeight - 4,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  LegendAnimatedIcon(
                    icon: Icons.close,
                    disableShadow: true,
                    theme: LegendAnimtedIconTheme(
                      enabled: colors.foreground_selection,
                      disabled: colors.foreground,
                    ),
                    onPressed: () {
                      LegendRouter.of(context).popModal();
                    },
                  ),
                ],
              ),
            ),
            SizedBox(
              height: theme.sizing.spacing2,
            ),
            Flexible(
              child: SingleChildScrollView(
                child: FixedSiderMenu(
                  sizing: menuSizing,
                  colors: menuColors,
                  depth: current.allMatches('/').length,
                  width: theme.menuDrawerSizing.width - padding.horizontal,
                  hasToPop: true,
                  options: LegendRouter.of(context).routeDisplays,
                  showMenuSubItems: true,
                  textStyle: theme.typography.h2,
                  current: LegendRouter.of(context).getCurrent()?.route,
                ),
              ),
            ),
            SizedBox(
              height: theme.sizing.spacing1,
            ),
            if (widget.actions != null)
              Padding(
                padding: const EdgeInsets.only(bottom: 12.0),
                child: Row(
                  children: widget.actions!,
                ),
              )
          ],
        ),
      ),
    );
  }
}
