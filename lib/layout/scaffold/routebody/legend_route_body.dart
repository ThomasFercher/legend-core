import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:legend_design_core/layout/appBar.dart/appbar_layout.dart';
import 'package:legend_design_core/layout/appBar.dart/slivers/persistent_header.dart';
import 'package:legend_design_core/layout/scaffold/routebody/layouts/builder_body.dart';
import 'package:legend_design_core/layout/scaffold/routebody/layouts/children_body.dart';
import 'package:legend_design_core/layout/scaffold/routebody/layouts/single_body.dart';
import 'package:legend_design_core/layout/scaffold/routebody/layouts/sliver_body.dart';
import 'package:legend_design_core/layout/scaffold/routebody/route_body_info.dart';
import 'package:legend_design_core/widgets/decoration/inner_elevation.dart';
import 'package:legend_design_core/widgets/layout/has_height.dart';
import 'package:legend_design_core/widgets/shadow/inner_box_decoration.dart';
import 'package:legend_design_core/state/legend_state.dart';
import 'package:legend_design_core/layout/scaffold/scaffold_info.dart';

///
/// This Widget will displayed directly under the Navigator/Router hence is a Page.
/// Here the layout will be determined for all pages. If there is a Sider or a Fixed Appbar they
/// wont be layout here but further up in the Scaffold Frame which is above the Navigator/Router and more suited for
/// fixed Widgets.
///
class LegendRouteBody extends HookWidget {
  final List<Widget> children;

  /// A List of Slivers which will be provided to a CustomScrollView
  final List<Widget> slivers;
  final bool? singlePage;
  final bool disableContentDecoration;
  final Widget Function(BuildContext context, Size s)? builder;
  final HasHeight? sliverAppBar;
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
  Widget build(BuildContext context) {
    final theme = LegendTheme.of(context);
    final info = ScaffoldInfo.of(context)!;
    final layout = info.routeLayout;
    final scaffold = info.scaffold;
    final single = singlePage ?? scaffold.whether.singlePage;

    final bool showSliverBar = sliverAppBar != null &&
        layout.appBarLayout?.layout == AppBarLayoutConfig.body;
    final ScrollController controller = ScrollController();
    final siderLayout = layout.siderLayout;

    final ShadowSide? shadowSide = siderLayout == null
        ? null
        : siderLayout.left
            ? ShadowSide.left
            : ShadowSide.right;

    final combineShadows = info.showHeader || showSliverBar;

    final bool showFooter = info.showFooter(context);

    return LayoutBuilder(
      builder: (context, constraints) {
        return RouteBodyInfo(
          info: this,
          constraints: constraints,
          scrollController: controller,
          showSliverBar: showSliverBar,
          showFooter: showFooter,
          child: ScrollConfiguration(
            behavior: ScrollConfiguration.of(context).copyWith(
              scrollbars: false,
            ),
            child: Scrollbar(
              controller: controller,
              child: ColoredBox(
                color: theme.colors.background1,
                child: InnerElevation(
                  shadowSide: shadowSide,
                  combineShadows: combineShadows,
                  child: _body(single),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
