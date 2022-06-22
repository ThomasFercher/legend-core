import 'package:flutter/material.dart';
import 'package:legend_design_core/layout/appBar.dart/slivers/persistent_header.dart';
import 'package:legend_design_core/layout/layout_provider.dart';
import 'package:legend_design_core/layout/scaffold/contents/scaffold_footer.dart';
import 'package:legend_design_core/layout/scaffold/legend_scaffold.dart';
import 'package:legend_utils/extensions/extensions.dart';
import 'package:provider/provider.dart';
import '../../../styles/legend_theme.dart';

///
/// This Widget will displayed directly under the Navigator/Router hence is a Page.
/// Here the layout will be determined for all pages. If there is a Sider or a Fixed Appbar they
/// wont be layout here but further up in the Scaffold Frame which is above the Navigator/Router and more suited for
/// fixed Widgets.
///
class LegendRouteBody extends StatelessWidget {
  final List<Widget> slivers;
  final bool? singlePage;
  final bool disableContentDecoration;
  final Widget Function(BuildContext context, Size s)? builder;
  final Widget? sliverAppBar;
  final PersistentHeader? sliverPersistentHeader;

  LegendRouteBody({
    Key? key,
    this.slivers = const [],
    this.builder,
    this.singlePage,
    this.disableContentDecoration = false,
    this.sliverAppBar,
    this.sliverPersistentHeader,
  }) : super(key: key) {
    assert(slivers.isNotEmpty || builder != null);
  }

  @override
  Widget build(BuildContext context) {
    LegendTheme theme = context.watch<LegendTheme>();
    ScaffoldInfo info = ScaffoldInfo.of(context);
    LegendScaffold scaffold = info.scaffold;
    bool showFooter = info.showFooter(context);
    bool single = singlePage ?? scaffold.whether.singlePage;

    double footerHeight = showFooter
        ? theme.scaffoldConfig?.builders?.customFooter?.sizing?.height ?? 0
        : 0;

    return ColoredBox(
      color: theme.colors.background1,
      child: LayoutBuilder(
        builder: (context, constraints) {
          if (slivers.isNotEmpty) {
            List<Widget> _slivers = List.of(
              slivers.map(
                (sliver) => Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: theme.sizing.spacing1)
                          .boolInit(!disableContentDecoration),
                  child: sliver,
                ),
              ),
            );

            return Container(
              child: CustomScrollView(
                slivers: [
                  if (sliverAppBar != null) sliverAppBar!,
                  if (sliverPersistentHeader != null)
                    SliverPersistentHeader(
                      delegate: sliverPersistentHeader!,
                    ),
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
                    padding: EdgeInsets.all(theme.sizing.spacing1).boolInit(
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
                if (sliverAppBar != null) sliverAppBar!,
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
      ),
    );
  }
}
