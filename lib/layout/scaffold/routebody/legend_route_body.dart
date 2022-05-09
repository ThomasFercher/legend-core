import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:legend_design_core/layout/layout_provider.dart';
import 'package:legend_design_core/layout/scaffold/contents/scaffold_footer.dart';
import 'package:legend_design_core/layout/scaffold/legend_scaffold.dart';
import 'package:legend_design_core/layout/scaffold/scaffoldInfo.dart';
import 'package:legend_design_core/styles/sizing/size_info.dart';
import 'package:legend_utils/extensions/extensions.dart';
import 'package:provider/provider.dart';

import '../../../styles/legend_theme.dart';

class LegendRouteBody extends StatelessWidget {
  final List<Widget> slivers;
  final bool? singlePage;
  final bool disableContentDecoration;
  final Widget Function(BuildContext context, Size s)? builder;
  final Widget? sliverAppBar;

  LegendRouteBody({
    Key? key,
    this.slivers = const [],
    this.builder,
    this.singlePage,
    this.disableContentDecoration = false,
    this.sliverAppBar,
  }) : super(key: key) {
    assert(slivers.isNotEmpty || builder != null);
  }

  @override
  Widget build(BuildContext context) {
    LegendTheme theme = context.watch<LegendTheme>();
    LegendScaffold scaffold = ScaffoldInfo.of(context).scaffold;

    bool showFooter = !theme.sizing.showBottomBar;
    bool single = singlePage ?? scaffold.whether.singlePage;

    double footerHeight = 0;

    if (showFooter) {
      footerHeight =
          LayoutProvider.of(context)?.globalFooter?.sizing?.height ?? 0;
    }
    return LayoutBuilder(
      builder: (context, constraints) {
        if (slivers.isNotEmpty) {
          List<Widget> _slivers = List.of(
            slivers.map(
              (sliver) => Container(
                padding:
                    EdgeInsets.symmetric(horizontal: theme.sizing.padding[0])
                        .boolInit(!disableContentDecoration),
                child: sliver,
              ),
            ),
          );

          return Container(
            child: CustomScrollView(
              slivers: [
                if (sliverAppBar != null) sliverAppBar!,
                SliverList(
                  delegate: SliverChildListDelegate(
                    _slivers,
                  ),
                ),
                SliverFillRemaining(
                  hasScrollBody: false,
                  child: Column(
                    children: <Widget>[
                      Expanded(child: Container()),
                      if (showFooter) ScaffoldFooter(),
                    ],
                  ),
                ),
              ],
            ),
          );
        } else if (single) {
          return Column(
            children: [
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(theme.sizing.padding[0]).boolInit(
                    !disableContentDecoration,
                  ),
                  child: Builder(
                    builder: (BuildContext context) {
                      return builder!(
                        context,
                        Size(
                          constraints.maxWidth,
                          constraints.maxHeight - footerHeight,
                        ),
                      );
                    },
                  ),
                ),
              ),
              if (showFooter) ScaffoldFooter(),
            ],
          );
        } else {
          return CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: Builder(
                  builder: (context) => builder!(
                    context,
                    Size(constraints.maxWidth, double.infinity),
                  ),
                ),
              ),
              SliverFillRemaining(
                hasScrollBody: false,
                child: Column(
                  children: <Widget>[
                    Expanded(child: Container()),
                    if (showFooter) ScaffoldFooter(),
                  ],
                ),
              ),
            ],
          );
        }
      },
    );
  }
}
