import 'dart:math';

import 'package:animations/animations.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:legend_design_core/modals/modalSheet.dart';
import 'package:legend_design_core/styles/theming/sizing/size_provider.dart';
import 'package:legend_design_core/styles/theming/theme_provider.dart';
import 'package:legend_design_core/utils/legend_utils.dart';

class LegendPopups {
  static final ModalConfiguration _modalConfiguration =
      FadeScaleTransitionConfiguration(
    transitionDuration: Duration(milliseconds: 250),
    barrierDismissible: true,
    reverseTransitionDuration: Duration(milliseconds: 250),
  );

  static final ModalConfiguration _alertConfiguration =
      FadeScaleTransitionConfiguration(
    transitionDuration: Duration(milliseconds: 250),
    barrierDismissible: true,
    reverseTransitionDuration: Duration(milliseconds: 250),
    barrierColor: Colors.transparent,
  );

  static void showAlert({
    required BuildContext context,
    required Widget alert,
  }) {
    showModal(
      context: context,
      builder: (context) {
        return alert;
      },
      configuration: _alertConfiguration,
    );
  }

  static void showLegendModal({
    required BuildContext context,
    required Widget modal,
    ModalConfiguration? config,
  }) {
    /*  showModal(
      context: context,
      builder: (context) {
        return modal;
      },
      configuration: config ?? _modalConfiguration,
    );*/

    showDialog(
      context: context,
      builder: (context) => modal,
      barrierColor: Colors.transparent,
    );
  }

  static void showSubMenu({
    required ThemeProvider theme,
    required double menuWidth,
    required double itemWidth,
    void Function(PointerExitEvent event)? onExit,
    void Function(PointerHoverEvent event, Offset point)? onParentExit,
    void Function()? onParentTap,
    List<Widget>? menuItems,
    required BuildContext context,
    required GlobalKey key,
    double? maxHeight,
    double? parentHeight,
    BorderRadiusGeometry? borderRadius,
  }) {
    double maxWidth = SizeProvider.of(context).width;
    double left_q = (menuWidth - itemWidth) / 2;
    double center = LegendUtils.getVerticalCenter(context, key, menuWidth) ?? 0;

    bool snappedRight = false;

    if (maxWidth < center + menuWidth) {
      center = maxWidth - menuWidth;
      snappedRight = true;
    }
    Point position = Point(
      center,
      0.0,
    );

    LegendPopups.showLegendModal(
      context: context,
      config: FadeScaleTransitionConfiguration(
        barrierColor: Colors.transparent,
        barrierDismissible: true,
        transitionDuration: Duration(milliseconds: 200),
        barrierLabel: "",
        reverseTransitionDuration: Duration(milliseconds: 100),
      ),
      modal: ModalSheet(
        child: Material(
          color: Colors.transparent,
          child: MouseRegion(
            onHover: (event) {
              Offset p = event.localPosition;

              if (p.dy <= (parentHeight ?? 0)) {
                if (snappedRight) {
                  if (event.localDelta.dy < 0) {
                    left_q = menuWidth - itemWidth - 16;

                    if (left_q >= p.dx) {
                      if (onParentExit != null) onParentExit(event, p);
                    }
                  }
                } else {
                  if (p.dx <= left_q || p.dx >= (menuWidth - left_q)) {
                    if (onParentExit != null) onParentExit(event, p);
                  }
                }
              }
            },
            onExit: (event) {
              if (onExit != null) onExit(event);
            },
            child: Column(
              children: [
                GestureDetector(
                  onTap: () {
                    if (onParentTap != null) {
                      onParentTap();
                    }
                  },
                  child: Container(
                    height: theme.appBarSizing.appBarHeight,
                    width: itemWidth,
                    color: Colors.transparent,
                  ),
                ),
                Container(
                  width: menuWidth,
                  constraints: maxHeight != null
                      ? BoxConstraints(
                          maxHeight: maxHeight,
                        )
                      : BoxConstraints(),
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: borderRadius ??
                          BorderRadius.vertical(
                            bottom: Radius.circular(
                              theme.sizing.borderInset[0],
                            ),
                          ),
                    ),
                    color: theme.colors.foreground[1],
                    margin: const EdgeInsets.all(0),
                    child: Padding(
                      padding: EdgeInsets.only(
                        top: theme.sizing.borderInset[0],
                        bottom: theme.sizing.borderInset[0],
                      ),
                      child: ListView(
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        children: menuItems ?? [],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        position: position,
      ),
    );
  }
}
