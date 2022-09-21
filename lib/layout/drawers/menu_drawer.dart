import 'package:flutter/material.dart';
import 'package:legend_design_core/layout/navigation/menu/tiles/column/column_menu_tile.dart';
import 'package:legend_design_core/layout/navigation/siderMenu/fixed_sider_menu.dart';
import 'package:legend_design_core/styles/colors/subcolors/micros/sidemenu/sidemenu_colors.dart';
import 'package:legend_design_core/styles/platform_info.dart';
import 'package:legend_design_core/styles/sizing/sub_sizing/micros/sidemenu/sidemenu_sizing.dart';
import 'package:legend_design_core/widgets/icons/legend_animated_icon.dart';
import 'package:legend_router/router/legend_router.dart';
import 'package:legend_design_core/styles/colors/subcolors/menuDrawer/menu_drawer_colors.dart';
import 'package:legend_design_core/styles/legend_theme.dart';
import 'package:legend_design_core/widgets/size_info.dart';
import 'package:legend_design_core/state/legend_state.dart';
import 'package:legend_router/router/route_info_provider.dart';

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
    List<RouteInfo> options = LegendRouter.of(context).routes;
    List<Widget> items = [];
    for (var i = 0; i < filtered.length; i++) {
      final Widget widget;
      int index = filtered[i];
      final RouteInfo menuOption = options[index];

      widget = ColumnMenuTile(
        foreground: theme.colors.foreground2,

        icon: menuOption.icon,

        background: theme.colors.background2,

        iconSize: 22,
        onClicked: () {
          Navigator.pop(context);
          LegendRouter.of(context).pushPage(
            settings: RouteSettings(name: menuOption.name),
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
    List<RouteInfo> options = LegendRouter.of(context).routes;

    String filter = text.toLowerCase().trim();

    if (text.isNotEmpty) {
      for (int i = 0; i < options.length; i++) {
        final RouteInfo option = options[i];
        String page = option.name;
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
    MenuDrawerColorsStyle colors = theme.menuDrawerColors;
    SideMenuSizingStyle menuSizing = sizing.sideMenuSizing;
    SideMenuColorsStyle menuColors = colors.menuColors;

    double topPadding = MediaQuery.of(context).padding.top;

    EdgeInsetsGeometry padding = PlatformInfo.isMobile
        ? EdgeInsets.only(
            top: topPadding,
            left: 12,
            right: 12,
          )
        : EdgeInsets.symmetric(
            horizontal: 24,
          );

    String current = RouteInfoProvider.getRouteInfo(context)?.name ?? '';

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
                      Navigator.of(context).pop();
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
                  options: LegendRouter.of(context).routes,
                  showMenuSubItems: true,
                  textStyle: theme.typography.h2,
                  current: RouteInfoProvider.getRouteInfo(context)?.name,
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
