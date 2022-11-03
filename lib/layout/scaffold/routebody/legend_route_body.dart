import 'package:flutter/material.dart';
import 'package:legend_design_core/layout/appBar.dart/slivers/persistent_header.dart';
import 'package:legend_design_core/layout/scaffold/contents/scaffold_footer.dart';
import 'package:legend_design_core/layout/scaffold/legend_scaffold.dart';
import 'package:legend_utils/extensions/extensions.dart';
import 'package:legend_design_core/state/legend_state.dart';
import 'package:legend_design_core/layout/scaffold/scaffoldInfo.dart';

///
/// This Widget will displayed directly under the Navigator/Router hence is a Page.
/// Here the layout will be determined for all pages. If there is a Sider or a Fixed Appbar they
/// wont be layout here but further up in the Scaffold Frame which is above the Navigator/Router and more suited for
/// fixed Widgets.
///
class LegendRouteBody extends LegendWidget {
  final List<Widget> children;

  /// A List of Slivers which will be provided to a CustomScrollView
  final List<Widget> slivers;
  final bool? singlePage;
  final bool disableContentDecoration;
  final Widget Function(BuildContext context, Size s)? builder;
  final Widget? sliverAppBar;
  final PersistentHeader? sliverPersistentHeader;

  LegendRouteBody({
    Key? key,
    this.children = const [],
    this.slivers = const [],
    this.builder,
    this.singlePage,
    this.disableContentDecoration = false,
    this.sliverAppBar,
    this.sliverPersistentHeader,
  }) : super(key: key) {
    assert(children.isNotEmpty || builder != null || slivers.isNotEmpty);
  }

  @override
  Widget build(BuildContext context, LegendTheme theme) {
    ScaffoldInfo info = ScaffoldInfo.of(context);
    LegendScaffold scaffold = info.scaffold;
    bool showFooter = info.showFooter(context);
    bool single = singlePage ?? scaffold.whether.singlePage;

    double footerHeight = showFooter
        ? theme.scaffoldConfig.builders?.customFooter?.sizing?.height ?? 0
        : 0;

    EdgeInsetsGeometry contentPadding = !disableContentDecoration
        ? EdgeInsets.all(theme.sizing.spacing1)
        : EdgeInsets.zero;

    final ScrollController controller = ScrollController();

    return ScrollConfiguration(
      behavior: ScrollConfiguration.of(context).copyWith(
        scrollbars: false,
      ),
      child: Scrollbar(
        controller: controller,
        child: ColoredBox(
          color: theme.colors.background1,
          child: LayoutBuilder(
            builder: (context, constraints) {
              if (children.isNotEmpty) {
                List<Widget> _children = List.of(
                  children.map(
                    (child) => Container(
                      padding: EdgeInsets.symmetric(
                              horizontal: theme.sizing.spacing1)
                          .boolInit(!disableContentDecoration),
                      child: child,
                    ),
                  ),
                );

                return Container(
                  height: constraints.maxHeight,
                  child: CustomScrollView(
                    controller: controller,
                    slivers: [
                      if (sliverAppBar != null) sliverAppBar!,
                      if (sliverPersistentHeader != null)
                        SliverPersistentHeader(
                          delegate: sliverPersistentHeader!,
                        ),
                      SliverList(
                        delegate: SliverChildBuilderDelegate(
                          childCount: _children.length,
                          (context, i) => _children[i],
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
              } else if (slivers.isNotEmpty) {
                return Container(
                  height: constraints.maxHeight,
                  child: CustomScrollView(
                    controller: controller,
                    slivers: slivers,
                  ),
                );
              } else if (single) {
                return Column(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: contentPadding,
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
                  controller: controller,
                  slivers: [
                    if (sliverAppBar != null) sliverAppBar!,
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: contentPadding,
                        child: Builder(
                          builder: (context) => builder!(
                            context,
                            Size(constraints.maxWidth, double.infinity),
                          ),
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
        ),
      ),
    );
  }
}
