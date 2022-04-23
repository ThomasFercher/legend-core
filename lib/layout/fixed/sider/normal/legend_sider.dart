import 'package:flutter/material.dart';
import 'package:legend_design_core/icons/legend_animated_icon.dart';
import 'package:legend_design_core/layout/drawers/sidermenu_vertical_tile.dart';
import 'package:legend_design_core/layout/fixed/sider/fixed_sider.dart';
import 'package:legend_design_core/layout/fixed/sider/menu/fixed_sider_menu.dart';
import 'package:legend_design_core/layout/fixed/sider/siderInfo.dart';
import 'package:legend_design_core/layout/layout_provider.dart';
import 'package:legend_design_core/layout/fixed/menu/tiles/drawer_menu_tile.dart';
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
    LegendSider fixedSider = SiderInfo.of(context)!.fixedSider;

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

    List<MenuOption> parentMenuoptions =
        RouteInfoProvider.getParentMenuOption(context)?.children ?? [];

    List<DrawerMenuTile> parentMenuTiles = List.of(
      parentMenuoptions.map(
        (option) => DrawerMenuTile(
          icon: option.icon,
          path: option.page,
          title: option.title,
          background: theme.appBarPalette.background,
          foreground: theme.appBarPalette.foreground,
          selForeground: theme.appBarPalette.selected,
          selBackground: theme.appBarPalette.background,
          isSelected: true,
          isHovered: true,
          borderRadius: theme.sizing.borderRadius[0],
        ),
      ),
    );

    List<Widget> children = [
      Container(
        height: 10,
        color: theme.colors.onPrimary,
        margin: EdgeInsets.only(
          bottom: 24,
        ),
      ),
      if (fixedSider.showMenu)
        FixedSiderMenu(
          activeBackground: theme.colors.siderPalette.background.darken(0.05),
          foreground: theme.siderPalette.foreground,
          activeForeground: theme.siderPalette.selection,
          background: theme.siderPalette.background,
          options: LegendRouter.of(context).menuOptions,
          showMenuSubItems: true,
          spacing: 4,
          collapsed: false,
        ),
      if (fixedSider.showParentMenu && !fixedSider.showMenu)
        FixedSiderMenu(
          activeBackground: theme.colors.siderPalette.background.darken(0.05),
          foreground: theme.siderPalette.foreground,
          activeForeground: theme.siderPalette.selection,
          background: theme.siderPalette.background,
          options:
              RouteInfoProvider.getParentMenuOption(context)?.children ?? [],
          showMenuSubItems: true,
          spacing: 4,
          collapsed: false,
        ),
      if (fixedSider.showChildMenu && !fixedSider.showMenu)
        FixedSiderMenu(
          activeBackground: theme.colors.siderPalette.background.darken(0.05),
          foreground: theme.siderPalette.foreground,
          activeForeground: theme.siderPalette.selection,
          background: theme.siderPalette.background,
          options:
              RouteInfoProvider.getCurrentMenuOption(context)?.children ?? [],
          showMenuSubItems: true,
          spacing: 4,
          collapsed: false,
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
    ];

    ScrollController controller = ScrollController();

    double maxWidth = theme.siderSizing.width;

    return Container(
      width: maxWidth,
      height: MediaQuery.of(context).size.height,
      color: theme.colors.siderPalette.background,
      padding: fixedSider.layoutType == LayoutType.FixedHeaderSider
          ? EdgeInsets.only(top: theme.sizing.appBarSizing.appBarHeight)
          : EdgeInsets.zero,
      child: Column(
        children: [
          if (fixedSider.layoutType == LayoutType.FixedSider)
            Container(
              color: theme.colors.siderPalette.background,
              padding: EdgeInsets.only(
                left: 24,
                right: 24,
                top: 24,
                bottom: 14,
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  if (LayoutProvider.of(context)?.logo != null)
                    Container(
                      height: 36,
                      width: 36,
                      child: Center(
                        child: LayoutProvider.of(context)!.logo,
                      ),
                    ),
                  const SizedBox(
                    width: 6,
                  ),
                  if (LayoutProvider.of(context)?.title != null)
                    Expanded(
                      child: LegendText(
                        dynamicSizing: true,
                        text: LayoutProvider.of(context)!.title!,
                        textStyle: theme.typography.h6.copyWith(
                          color: theme.colors.siderPalette.foreground,
                        ),
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
          if (fixedSider.builder != null)
            Builder(
              builder: fixedSider.builder!,
            ),
        ],
      ),
    );
  }
}
