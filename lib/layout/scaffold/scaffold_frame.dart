import 'package:flutter/material.dart';

import 'package:legend_design_core/layout/drawers/menu_drawer.dart';
import 'package:legend_design_core/layout/fixed/menu/tiles/menu_option.dart';
import 'package:legend_design_core/layout/layout_provider.dart';
import 'package:legend_design_core/layout/scaffold/contents/scaffold_footer.dart';
import 'package:legend_design_core/layout/scaffold/contents/scaffold_header.dart';
import 'package:legend_design_core/layout/scaffold/contents/scaffold_sider.dart';
import 'package:legend_design_core/layout/scaffold/contents/scaffold_title.dart';
import 'package:legend_design_core/layout/scaffold/contents/scaffold_action_button.dart';
import 'package:legend_design_core/layout/scaffold/contents/scaffold_content.dart';
import 'package:legend_design_core/layout/fixed/slivers/persistent_header.dart';
import 'package:legend_design_core/layout/scaffold/legend_scaffold.dart';
import 'package:legend_design_core/layout/scaffold/scaffoldInfo.dart';
import 'package:legend_design_core/router/route_info_provider.dart';
import 'package:legend_design_core/styles/layouts/layout_type.dart';
import 'package:legend_design_core/styles/legend_theme.dart';
import 'package:legend_design_core/layout/scaffold/config/scaffold_config.dart';
import 'package:legend_design_core/styles/sizing/size_info.dart';
import 'package:legend_design_core/typography/legend_text.dart';
import 'package:legend_design_core/utils/extensions.dart';
import 'package:legend_design_core/utils/legend_utils.dart';
import 'package:provider/provider.dart';
import '../fixed/bottomBar.dart/fixed_bottom_bar.dart';

class ScaffoldFrame extends StatelessWidget {
  const ScaffoldFrame({
    Key? key,
  }) : super(key: key);

  double calculateMinContentHeight(double? footerHeight, BuildContext context) {
    LegendTheme theme = context.watch<LegendTheme>();
    LegendScaffold scaffold = ScaffoldInfo.of(context).scaffold;
    double height = MediaQuery.of(context).size.height;

    if (theme.bottomBarSizing == null) {
      height -= footerHeight ?? 0;
    } else {
      height -= theme.bottomBarSizing!.height;
    }
    switch (scaffold.layoutType) {
      case LayoutType.Content:
        break;
      case LayoutType.FixedHeader:
        height -= theme.sizing.appBarSizing.appBarHeight;
        break;
      case LayoutType.FixedHeaderSider:
        height -= theme.sizing.appBarSizing.appBarHeight;

        break;
      case LayoutType.FixedSider:
        if (theme.sizing.hideSider) {
          height -= theme.sizing.appBarSizing.appBarHeight;
        }
        break;
    }

    if (scaffold.builders.appBarBottom != null) {
      height -= scaffold.sizing.appBarBottomSize!.height;
    }
    if ((scaffold.whether.isUnderlyingRoute ?? false) &&
        scaffold.layoutType == LayoutType.FixedSider) {
      height -= 48;
    }

    return height;
  }

  List<Widget> getChildren(BuildContext context, bool showFooter) {
    LegendScaffold scaffold = ScaffoldInfo.of(context).scaffold;

    List<Widget> widgets = scaffold.children
        .traillingPaddingCol(scaffold.sizing.verticalChildrenSpacing ?? 0);

    if (showFooter) widgets.add(ScaffoldFooter());

    return widgets;
  }

  @override
  Widget build(BuildContext context) {
    LegendTheme theme = context.watch<LegendTheme>();
    LegendScaffold scaffold = ScaffoldInfo.of(context).scaffold;

    SizeInfo sizeProvider = SizeInfo.of(context);

    bool showBuilder =
        scaffold.children.isEmpty && scaffold.contentBuilder != null;
    bool showAppBarBottom = scaffold.builders.appBarBottom != null &&
        scaffold.sizing.appBarBottomSize != null;
    bool showTitle = (scaffold.layoutType == LayoutType.FixedHeaderSider) &&
        (sizeProvider.isMobile == false);

    MenuOption? currentRoute = RouteInfoProvider.getCurrentMenuOption(context);

    // Footer
    double? footerheight;
    if (!sizeProvider.isMobile && scaffold.layoutType != LayoutType.Content) {
      footerheight =
          LayoutProvider.of(context)?.globalFooter?.sizing?.height ?? 0;
    }
    double height = calculateMinContentHeight(footerheight, context);

    return SafeArea(
      top: false,
      child: Scaffold(
        endDrawer: MenuDrawer(),
        bottomNavigationBar: theme.bottomBarSizing != null
            ? FixedBottomBar(
                colors: theme.bottomBarPalette,
                sizing: theme.bottomBarSizing!,
              )
            : null,
        endDrawerEnableOpenDragGesture: false,
        floatingActionButton: scaffold.onActionButtonPressed != null
            ? ScaffoldActionButton()
            : null,
        body: ColoredBox(
          color: theme.colors.background[0],
          child: Stack(
            children: [
              Row(
                children: [
                  ScaffoldSider(),
                  Expanded(
                    child: CustomScrollView(
                      controller: ScrollController(),
                      slivers: [
                        ScaffoldHeader(),
                        if (showAppBarBottom)
                          SliverPersistentHeader(
                            pinned: true,
                            delegate: PersistentHeader(
                              child: scaffold.builders.appBarBottom!,
                              maxHeight:
                                  scaffold.sizing.appBarBottomSize!.height,
                              minHeight:
                                  scaffold.sizing.appBarBottomSize!.width,
                              backgroundColor: theme.colors.background[0],
                            ),
                          ),
                        if (showBuilder)
                          SliverToBoxAdapter(
                            child: Column(
                              children: [
                                Container(
                                  padding: scaffold.whether
                                              .disableContentDecoration ??
                                          false
                                      ? null
                                      : EdgeInsets.all(
                                          theme.sizing.padding[0],
                                        ),
                                  //   color: Colors.red,
                                  constraints: BoxConstraints(
                                    minHeight: height,
                                    maxHeight:
                                        scaffold.whether.singlePage ?? false
                                            ? height
                                            : double.infinity,
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      if (scaffold.whether.showContentHeader ??
                                          false)
                                        SizedBox(
                                          height: 48,
                                          child: LegendText(
                                            padding: EdgeInsets.only(
                                              bottom: 8,
                                            ),
                                            text: currentRoute?.title ?? '',
                                            textStyle:
                                                theme.typography.h5.copyWith(
                                              color: theme.colors.textOnLight,
                                            ),
                                          ),
                                        ),
                                      ScaffoldContent(
                                        maxHeight: height,
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
    );
  }
}
