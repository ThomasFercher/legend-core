import 'package:flutter/material.dart';
import 'package:legend_design_core/icons/legend_animated_icon.dart';
import 'package:legend_design_core/layout/fixed/sider/menu/fixed_sider_menu.dart';
import 'package:legend_design_core/objects/drawer_menu_tile.dart';
import 'package:legend_design_core/router/legend_router.dart';
import 'package:legend_design_core/styles/legend_theme.dart';
import 'package:legend_design_core/typography/legend_text.dart';
import 'package:provider/provider.dart';

class MenuDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    LegendTheme theme = Provider.of<LegendTheme>(context);
    List<MenuOption> options = LegendRouter.of(context).menuOptions;
    List<DrawerMenuTile> tiles = List.of(
      options.map(
        (option) => DrawerMenuTile(
          icon: option.icon,
          title: option.title,
          path: option.page,
          left: false,
          backgroundColor: theme.colors.background[1],
          activeColor: theme.colors.selection,
          color: theme.colors.primary,
          collapsed: true,
        ),
      ),
    );

    double mWidth = MediaQuery.of(context).size.width;
    double width = 320;
    if (mWidth <= width) {
      width = mWidth * 3 / 4;
    }

    return Container(
      width: width,
      child: Drawer(
        elevation: 4,
        child: Container(
          color: theme.colors.background[1],
          padding: const EdgeInsets.symmetric(
            vertical: 32,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      child: LegendText(
                        padding: EdgeInsets.only(
                          right: 8,
                        ),
                        text: 'Legend Design',
                        textStyle: theme.typography.h5.copyWith(
                          color: theme.colors.textOnLight,
                        ),
                      ),
                    ),
                    LegendAnimatedIcon(
                      icon: Icons.close,
                      disableShadow: true,
                      theme: LegendAnimtedIconTheme(
                        enabled: theme.colors.selection,
                        disabled: theme.colors.foreground[1],
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  top: 12.0,
                  left: 24,
                  right: 24,
                ),
                child: Divider(
                  height: 1,
                  thickness: 0.5,
                  color: theme.colors.foreground[0],
                ),
              ),
              FixedSiderMenu(
                backgroundColor: theme.colors.background[1],
                foregroundColor: theme.colors.primary,
              )
            ],
          ),
        ),
      ),
    );
  }
}
