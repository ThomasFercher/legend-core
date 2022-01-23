import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:legend_design_core/layout/drawers/legend_drawer.dart';
import 'package:legend_design_core/layout/drawers/legend_drawer_info.dart';
import 'package:legend_design_core/layout/drawers/legend_drawer_provider.dart';
import 'package:legend_design_core/layout/drawers/menu_drawer.dart';
import 'package:legend_design_core/layout/layout_provider.dart';
import 'package:legend_design_core/layout/sectionNavigation/section_navigation.dart';
import 'package:legend_design_core/layout/sections/section.dart';
import 'package:legend_design_core/objects/menu_option.dart';
import 'package:legend_design_core/router/routeInfoProvider.dart';
import 'package:legend_design_core/router/router_provider.dart';
import 'package:legend_design_core/router/routes/section_provider.dart';
import 'package:legend_design_core/router/routes/section_route_info.dart';
import 'package:legend_design_core/styles/layouts/layout_type.dart';
import 'package:legend_design_core/styles/theming/sizing/legend_sizing.dart';
import 'package:legend_design_core/styles/theming/sizing/size_provider.dart';
import 'package:legend_design_core/styles/theming/theme_provider.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'fixed/appBar.dart/fixed_appbar.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'fixed/bottomBar.dart/fixed_bottom_bar.dart';
import 'fixed/fixed_footer.dart';
import 'fixed/sider/fixed_sider.dart';
import '../typography/legend_text.dart';

class LegendScaffold extends StatefulWidget {
  final LayoutType? layoutType;
  final String pageName;
  final Function(BuildContext context)? onActionButtonPressed;
  final WidgetBuilder? siderBuilder;
  final WidgetBuilder? appBarBuilder;
  final bool? showSiderMenu;
  final bool? showSiderSubMenu;
  final bool? showAppBarMenu;
  late final bool singlePage;
  late final List<Widget> children;
  late final Widget Function(BuildContext context, Size size)? contentBuilder;
  late final FixedFooter? customFooter;
  final double? verticalChildrenSpacing;
  late final bool isUnderlyingRoute;
  final bool? showSectionMenu;
  final bool? showTopSubMenu;
  final bool disableContentDecoration;
  final double? maxContentWidth;
  final bool enableDefaultSettings;
  final List<SingleChildWidget>? providers;

  LegendScaffold({
    required this.pageName,
    this.layoutType,
    this.onActionButtonPressed,
    this.siderBuilder,
    this.showSiderMenu,
    this.showAppBarMenu,
    this.appBarBuilder,
    this.showSiderSubMenu,
    this.contentBuilder,
    List<Widget>? children,
    bool? singlePage,
    Key? key,
    this.customFooter,
    this.verticalChildrenSpacing,
    bool? isUnderlyingRoute,
    this.showSectionMenu,
    this.showTopSubMenu,
    this.maxContentWidth,
    this.disableContentDecoration = false,
    this.enableDefaultSettings = false,
    this.providers,
  }) : super(key: key) {
    this.singlePage = singlePage ?? false;
    this.children = children ?? [];

    this.isUnderlyingRoute = isUnderlyingRoute ?? false;
  }

  @override
  _LegendScaffoldState createState() => _LegendScaffoldState();
}

class _LegendScaffoldState extends State<LegendScaffold> {
  List<SectionRouteInfo>? sections;

  late ScrollController controller;

  late bool showSettings;
  MenuOption? currentRoute;

  @override
  void initState() {
    super.initState();

    showSettings = false;
    controller = ScrollController(
      initialScrollOffset: 0,
    );
  }

  @override
  Widget build(BuildContext context) {
    sections = SectionProvider.of(context)?.sections;

    return SizeProvider(
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
        child: widget.providers != null
            ? MultiProvider(
                providers: widget.providers!,
                builder: (context, child) {
                  if (kIsWeb) {
                    return materialLayout(context);
                  } else if (Platform.isIOS || Platform.isMacOS) {
                    return cupertinoLayout(context);
                  } else {
                    return materialLayout(context);
                  }
                },
              )
            : Builder(
                builder: (context) {
                  if (kIsWeb) {
                    return materialLayout(context);
                  } else if (Platform.isIOS || Platform.isMacOS) {
                    return cupertinoLayout(context);
                  } else {
                    return materialLayout(context);
                  }
                },
              ),
      ),
    );
  }

  Widget cupertinoLayout(BuildContext context) {
    return CupertinoPageScaffold(
      child: Container(),
    );
  }

  Widget getSider(ScreenSize screenSize, BuildContext context) {
    if (widget.layoutType == LayoutType.FixedSider) {
      return FixedSider(
        builder: widget.siderBuilder,
        showMenu: widget.showSiderMenu,
        showSubMenu: widget.showSiderSubMenu,
        showSectionMenu: widget.showSectionMenu,
        layoutType: widget.layoutType,
      );
    } else if (widget.layoutType == LayoutType.FixedHeaderSider &&
        screenSize != ScreenSize.Small) {
      return FixedSider(
        builder: widget.siderBuilder,
        showMenu: widget.showSiderMenu,
        showSubMenu: widget.showSiderSubMenu,
        showSectionMenu: widget.showSectionMenu,
        layoutType: widget.layoutType,
      );
    } else {
      return Container();
    }
  }

  Widget getFooter(double height, BuildContext context) {
    if (widget.layoutType != LayoutType.Content) {
      return LayoutProvider.of(context)?.globalFooter ?? Container();
    } else {
      return Container();
    }
  }

  Widget getHeader(BuildContext context) {
    ThemeProvider theme = context.watch<ThemeProvider>();

    switch (widget.layoutType) {
      case LayoutType.FixedHeaderSider:
        return FixedAppBar(
          showMenu: SizeProvider.of(context).isMobile == false
              ? widget.showAppBarMenu
              : false,
          builder: widget.appBarBuilder,
          layoutType: widget.layoutType,
          showSubMenu: widget.showTopSubMenu ?? true,
        );
      case LayoutType.FixedHeader:
        return FixedAppBar(
          builder: widget.appBarBuilder,
          showMenu: SizeProvider.of(context).isMobile == false
              ? widget.showAppBarMenu
              : false,
          layoutType: widget.layoutType,
          showSubMenu: widget.showTopSubMenu ?? true,
        );
      default:
        return SliverToBoxAdapter(
          child: Container(),
        );
    }
  }

  Widget getActionButton(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        widget.onActionButtonPressed!(context);
      },
    );
  }

  double calculateMinContentHeight(double? footerHeight) {
    ThemeProvider theme = context.watch<ThemeProvider>();
    double height = MediaQuery.of(context).size.height;

    if (theme.sizingTheme.sizingType != LegendSizingType.MOBILE) {
      height -= footerHeight ?? 0;
    } else {
      height -= theme.bottomBarStyle?.height ?? 0;
    }

    if (widget.layoutType == LayoutType.FixedSider) {
      height -= theme.sizing.padding[0] * 4;
    } else if (widget.layoutType == LayoutType.Content) {
    } else {
      height -= theme.appBarSizing.appBarHeight;
    }

    return height;
  }

  Widget materialLayout(BuildContext context) {
    ThemeProvider theme = Provider.of<ThemeProvider>(context);
    double? footerheight;
    ScreenSize? screenSize;
    SizeProvider sizeProvider;

    RouteSettings? route = RouteInfoProvider.of(context)?.route;
    List<MenuOption> options = RouterProvider.of(context).menuOptions;
    for (final MenuOption op in options) {
      if (op.page == route?.name) {
        currentRoute = op;
        break;
      }
      if (op.children != null) {
        for (final MenuOption sub in op.children!) {
          if (sub.page == route?.name) {
            currentRoute = sub;
            break;
          }
        }
      }
    }

    sizeProvider = SizeProvider.of(context);
    screenSize = sizeProvider.screenSize;
    theme.menuCollapsed = sizeProvider.isMenuCollapsed(theme.menuWidth, theme);

    if (!sizeProvider.isMobile && widget.layoutType != LayoutType.Content) {
      footerheight =
          LayoutProvider.of(context)?.globalFooter?.sizing?.height ?? 0;
    }

    double maxHeight = calculateMinContentHeight(footerheight);

    // TODO Improve
    List<Widget> a = getChildren(context);
    List<Widget> children = List.of(
      a.map(
        (c) {
          return Padding(
            padding: EdgeInsets.symmetric(
              horizontal: theme.sizing.padding[0],
              //  vertical: widget.verticalChildrenSpacing ?? 0 / 2,
            ),
            child: c,
          );
        },
      ),
    );

    return Stack(
      children: [
        Scaffold(
          endDrawer: MenuDrawer(),
          bottomNavigationBar: sizeProvider.isMobile
              ? FixedBottomBar(
                  colors: theme.bottomBarColors,
                  sizing: theme.bottomBarStyle,
                )
              : null,
          endDrawerEnableOpenDragGesture: false,
          floatingActionButton: widget.onActionButtonPressed != null
              ? Builder(
                  builder: (context) {
                    return getActionButton(context);
                  },
                )
              : null,
          body: Stack(
            children: [
              Row(
                children: [
                  getSider(screenSize, context),
                  Expanded(
                    child: CustomScrollView(
                      controller: controller,
                      slivers: [
                        getHeader(context),
                        if (widget.children.isEmpty &&
                            widget.contentBuilder != null)
                          SliverToBoxAdapter(
                            child: Column(
                              children: [
                                Container(
                                  constraints: BoxConstraints(
                                    minHeight: maxHeight,
                                    maxHeight: widget.singlePage
                                        ? maxHeight
                                        : double.infinity,
                                  ),
                                  color: theme.colors.scaffoldBackgroundColor,
                                  padding: widget.disableContentDecoration
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
                                          text: currentRoute?.title ?? "",
                                          textStyle:
                                              theme.typography.h5.copyWith(
                                            color: theme.colors.textContrast,
                                          ),
                                        ),
                                      widget.singlePage
                                          ? Expanded(
                                              child:
                                                  getContent(maxHeight, theme),
                                            )
                                          : getContent(maxHeight, theme),
                                    ],
                                  ),
                                ),
                                if (footerheight != null)
                                  getFooter(footerheight, context),
                              ],
                            ),
                          )
                        else
                          SliverToBoxAdapter(
                            child: Container(
                              color: theme.colors.scaffoldBackgroundColor,
                              child: Column(
                                children: [
                                  Container(
                                    constraints: BoxConstraints(
                                      minHeight: maxHeight,
                                    ),
                                    child: SingleChildScrollView(
                                      child: Column(
                                        children: children,
                                      ),
                                    ),
                                  ),
                                  if (footerheight != null)
                                    getFooter(footerheight, context)
                                ],
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                ],
              ),
              if ((widget.layoutType == LayoutType.FixedHeaderSider) &&
                  (sizeProvider.isMobile == false))
                Positioned(
                  left: theme.appBarSizing.contentPadding.horizontal,
                  top: theme.appBarSizing.contentPadding.top,
                  child: Material(
                    color: Colors.transparent,
                    child: Hero(
                      tag: ValueKey('title'),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          if (LayoutProvider.of(context)?.title != null)
                            Container(
                              height: theme.appBarSizing.titleSize ??
                                  theme.appBarSizing.appBarHeight,
                              width: theme.appBarSizing.titleSize,
                              margin: EdgeInsets.only(right: 12.0, left: 16.0),
                              child: Center(
                                child: LegendText(
                                  text: LayoutProvider.of(context)!.title!,
                                  textStyle: theme.typography.h6.copyWith(
                                    color: theme.colors.appBarColors.foreground,
                                  ),
                                ),
                              ),
                            ),
                          if (LayoutProvider.of(context)?.logo != null)
                            Container(
                              height: theme.appBarSizing.appBarHeight,
                              alignment: Alignment.center,
                              child: LayoutProvider.of(context)!.logo,
                            ),
                        ],
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
        getDrawer(context),
      ],
    );
  }

  Row getContent(double maxHeight, ThemeProvider theme) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.layoutType == LayoutType.FixedSider ||
            widget.layoutType == LayoutType.FixedHeaderSider)
          Padding(
            padding: const EdgeInsets.only(
              left: 3.0,
            ),
            child: Container(
              height: maxHeight,
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    spreadRadius: 3,
                    blurRadius: 6,
                    offset: Offset(0, -6),
                  ),
                ],
              ),
            ),
          ),
        Expanded(
          child: Center(
            child: Container(
              decoration: widget.disableContentDecoration
                  ? null
                  : BoxDecoration(
                      color: theme.colors.background[0],
                      borderRadius: theme.sizing.borderRadius[0],
                    ),
              padding: widget.disableContentDecoration
                  ? null
                  : EdgeInsets.all(
                      theme.sizing.padding[1],
                    ),
              constraints: widget.singlePage
                  ? BoxConstraints(
                      minHeight: maxHeight -
                          (widget.disableContentDecoration
                              ? 0
                              : theme.sizing.padding[1] * 2),
                    )
                  : null,
              child: LayoutBuilder(
                builder: (context, constraints) {
                  return Builder(
                    builder: (context) {
                      return widget.contentBuilder!(
                        context,
                        Size(
                          widget.maxContentWidth ?? constraints.maxWidth,
                          maxHeight -
                              (widget.disableContentDecoration
                                  ? 0
                                  : (theme.sizing.padding[1] * 2)),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget getDrawer(BuildContext context) {
    List<LegendDrawerRoute> routes = Provider.of<LegendDrawerProvider>(context)
        .drawerRoutes
        .cast<LegendDrawerRoute>();
    for (final LegendDrawerRoute route in routes) {
      if (route.visible) {
        return LegendDrawer(
          route: route,
          isMobile: SizeProvider.of(context).isMobile,
        );
      }
    }
    return Container();
  }

  List<Widget> getChildren(BuildContext context) {
    List<Widget> childs = [];

    for (final element in widget.children) {
      Widget w;
      if (element is Section) {
        Section s = element;
        GlobalKey key = GlobalKey();
        if (sections != null) {
          SectionRouteInfo se = sections!.singleWhere(
            (element) => element.name == s.name,
            orElse: () {
              return sections!.last;
            },
          );
          int i = sections!.indexOf(se);
          sections![i] = SectionRouteInfo(name: se.name, key: key);
        }

        w = Container(
          key: key,
          child: s,
        );
      } else {
        w = element;
      }
      childs.add(w);
    }

    return childs;
  }
}
