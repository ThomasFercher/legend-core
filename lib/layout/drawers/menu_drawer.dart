import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:legend_design_core/icons/legend_animated_icon.dart';
import 'package:legend_design_core/layout/fixed/menu/tiles/drawer_menu_tile.dart';
import 'package:legend_design_core/layout/fixed/sider/siderMenu/fixed_sider_menu.dart';

import 'package:legend_design_core/router/legend_router.dart';
import 'package:legend_design_core/styles/colors/sub_palettes/menu_drawer_palette.dart';
import 'package:legend_design_core/styles/legend_theme.dart';
import 'package:legend_design_core/styles/sizing/size_info.dart';
import 'package:legend_design_core/styles/sizing/sub_sizing/menu_drawer_sizing.dart';
import 'package:legend_design_core/utils/extensions.dart';
import 'package:provider/provider.dart';

import '../fixed/sider/siderMenu/siderMenuStyle.dart';

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

  List<DrawerMenuTile> getSearchItems(
      List<int> filtered, BuildContext context) {
    LegendTheme theme = context.watch<LegendTheme>();
    List<MenuOption> options = LegendRouter.of(context).menuOptions;
    List<DrawerMenuTile> items = [];
    for (var i = 0; i < filtered.length; i++) {
      final DrawerMenuTile widget;
      int index = filtered[i];
      final MenuOption menuOption = options[index];

      widget = DrawerMenuTile(
        foreground: theme.colors.textOnLight,

        icon: menuOption.icon,
        selForeground: theme.colors.onSecondary,
        background: theme.colors.background[0],
        selBackground: theme.colors.background[1],
        iconSize: 22,
        onClicked: () {
          Navigator.pop(context);
          LegendRouter.of(context).pushPage(
            settings: RouteSettings(name: menuOption.page),
          );
        },
        onHover: (val) {
          setState(() {
            hovered = val ? i : null;
          });
        },

        path: menuOption.page,
        title: menuOption.title,
        //      verticalPadding: 4,
        isHovered: hovered == i,
        isSelected: false,
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
    List<MenuOption> options = LegendRouter.of(context).menuOptions;

    String filter = text.toLowerCase().trim();

    if (text.isNotEmpty) {
      for (int i = 0; i < options.length; i++) {
        final MenuOption option = options[i];
        String page = option.page;
        String title = option.title ?? '';
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
    MenuDrawerPalette colors = theme.menuDrawerPalette;

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
    double decoration = theme.sizing.borderInset[0] * 2;
    double search_height = searchItems.length * search_item_height +
        (searchItems.isEmpty ? 0 : decoration);

    SiderMenuStyle style = SiderMenuStyle(
      background: colors.background,
      foreground: colors.foreground,
      activeBackground: colors.backgroundMenu,
      activeForeground: colors.foreground_selection,
      spacing: sizing.spacing,
      padding: sizing.itemPadding,
      itemHeight: sizing.itemHeight,
      subMenuHeaderHeight: sizing.subMenuHeaderHeight,
      iconSize: sizing.iconSize,
    );

    SiderSubMenuStyle subStyle = SiderSubMenuStyle(
      itemPadding: sizing.subItemPadding,
      background: colors.backgroundMenu,
      activeForeground: colors.foreground_menu_selction,
      activeBackground: colors.backgroundMenu.darken(),
      foreground: colors.foreground,
      borderRadius: theme.sizing.borderRadius[1],
      headerHeight: sizing.subMenuHeaderHeight,
      itemHeight: sizing.itemHeight,
      iconSize: sizing.iconSize,
      subMenuIconSize: sizing.subMenuIconSize,
      spacing: sizing.spacing,
    );

    return SizedBox(
      width: theme.menuDrawerSizing.width,
      height: sizeInfo.height,
      child: Container(
        color: theme.colors.primary,
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
                            color: theme.colors.primary,
                          ),
                        ),
                        decoration: BoxDecoration(
                          color: theme.colors.onPrimary.lighten(0.25),
                          borderRadius: theme.sizing.borderRadius[1],
                          border: Border.all(
                            color: theme.colors.onPrimary,
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
                      enabled: theme.colors.selection,
                      disabled: theme.colors.onPrimary,
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
                  borderRadius: theme.sizing.borderRadius[0],
                  color: theme.colors.background[0],
                ),
                padding: EdgeInsets.only(
                  top: theme.sizing.borderInset[0],
                  bottom: theme.sizing.borderInset[0],
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
            Divider(
              height: 4,
              thickness: 1,
              color: theme.colors.onPrimary,
            ),
            const SizedBox(
              height: 12,
            ),
            Expanded(
              child: FixedSiderMenu(
                hasToPop: true,
                options: LegendRouter.of(context).menuOptions,
                showMenuSubItems: true,
                collapsed: false,
                style: style,
                subMenuStyle: subStyle,
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
