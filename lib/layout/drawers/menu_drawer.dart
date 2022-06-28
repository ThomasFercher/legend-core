import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:legend_design_core/layout/navigation/menu/tiles/column/column_menu_tile.dart';
import 'package:legend_design_core/layout/navigation/menu/tiles/row/row_menu_tile.dart';
import 'package:legend_design_core/layout/navigation/siderMenu/fixed_sider_menu.dart';
import 'package:legend_design_core/layout/navigation/siderMenu/siderMenuStyle.dart';
import 'package:legend_design_core/widgets/icons/legend_animated_icon.dart';
import 'package:legend_router/router/legend_router.dart';
import 'package:legend_design_core/styles/colors/subcolors/menu_drawer_colors.dart';
import 'package:legend_design_core/styles/legend_theme.dart';
import 'package:legend_design_core/widgets/size_info.dart';
import 'package:legend_design_core/styles/sizing/sub_sizing/menu_drawer_sizing.dart';
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

    MenuDrawerSizing sizing = theme.menuDrawerSizing;
    MenuDrawerColors colors = theme.menuDrawerPalette;

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

    SiderMenuStyle style = SiderMenuStyle(
      background: colors.background,
      foreground: colors.foreground,
      activeBackground: colors.background_selection,
      activeForeground: colors.foreground_selection,
      spacing: sizing.spacing,
      padding: sizing.itemPadding,
      itemHeight: sizing.itemHeight,
      subMenuHeaderHeight: sizing.subMenuHeaderHeight,
      iconSize: sizing.iconSize,
    );

    SiderSubMenuStyle subMenuStyle = SiderSubMenuStyle(
      background: colors.backgroundMenu,
      foreground: colors.foreground,
      activeForeground: colors.foreground_selection,
      activeBackground: colors.background_menu_selection,
      itemPadding: sizing.itemPadding,
      spacing: sizing.spacing,
      borderRadius: theme.sizing.radius2.asRadius(),
      headerHeight: sizing.subMenuHeaderHeight,
      itemHeight: sizing.itemHeight,
      iconSize: sizing.iconSize,
      subMenuIconSize: sizing.iconSize - 2,
    );

    return SizedBox(
      width: theme.menuDrawerSizing.width,
      height: sizeInfo.height,
      child: Container(
        color: style.background,
        padding: padding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: theme.sizing.appBarSizing.appBarHeight - 4,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(
                    width: 12,
                  ),
                  Expanded(
                    child: Container(
                      height: 36,
                      child: CupertinoTextField(
                        onChanged: (value) {
                          filter(value, context);
                        },
                        textAlignVertical: TextAlignVertical.center,
                        prefix: Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Icon(
                            Icons.search,
                            size: 22,
                            color: colors.foreground,
                          ),
                        ),
                        decoration: BoxDecoration(
                          color: theme.colors.onPrimary.lighten(0.25),
                          borderRadius: theme.sizing.radius2.asRadius(),
                          border: Border.all(
                            color: colors.foreground.withOpacity(0.6),
                            width: 2,
                          ),
                        ),
                        padding: EdgeInsets.symmetric(
                          horizontal: 8,
                        ),
                        style: theme.typography.h1,
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 24,
                  ),
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
            Padding(
              padding: const EdgeInsets.only(left: 12.0),
              child: AnimatedContainer(
                duration: Duration(
                  milliseconds: 400,
                ),
                curve: Curves.easeInOutSine,
                height: search_height,
                decoration: BoxDecoration(
                  borderRadius: theme.sizing.radius1.asRadius(),
                  color: theme.colors.background1,
                ),
                padding: EdgeInsets.only(
                  top: theme.sizing.radius1,
                  bottom: theme.sizing.radius1,
                ),
                child: ListView(
                  // shrinkWrap: true,
                  padding: EdgeInsets.zero,
                  children: getSearchItems(searchItems, context),
                ),
                margin: searchItems.isNotEmpty
                    ? const EdgeInsets.only(bottom: 24)
                    : EdgeInsets.zero,
              ),
            ),
            Divider(height: 4, thickness: 1, color: colors.foreground),
            const SizedBox(
              height: 12,
            ),
            Flexible(
              child: SingleChildScrollView(
                child: FixedSiderMenu(
                  width: theme.menuDrawerSizing.width - padding.horizontal,
                  hasToPop: true,
                  options: LegendRouter.of(context).routeDisplays,
                  showMenuSubItems: true,
                  style: style,
                  subMenuStyle: subMenuStyle,
                  textStyle: theme.typography.h2,
                  current: LegendRouter.of(context).getCurrent()?.route,
                ),
              ),
            ),
            const SizedBox(
              height: 12,
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
