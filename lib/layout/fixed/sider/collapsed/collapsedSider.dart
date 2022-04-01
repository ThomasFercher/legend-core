import 'package:flutter/material.dart';
import 'package:legend_design_core/layout/drawers/sidermenu_vertical_tile.dart';
import 'package:legend_design_core/layout/fixed/sider/menu/fixed_sider_menu.dart';
import 'package:legend_design_core/layout/layout_provider.dart';
import 'package:legend_design_core/router/legend_router.dart';
import 'package:legend_design_core/router/routes/section/section_info.dart';
import 'package:legend_design_core/styles/layouts/layout_type.dart';
import 'package:legend_design_core/styles/legend_theme.dart';
import 'package:legend_design_core/utils/extensions.dart';
import 'package:legend_design_core/utils/legend_utils.dart';
import 'package:provider/provider.dart';

class CollapsedSider extends StatelessWidget {
  final bool showMenu;
  final bool showSectionMenu;
  final bool showSubMenu;
  final LayoutType layoutType;

  const CollapsedSider({
    Key? key,
    required this.context,
    required this.showMenu,
    required this.showSectionMenu,
    required this.showSubMenu,
    required this.layoutType,
  }) : super(key: key);

  final BuildContext context;

  @override
  Widget build(BuildContext context) {
    LegendTheme theme = Provider.of<LegendTheme>(context);
    List<MenuOption> options = LegendRouter.of(context).menuOptions;
    List<SiderMenuVerticalTile> tiles = List.of(
      options.map(
        (option) => SiderMenuVerticalTile(
          icon: option.icon,
          path: option.page,
          title: option.title,
          collapsed: true,
          activeColor: Colors.tealAccent,
          backgroundColor: theme.colors.primary,
          color: theme.colors.textOnDark,
        ),
      ),
    );

    List<SectionInfo> sections = SectionProvider.of(context)?.sections ?? [];
    List<SiderMenuVerticalTile> sectionTiles = List.of(
      sections.map(
        (option) => SiderMenuVerticalTile(
          title: LegendUtils.capitalite(option.name.replaceAll('/', '')),
          path: option.name,
          isSection: true,
          collapsed: true,
          activeColor: theme.colors.selection,
          backgroundColor: theme.colors.primary,
          color: theme.colors.textOnDark,
        ),
      ),
    );

    return Container(
      width: 80,
      height: MediaQuery.of(context).size.height,
      color: theme.appBarPalette.background,
      padding: EdgeInsets.only(top: theme.sizing.appBarSizing.appBarHeight),
      child: ListView(
        children: [
          if (layoutType == LayoutType.FixedSider)
            Container(
              color: theme.colors.siderPalette.background,
              padding: const EdgeInsets.symmetric(
                vertical: 12.0,
              ),
              child: Container(
                height: 48,
                width: 48,
                child: Center(
                  child: LayoutProvider.of(context)?.logo ?? Container(),
                ),
              ),
            ),
          Divider(
            color: theme.colors.secondary.withOpacity(0.2),
            height: 1.0,
            thickness: 1.0,
          ),
          if (showMenu)
            FixedSiderMenu(
              isCollapsed: true,
              backgroundColorSub: theme.colors.primary.darken(0.05),
              foregroundColor:
                  theme.colors.siderPalette.foreground.darken(0.05),
            ),
          if (showSectionMenu)
            Padding(
              padding: const EdgeInsets.only(top: 16.0),
              child: ListView(
                children: sectionTiles,
                shrinkWrap: true,
              ),
            )
        ],
      ),
    );
  }
}
