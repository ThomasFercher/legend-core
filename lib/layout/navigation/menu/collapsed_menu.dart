import 'package:flutter/material.dart';
import 'package:legend_design_core/layout/appBar.dart/appbar_provider.dart';
import 'package:legend_design_core/legend_design_core.dart';
import 'package:legend_design_core/widgets/icons/legend_animated_icon.dart';
import 'package:legend_router/router/legend_router.dart';
import 'package:legend_design_core/styles/legend_theme.dart';
import 'package:legend_router/router/modal_router.dart';

class CollapsedMenu extends StatefulWidget {
  final double width;

  const CollapsedMenu({
    Key? key,
    required this.width,
  }) : super(key: key);

  @override
  State<CollapsedMenu> createState() => _CollapsedMenuState();
}

class _CollapsedMenuState extends State<CollapsedMenu> {
  @override
  Widget build(BuildContext context) {
    LegendTheme theme = LegendTheme.of(context);

    return Container(
      width: widget.width,
      alignment: Alignment.center,
      child: LegendAnimatedIcon(
        padding: EdgeInsets.all(0),
        iconSize: theme.appBarSizing.iconSize,
        onPressed: () {
          /*   ModalRouter.of(context).push(
            settings: RouteSettings(name: '/menudrawer'),
            useKey: true,
          );*/

          context.read<AppBarProvider>().show(true);
        },
        icon: Icons.menu,
        disableShadow: true,
        theme: LegendAnimtedIconTheme(
          disabled: theme.colors.appBar.foreground,
          enabled: theme.colors.selection,
        ),
      ),
    );
  }
}
