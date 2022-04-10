import 'package:flutter/material.dart';
import 'package:legend_design_core/icons/legend_animated_icon.dart';
import 'package:legend_design_core/layout/drawers/sidermenu_vertical_tile.dart';
import 'package:legend_design_core/layout/fixed/sider/fixed_sider.dart';
import 'package:legend_design_core/layout/fixed/sider/menu/fixed_sider_menu.dart';
import 'package:legend_design_core/layout/fixed/sider/siderInfo.dart';
import 'package:legend_design_core/layout/layout_provider.dart';
import 'package:legend_design_core/objects/drawer_menu_tile.dart';
import 'package:legend_design_core/router/legend_router.dart';
import 'package:legend_design_core/router/route_info_provider.dart';
import 'package:legend_design_core/router/routes/section/section_info.dart';
import 'package:legend_design_core/styles/layouts/layout_type.dart';
import 'package:legend_design_core/styles/legend_theme.dart';
import 'package:legend_design_core/typography/legend_text.dart';
import 'package:legend_design_core/utils/extensions.dart';
import 'package:legend_design_core/utils/legend_utils.dart';
import 'package:provider/provider.dart';

class Sider extends StatelessWidget {
  const Sider({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    FixedSider fixedSider = SiderInfo.of(context)!.fixedSider;
    LegendTheme theme = Provider.of<LegendTheme>(context);
    List<SectionInfo> sections = SectionProvider.of(context)?.sections ?? [];
    List<SiderMenuVerticalTile> sectionTiles = List.of(
      sections.map(
        (option) => SiderMenuVerticalTile(
          title: LegendUtils.capitalite(option.name.replaceAll('/', '')),
          path: option.name,
          isSection: true,
          collapsed: false,
          activeColor: theme.appBarPalette.selected,
          backgroundColor: theme.appBarPalette.background,
          color: theme.appBarPalette.foreground,
        ),
      ),
    );
    MenuOption? current = RouteInfoProvider.getCurrentMenuOption(context);

    List<MenuOption> childMenuoptions = current?.children ?? [];
    List<MenuOption> parentMenuoptions =
        RouteInfoProvider.getParentMenuOption(context)?.children ?? [];

    List<DrawerMenuTile> childMenuTiles = List.of(
      childMenuoptions.map(
        (option) => DrawerMenuTile(
          activeBackground: Colors.green,
          icon: option.icon,
          path: option.page,
          title: option.title,
          collapsed: false,
          activeColor: theme.appBarPalette.selected,
          backgroundColor: theme.colors.primary,
          color: theme.appBarPalette.foreground,
          left: false,
        ),
      ),
    );

    List<DrawerMenuTile> parentMenuTiles = List.of(
      parentMenuoptions.map(
        (option) => DrawerMenuTile(
          activeBackground: Colors.black,
          icon: option.icon,
          path: option.page,
          title: option.title,
          collapsed: false,
          activeColor: theme.appBarPalette.selected,
          backgroundColor: theme.colors.primary,
          color: theme.appBarPalette.foreground,
          left: false,
        ),
      ),
    );

    List<Widget> children = [
      Container(
        height: 12,
        color: theme.colors.primary,
        margin: EdgeInsets.only(
          bottom: 6,
        ),
      ),
      if (fixedSider.showMenu)
        FixedSiderMenu(
          activeBackgroundColor:
              theme.colors.siderPalette.background.darken(0.05),
          foregroundColor: theme.colors.siderPalette.foreground.lighten(0.05),
          activeForegroundColor: Colors.indigo,
          backgroundColor: Colors.indigo,
          subMenuColor: Colors.red,
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
                    color: theme.colors.selection,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 32.0,
                  vertical: 8.0,
                ),
                child: Divider(
                  color: theme.colors.selection,
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
      if (fixedSider.showParentMenu)
        Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: ListView(
            children: parentMenuTiles,
            shrinkWrap: true,
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
                    color: theme.colors.selection,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 32.0,
                  vertical: 8.0,
                ),
                child: Divider(
                  color: theme.colors.selection,
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
      color: theme.colors.siderPalette.background,
      padding: fixedSider.layoutType == LayoutType.FixedHeaderSider
          ? EdgeInsets.only(top: theme.sizing.appBarSizing.appBarHeight)
          : EdgeInsets.all(0),
      child: Column(
        children: [
          if (fixedSider.layoutType == LayoutType.FixedSider)
            Container(
              color: theme.colors.siderPalette.background,
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
                        color: theme.colors.siderPalette.foreground,
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
                      enabled: theme.colors.selection,
                      disabled: theme.appBarPalette.foreground,
                    ),
                    onPressed: () {
                      LegendRouter.of(context).pushPage(
                          settings: RouteSettings(name: '/siderMenu'));
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
