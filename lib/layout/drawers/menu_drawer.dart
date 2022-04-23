import 'package:flutter/material.dart';
import 'package:legend_design_core/icons/legend_animated_icon.dart';
import 'package:legend_design_core/layout/fixed/sider/menu/fixed_sider_menu.dart';
import 'package:legend_design_core/router/legend_router.dart';
import 'package:legend_design_core/styles/legend_theme.dart';
import 'package:legend_design_core/styles/sizing/size_info.dart';
import 'package:provider/provider.dart';

class MenuDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    LegendTheme theme = Provider.of<LegendTheme>(context);
    SizeInfo sizeInfo = SizeInfo.of(context);
    bool isMobile = sizeInfo.isMobile;
    double mWidth = sizeInfo.width;
    double width = isMobile ? mWidth * 0.8 : 400;
    double topPadding = MediaQuery.of(context).padding.top;

    EdgeInsetsGeometry padding = isMobile
        ? EdgeInsets.only(
            top: topPadding,
            left: 12,
            right: 12,
          )
        : EdgeInsets.symmetric(
            horizontal: 24,
          );

    return SizedBox(
      width: width,
      child: Drawer(
        elevation: 4,
        child: Container(
          color: theme.colors.primary,
          padding: padding,
          child: ListView(
            padding: EdgeInsets.zero,
            shrinkWrap: true,
            //   crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: theme.sizing.appBarSizing.appBarHeight - 4,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.center,
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
              ),
              Divider(
                height: 4,
                thickness: 1,
                color: theme.colors.onPrimary,
              ),
              const SizedBox(
                height: 24,
              ),
              FixedSiderMenu(
                background: theme.colors.primary,
                activeForeground: theme.colors.selection,
                subMenuColor: Colors.indigo[900]!,
                foreground: theme.colors.textOnLight,
                activeBackground: Colors.indigo[800]!,
                spacing: 6,
                options: LegendRouter.of(context).menuOptions,
                showMenuSubItems: true,
                collapsed: false,
              ),
              const SizedBox(
                height: 24,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
