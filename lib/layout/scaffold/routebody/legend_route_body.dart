import 'package:flutter/material.dart';
import 'package:legend_design_core/layout/appBar.dart/slivers/persistent_header.dart';
import 'package:legend_design_core/layout/scaffold/contents/scaffold_footer.dart';
import 'package:legend_design_core/layout/scaffold/legend_scaffold.dart';
import 'package:legend_design_core/layout/scaffold/routebody/layouts/builder_body.dart';
import 'package:legend_design_core/layout/scaffold/routebody/layouts/children_body.dart';
import 'package:legend_design_core/layout/scaffold/routebody/layouts/single_body.dart';
import 'package:legend_design_core/layout/scaffold/routebody/layouts/sliver_body.dart';
import 'package:legend_design_core/layout/scaffold/routebody/route_body_info.dart';
import 'package:legend_utils/extensions/extensions.dart';
import 'package:legend_design_core/state/legend_state.dart';
import 'package:legend_design_core/layout/scaffold/scaffold_info.dart';

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

  Widget _body(bool single) {
    if (children.isNotEmpty) {
      return ChildrenBody();
    }
    if (slivers.isNotEmpty) {
      return SliverBody();
    }
    if (single) {
      return SingleBody();
    }
    return BuilderBody();
  }

  @override
  Widget build(BuildContext context, LegendTheme theme) {
    final info = ScaffoldInfo.of(context)!;
    final scaffold = info.scaffold;
    final showFooter = info.showFooter(context);
    final single = singlePage ?? scaffold.whether.singlePage;
    final ScrollController controller = ScrollController();

    return LayoutBuilder(
      builder: (context, constraints) {
        return RouteBodyInfo(
          info: this,
          constraints: constraints,
          scrollController: controller,
          showFooter: showFooter,
          child: ScrollConfiguration(
            behavior: ScrollConfiguration.of(context).copyWith(
              scrollbars: false,
            ),
            child: Scrollbar(
              controller: controller,
              child: ColoredBox(
                color: theme.colors.background1,
                child: _body(single),
              ),
            ),
          ),
        );
      },
    );
  }
}
