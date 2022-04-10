import 'package:flutter/material.dart';
import 'package:legend_design_core/icons/legend_animated_icon.dart';
import 'package:legend_design_core/layout/fixed/sider/menu/fixed_sider_menu.dart';
import 'package:legend_design_core/styles/legend_theme.dart';
import 'package:provider/provider.dart';

class MenuDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    LegendTheme theme = Provider.of<LegendTheme>(context);

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
          color: theme.colors.primary,
          padding: const EdgeInsets.symmetric(
            vertical: 32,
            horizontal: 24,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  LegendAnimatedIcon(
                    icon: Icons.close,
                    disableShadow: true,
                    theme: LegendAnimtedIconTheme(
                      enabled: theme.colors.selection,
                      disabled: theme.colors.onPrimary,
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(
                  top: 12.0,
                ),
                child: Divider(
                  height: 1,
                  thickness: 1,
                  color: theme.colors.onPrimary,
                ),
              ),
              FixedSiderMenu(
                backgroundColor: theme.colors.primary,
                activeForegroundColor: theme.colors.selection,
                subMenuColor: Colors.indigo[900]!,
                foregroundColor: theme.colors.textOnLight,
                activeBackgroundColor: Colors.indigo[800]!,
              )
            ],
          ),
        ),
      ),
    );
  }
}
