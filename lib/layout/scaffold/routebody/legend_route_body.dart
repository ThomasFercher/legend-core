import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:legend_design_core/layout/appBar.dart/appbar_layout.dart';
import 'package:legend_design_core/layout/appBar.dart/slivers/persistent_header.dart';
import 'package:legend_design_core/layout/scaffold/routebody/layouts/builder_body.dart';
import 'package:legend_design_core/layout/scaffold/routebody/layouts/children_body.dart';
import 'package:legend_design_core/layout/scaffold/routebody/layouts/single_body.dart';
import 'package:legend_design_core/layout/scaffold/routebody/layouts/sliver_body.dart';
import 'package:legend_design_core/layout/scaffold/routebody/route_body_info.dart';
import 'package:legend_design_core/layout/sider/sider_layout.dart';
import 'package:legend_design_core/widgets/decoration/inner_elevation.dart';
import 'package:legend_design_core/widgets/layout/has_height.dart';
import 'package:legend_design_core/widgets/shadow/inner_box_decoration.dart';
import 'package:legend_design_core/state/legend_state.dart';
import 'package:legend_design_core/layout/scaffold/scaffold_info.dart';
import 'package:legend_design_core/widgets/size_info.dart';
import 'package:legend_utils/extensions/boolean.dart';

typedef ChildrenBuilder = List<Widget> Function(
  ScrollController controller,
  Size s,
);

typedef SliverBuilder = List<Widget> Function(
  ScrollController controller,
);

///
/// This Widget will displayed directly under the Navigator/Router hence is a Page.
/// Here the layout will be determined for all pages. If there is a Sider or a Fixed Appbar they
/// wont be layout here but further up in the Scaffold Frame which is above the Navigator/Router and more suited for
/// fixed Widgets.
///
class LegendRouteBody extends HookWidget {
  final ChildrenBuilder? children;

  final SliverBuilder? slivers;
  final double? initalScrollOffset;
  final EdgeInsets? contentPadding;
  final bool? singlePage;
  final bool disableContentDecoration;
  final Widget Function(BuildContext context, Size s)? builder;
  final HasHeight? sliverAppBar;
  final PersistentHeader? sliverPersistentHeader;
  final double? maxContentWidth;
  final ScrollPhysics? physics;
  final Widget Function(
    Widget listView,
    ScrollController scrollController,
    BuildContext context,
  )? listWrapper;

  const LegendRouteBody({
    super.key,
    this.children,
    this.slivers,
    this.builder,
    this.singlePage,
    this.disableContentDecoration = false,
    this.sliverAppBar,
    this.sliverPersistentHeader,
    this.maxContentWidth,
    this.listWrapper,
    this.physics,
    this.initalScrollOffset,
    this.contentPadding,
  }) : assert(children != null || builder != null || slivers != null);

  @override
  Widget build(BuildContext context) {
    final theme = LegendTheme.of(context);
    final info = ScaffoldInfo.of(context);
    final single = singlePage ?? info.scaffold.config.whether.singlePage;

    final showSliverBar = sliverAppBar != null &&
        info.routeLayout.appBarLayout.layout == AppBarLayoutConfig.body;
    final controller = useScrollController(
      initialScrollOffset: initalScrollOffset ?? 0,
      keys: [initalScrollOffset],
    );
    final siderLayout = info.routeLayout.siderLayout;

    final shadowSide = siderLayout is NoSiderLayout
        ? null
        : siderLayout.left
            ? ShadowSide.left
            : ShadowSide.right;

    final combineShadows = info.showHeader || showSliverBar;

    final showFooter = info.showFooter(context);

    return LayoutBuilder(builder: (context, connstraints) {
      return RouteBodyInfo(
        info: this,
        constraints: connstraints,
        scrollController: controller,
        showSliverBar: showSliverBar,
        showFooter: showFooter,
        child: ScrollConfiguration(
          behavior: ScrollConfiguration.of(context).copyWith(
            scrollbars: false,
            physics: physics,
          ),
          child: Scrollbar(
            controller: controller,
            child: ColoredBox(
              color: theme.colors.background1,
              child: InnerElevation(
                shadowSide: shadowSide,
                combineShadows: combineShadows,
                child: _Body(single, children, slivers),
              ),
            ),
          ),
        ),
      );
    });
  }
}

class _Body extends StatelessWidget {
  final ChildrenBuilder? children;
  final SliverBuilder? slivers;
  final bool single;

  const _Body(
    this.single,
    this.children,
    this.slivers,
  );

  @override
  Widget build(BuildContext context) {
    if (children.notNull) return ChildrenBody(children: children!);
    if (slivers.notNull) return SliverBody(slivers: slivers!);
    if (single) return SingleBody();
    return BuilderBody();
  }
}
