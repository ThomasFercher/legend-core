import 'package:flutter/material.dart';
import 'package:legend_design_core/styles/legend_theme.dart';
import 'package:legend_design_core/styles/sizing/sub_sizing/footer_sizing.dart';
import 'package:provider/provider.dart';

class FixedFooter extends StatefulWidget {
  late FixedFooterSizing? sizing;
  late FooterPalette? colors;

  final Widget Function(
    BuildContext context,
    FixedFooterSizing? sizing,
    FooterPalette? colors,
  ) builder;

  FixedFooter({
    Key? key,
    required this.builder,
    this.sizing,
    this.colors,
  }) : super(key: key);

  @override
  State<FixedFooter> createState() => _FixedFooterState();
}

class _FixedFooterState extends State<FixedFooter> {
  @override
  void initState() {
    super.initState();
    if (widget.colors == null) {
      WidgetsBinding.instance?.addPostFrameCallback((_) {
        LegendTheme theme = Provider.of<LegendTheme>(context, listen: false);
        widget.colors = theme.colors.footerPalette;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    LegendTheme theme = context.watch<LegendTheme>();

    return Container(
      width: MediaQuery.of(context).size.width,
      height: widget.sizing?.height,
      decoration: BoxDecoration(
        color: theme.colors.footerPalette.background,
        /*     boxShadow: [
          BoxShadow(
            color: Colors.black12,
            spreadRadius: 3,
            blurRadius: 6,
            offset: Offset(6, 0),
          )
        ],*/
      ),
      alignment: Alignment.center,
      child: Container(
        constraints: BoxConstraints(
          maxWidth: widget.sizing?.maxWidth ?? 800,
        ),
        padding: widget.sizing?.padding,
        child: Builder(
          builder: (context) => widget.builder(
            context,
            widget.sizing,
            widget.colors,
          ),
        ),
      ),
    );
  }
}
