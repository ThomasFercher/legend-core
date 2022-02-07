import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:legend_design_core/layout/drawers/menu_drawer.dart';
import 'package:legend_design_core/layout/fixed/appBar.dart/persistent_header.dart';
import 'package:legend_design_core/layout/layout_provider.dart';
import 'package:legend_design_core/layout/scaffold/scaffoldInfo.dart';
import 'package:legend_design_core/layout/scaffold/scaffold_action_button.dart';
import 'package:legend_design_core/layout/scaffold/scaffold_content.dart';
import 'package:legend_design_core/layout/scaffold/scaffold_drawer.dart';
import 'package:legend_design_core/layout/scaffold/scaffold_footer.dart';
import 'package:legend_design_core/layout/scaffold/scaffold_header.dart';
import 'package:legend_design_core/layout/scaffold/scaffold_sider.dart';
import 'package:legend_design_core/layout/scaffold/scaffold_title.dart';
import 'package:legend_design_core/layout/sectionNavigation/section_navigation.dart';
import 'package:legend_design_core/objects/menu_option.dart';
import 'package:legend_design_core/router/routeInfoProvider.dart';
import 'package:legend_design_core/router/routes/section_provider.dart';
import 'package:legend_design_core/router/routes/section_route_info.dart';
import 'package:legend_design_core/styles/layouts/layout_type.dart';
import 'package:legend_design_core/styles/theming/sizing/legend_sizing.dart';
import 'package:legend_design_core/styles/theming/sizing/size_provider.dart';
import 'package:legend_design_core/styles/theming/theme_provider.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

import '../../typography/legend_text.dart';
import '../fixed/bottomBar.dart/fixed_bottom_bar.dart';
import '../fixed/fixed_footer.dart';

class LegendScaffold extends StatelessWidget {
  final LayoutType layoutType;
  final String pageName;
  final void Function(BuildContext context)? onActionButtonPressed;
  final WidgetBuilder? siderBuilder;
  final WidgetBuilder? appBarBuilder;
  final Widget Function(BuildContext context, Size size)? contentBuilder;
  final FixedFooter? customFooter;
  final Widget? appBarBottom;
  final Size? appBarBottomSize;
  final double? maxContentWidth;
  final List<Widget> children;
  final double verticalChildrenSpacing;
  final List<SingleChildWidget>? providers;
  final bool disableContentDecoration;
  final bool showSiderMenu;
  final bool showSiderSubMenu;
  final bool showAppBarMenu;
  final bool showSectionMenu;
  final bool showTopSubMenu;
  final bool enableDefaultSettings;
  final bool singlePage;
  final bool isUnderlyingRoute;
  List<SectionRouteInfo>? sections;
  MenuOption? currentRoute;

  LegendScaffold({
    Key? key,
    required this.pageName,
    required this.layoutType,
    this.onActionButtonPressed,
    this.siderBuilder,
    this.showSiderMenu = false,
    this.showAppBarMenu = true,
    this.appBarBuilder,
    this.showSiderSubMenu = false,
    this.contentBuilder,
    this.children = const [],
    this.singlePage = false,
    this.customFooter,
    this.verticalChildrenSpacing = 8,
    this.isUnderlyingRoute = false,
    this.showSectionMenu = false,
    this.showTopSubMenu = true,
    this.maxContentWidth,
    this.appBarBottom,
    this.disableContentDecoration = false,
    this.enableDefaultSettings = false,
    this.providers,
    this.appBarBottomSize,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    sections = SectionProvider.of(context)?.sections;

    return ScaffoldInfo(
      scaffold: this,
      child: SizeProvider(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        useMobilDesign: true,
        context: context,
        child: SectionNavigation(
          sections: sections,
          onNavigate: (section) {
            // Jump to Section

            if (sections != null) {
              SectionRouteInfo s = sections!.singleWhere(
                (element) => element.name == section.name,
                orElse: () {
                  return sections!.first;
                },
              );
              if (s.key != null && s.key?.currentContext != null) {
                Scrollable.ensureVisible(
                  s.key!.currentContext!,
                  curve: Curves.easeInOut,
                  duration: Duration(
                    milliseconds: 400,
                  ),
                );
              }
            }
          },
          child: providers != null
              ? MultiProvider(
                  providers: providers!,
                  builder: (context, child) {
                    return layout(context);
                  },
                )
              : Builder(
                  builder: (context) {
                    return layout(context);
                  },
                ),
        ),
      ),
    );
  }

  double calculateMinContentHeight(double? footerHeight, BuildContext context) {
    ThemeProvider theme = context.watch<ThemeProvider>();
    double height = MediaQuery.of(context).size.height;

    if (theme.sizingTheme.sizingType != LegendSizingType.MOBILE) {
      height -= footerHeight ?? 0;
    } else {
      height -= theme.bottomBarStyle?.height ?? 0;
    }

    if (layoutType == LayoutType.FixedSider) {
      height -= theme.sizing.padding[0] * 4;
    } else if (layoutType == LayoutType.Content) {
    } else {
      height -= theme.appBarSizing.appBarHeight;
    }

    if (appBarBottom != null) {
      height -= appBarBottomSize!.height;
    }

    return height;
  }

  List<Widget> getChildren(BuildContext context, bool showFooter) {
    ThemeProvider theme = context.watch<ThemeProvider>();
    List<Widget> widgets = [];
    List<Widget> s_widgets = [];
    // Get Children
    if (sections != null) {
      s_widgets = SectionNavigation.findSections(context, children, sections!);
    } else {
      s_widgets = children;
    }

    widgets = List.of(
      s_widgets.map(
        (widget) {
          return Padding(
            padding: EdgeInsets.symmetric(
              horizontal: theme.sizing.padding[0],
              vertical: verticalChildrenSpacing,
            ),
            child: widget,
          );
        },
      ),
    );

    if (showFooter) widgets.add(ScaffoldFooter());

    return widgets;
  }

  Widget layout(BuildContext context) {
    ThemeProvider theme = context.watch<ThemeProvider>();
    SizeProvider sizeProvider = SizeProvider.of(context);
    bool showBuilder = children.isEmpty && contentBuilder != null;
    bool showAppBarBottom = appBarBottom != null && appBarBottomSize != null;
    bool showTitle = (layoutType == LayoutType.FixedHeaderSider) &&
        (sizeProvider.isMobile == false);

    currentRoute = RouteInfoProvider.getCurrentMenuOption(context);
    theme.menuWidthChanged(context);

    // Footer
    double? footerheight;
    if (!sizeProvider.isMobile && layoutType != LayoutType.Content) {
      footerheight =
          LayoutProvider.of(context)?.globalFooter?.sizing?.height ?? 0;
    }
    double maxHeight = calculateMinContentHeight(footerheight, context);

    return Stack(
      children: [
        Scaffold(
          endDrawer: MenuDrawer(),
          bottomNavigationBar: sizeProvider.isMobile
              ? FixedBottomBar(
                  colors: theme.bottomBarColors, sizing: theme.bottomBarStyle)
              : null,
          endDrawerEnableOpenDragGesture: false,
          floatingActionButton:
              onActionButtonPressed != null ? ScaffoldActionButton() : null,
          body: ColoredBox(
            color: theme.colors.scaffoldBackgroundColor,
            child: Stack(
              children: [
                Row(
                  children: [
                    ScaffoldSider(),
                    Expanded(
                      child: CustomScrollView(
                        slivers: [
                          ScaffoldHeader(),
                          if (showAppBarBottom)
                            SliverPersistentHeader(
                              pinned: true,
                              delegate: PersistentHeader(
                                child: appBarBottom!,
                                maxHeight: appBarBottomSize!.height,
                                minHeight: appBarBottomSize!.width,
                                backgroundColor:
                                    theme.colors.scaffoldBackgroundColor,
                              ),
                            ),
                          if (showBuilder)
                            SliverToBoxAdapter(
                              child: Column(
                                children: [
                                  Container(
                                    constraints: BoxConstraints(
                                      minHeight: maxHeight,
                                      maxHeight: singlePage
                                          ? maxHeight
                                          : double.infinity,
                                    ),
                                    padding: disableContentDecoration
                                        ? null
                                        : EdgeInsets.all(
                                            theme.sizing.padding[0],
                                          ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        if (currentRoute?.isUnderlying ?? false)
                                          LegendText(
                                            padding: EdgeInsets.only(
                                              bottom: 8,
                                            ),
                                            text: currentRoute?.title ?? '',
                                            textStyle:
                                                theme.typography.h5.copyWith(
                                              color: theme.colors.textContrast,
                                            ),
                                          ),
                                        ScaffoldContent(
                                          maxHeight: maxHeight,
                                        )
                                      ],
                                    ),
                                  ),
                                  if (footerheight != null) ScaffoldFooter(),
                                ],
                              ),
                            )
                          else
                            SliverList(
                              delegate: SliverChildListDelegate(
                                getChildren(context, footerheight != null),
                              ),
                            ),
                        ],
                      ),
                    ),
                  ],
                ),
                if (showTitle) ScaffoldTitle(),
              ],
            ),
          ),
        ),
        ScaffoldDrawer(),
      ],
    );
  }
}
