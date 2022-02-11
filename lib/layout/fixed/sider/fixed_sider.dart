import 'package:flutter/material.dart';
import 'package:legend_design_core/icons/legend_animated_icon.dart';
import 'package:legend_design_core/layout/drawers/legend_drawer_provider.dart';
import 'package:legend_design_core/layout/drawers/sidermenu_vertical_tile.dart';
import 'package:legend_design_core/layout/fixed/sider/fixed_sider_menu.dart';
import 'package:legend_design_core/layout/fixed/sider/siderInfo.dart';
import 'package:legend_design_core/layout/layout_provider.dart';
import 'package:legend_design_core/objects/drawer_menu_tile.dart';
import 'package:legend_design_core/objects/menu_option.dart';
import 'package:legend_design_core/router/routeInfoProvider.dart';
import 'package:legend_design_core/router/routes/section_provider.dart';
import 'package:legend_design_core/router/routes/section_route_info.dart';
import 'package:legend_design_core/styles/layouts/layout_type.dart';
import 'package:legend_design_core/styles/theming/colors/legend_color_palette.dart';
import 'package:legend_design_core/styles/theming/sizing/size_provider.dart';
import 'package:legend_design_core/styles/theming/theme_provider.dart';
import 'package:legend_design_core/typography/legend_text.dart';
import 'package:legend_design_core/utils/legend_utils.dart';
import 'package:provider/provider.dart';

import 'collapsed/collapsedSider.dart';

class FixedSider extends StatelessWidget {
  final bool showMenu;
  final bool showSectionMenu;
  final bool showChildMenu;
  final bool showSubMenu;
  final LayoutType layoutType;
  final bool enableDefaultSettings;
  final WidgetBuilder? builder;

  const FixedSider({
    this.showMenu = true,
    this.showSectionMenu = false,
    this.showSubMenu = false,
    this.showChildMenu = false,
    this.enableDefaultSettings = false,
    this.builder,
    this.layoutType = LayoutType.FixedHeader,
  });

  @override
  Widget build(BuildContext context) {
    ScreenSize screenSize = SizeProvider.of(context).screenSize;
    bool showSider =
        screenSize == ScreenSize.Large || screenSize == ScreenSize.XXL;

    return Hero(
      tag: ValueKey('sider'),
      child: SiderInfo(
        fixedSider: this,
        child: Material(
          elevation: 0,
          child: showSider
              ? const Sider()
              : CollapsedSider(
                  context: context,
                  showMenu: showMenu,
                  showSectionMenu: showSectionMenu,
                  showSubMenu: showChildMenu,
                  layoutType: layoutType,
                ),
        ),
      ),
    );
  }
}

class Sider extends StatelessWidget {
  const Sider({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    FixedSider fixedSider = SiderInfo.of(context)!.fixedSider;

    ThemeProvider theme = Provider.of<ThemeProvider>(context);

    List<SectionRouteInfo> sections =
        SectionProvider.of(context)?.sections ?? [];

    List<SiderMenuVerticalTile> sectionTiles = List.of(
      sections.map(
        (option) => SiderMenuVerticalTile(
          title: LegendUtils.capitalite(option.name.replaceAll('/', '')),
          path: option.name,
          isSection: true,
          collapsed: false,
          activeColor: theme.appBarColors.selectedColor,
          backgroundColor: theme.appBarColors.backgroundColor,
          color: theme.appBarColors.foreground,
        ),
      ),
    );
    MenuOption? current = RouteInfoProvider.getCurrentMenuOption(context);

    List<MenuOption> childMenuoptions = current?.children ?? [];
    List<DrawerMenuTile> childMenuTiles = List.of(
      childMenuoptions.map(
        (option) => DrawerMenuTile(
          icon: option.icon,
          path: option.page,
          title: option.title,
          collapsed: false,
          activeColor: theme.appBarColors.selectedColor,
          backgroundColor: theme.colors.primaryColor,
          color: theme.appBarColors.foreground,
          left: false,
        ),
      ),
    );

    List<Widget> children = [
      if (fixedSider.showMenu)
        FixedSiderMenu(
          backgroundColorSub: LegendColorPalette.darken(
            theme.colors.siderColorTheme.background,
            0.05,
          ),
          foregroundColor: LegendColorPalette.darken(
            theme.colors.siderColorTheme.foreground,
            0.05,
          ),
        ),
      if (fixedSider.showChildMenu && childMenuTiles.isNotEmpty)
        Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 32),
                child: LegendText(
                  text: current?.title ?? '',
                  textStyle: theme.typography.h4.copyWith(
                    color: theme.colors.selectionColor,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 32.0,
                  vertical: 8.0,
                ),
                child: Divider(
                  color: theme.colors.selectionColor,
                  height: 1,
                  thickness: 1,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: ListView(
                  children: childMenuTiles,
                  shrinkWrap: true,
                ),
              ),
            ],
          ),
        ),
      if (fixedSider.showSectionMenu && sectionTiles.isNotEmpty)
        Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 32),
                child: LegendText(
                  text: 'Sections',
                  textStyle: theme.typography.h4.copyWith(
                    color: theme.colors.selectionColor,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 32.0,
                  vertical: 8.0,
                ),
                child: Divider(
                  color: theme.colors.selectionColor,
                  height: 1,
                  thickness: 1,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: ListView(
                  children: sectionTiles,
                  shrinkWrap: true,
                ),
              ),
            ],
          ),
        ),
      if (fixedSider.builder != null)
        Builder(
          builder: (context) => fixedSider.builder!(context),
        ),
    ];

    ScrollController controller = ScrollController();

    return Container(
      width: fixedSider.layoutType == LayoutType.FixedSider ? 220 : 180,
      height: MediaQuery.of(context).size.height,
      color: theme.colors.siderColorTheme.background,
      padding: fixedSider.layoutType == LayoutType.FixedHeaderSider
          ? EdgeInsets.only(top: theme.sizing.appBarSizing.appBarHeight)
          : EdgeInsets.all(0),
      child: Column(
        children: [
          if (fixedSider.layoutType == LayoutType.FixedSider)
            Container(
              color: theme.colors.siderColorTheme.background,
              padding: const EdgeInsets.symmetric(
                vertical: 12.0,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  if (LayoutProvider.of(context)?.title != null)
                    LegendText(
                      text: LayoutProvider.of(context)!.title!,
                      textStyle: theme.typography.h6.copyWith(
                        color: theme.colors.siderColorTheme.foreground,
                      ),
                    ),
                  if (LayoutProvider.of(context)?.logo != null)
                    Container(
                      height: 42,
                      width: 42,
                      margin: const EdgeInsets.only(top: 6.0),
                      child: Center(
                        child: LayoutProvider.of(context)!.logo,
                      ),
                    ),
                ],
              ),
            ),
          Expanded(
            child: Scrollbar(
              controller: controller,
              child: ListView(
                controller: controller,
                children: children,
              ),
            ),
          ),
          if (fixedSider.enableDefaultSettings)
            Container(
              padding: EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  LegendAnimatedIcon(
                    icon: Icons.settings,
                    iconSize: 28,
                    theme: LegendAnimtedIconTheme(
                      enabled: theme.colors.selectionColor,
                      disabled: theme.appBarColors.foreground,
                    ),
                    onPressed: () {
                      Provider.of<LegendDrawerProvider>(context, listen: false)
                          .showDrawer('/settings');
                    },
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
