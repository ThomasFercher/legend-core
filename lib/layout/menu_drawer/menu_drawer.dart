import 'package:flutter/material.dart';
import 'package:legend_design_core/layout/navigation/menu/tiles/column/column_menu_tile.dart';
import 'package:legend_design_core/layout/navigation/siderMenu/fixed_sider_menu.dart';
import 'package:legend_design_core/router/extension.dart';
import 'package:legend_design_core/styles/platform_info.dart';
import 'package:legend_design_core/widgets/icons/legend_animated_icon.dart';
import 'package:legend_design_core/styles/legend_theme.dart';
import 'package:legend_design_core/widgets/size_info.dart';
import 'package:legend_design_core/state/legend_state.dart';
import 'package:legend_router/legend_router.dart';

class MenuDrawer extends StatefulWidget {
  static const route = '/menudrawer';

  final List<Widget>? actions;

  const MenuDrawer({Key? key, this.actions}) : super(key: key);

  @override
  State<MenuDrawer> createState() => _MenuDrawerState();
}

class _MenuDrawerState extends State<MenuDrawer> {
  late String text;
  late int? hovered;
  late final ScrollController controller;
  late List<int> searchItems;

  @override
  void initState() {
    text = '';
    hovered = null;
    searchItems = [];
    controller = ScrollController();
    super.initState();
  }

  List<Widget> getSearchItems(List<int> filtered, BuildContext context) {
    LegendTheme theme = LegendTheme.of(context);
    List<RouteInfo> options = context.menuRoutes;
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
            menuOption.name,
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
    List<RouteInfo> options = context.menuRoutes;

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
    final theme = LegendTheme.of(context);
    final sizeInfo = SizeInfo.of(context);
    final sizing = theme.menuDrawerSizing;
    final colors = theme.menuDrawerColors;
    final menuSizing = sizing.sideMenuSizing;
    final menuColors = colors.menuColors;

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

    String? current =
        LegendRouter.of(context).routerDelegate.currentConfiguration.last.name;

    return SizedBox(
      width: theme.menuDrawerSizing.width,
      height: sizeInfo.height,
      child: Container(
        color: colors.background,
        padding: EdgeInsets.only(
          left: padding.horizontal / 2,
          right: padding.horizontal * 0.25 * 0.5,
          top: padding.vertical / 2,
          bottom: padding.vertical / 2,
        ),
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
                    icon: theme.typography.closeIcon,
                    disableShadow: true,
                    theme: LegendAnimtedIconTheme(
                      enabled: colors.foregroundSelection,
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
              child: Scrollbar(
                controller: controller,
                child: ScrollConfiguration(
                  behavior: ScrollConfiguration.of(context).copyWith(
                    scrollbars: false,
                  ),
                  child: SingleChildScrollView(
                    controller: controller,
                    child: Padding(
                      padding: EdgeInsets.only(
                        right: padding.horizontal * 0.75 * 0.5,
                      ),
                      child: FixedSiderMenu(
                        sizing: menuSizing,
                        colors: menuColors,
                        width:
                            theme.menuDrawerSizing.width - padding.horizontal,
                        hasToPop: true,
                        current: current,
                        options: context.menuRoutes,
                        showMenuSubItems: true,
                        textStyle: theme.typography.h2,
                      ),
                    ),
                  ),
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
