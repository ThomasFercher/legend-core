import 'package:animations/animations.dart';
import 'package:flutter/material.dart';

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
      builder: (context) {
        return alert;
      },
      configuration: _alertConfiguration,
      context: context,
    );
  }

  static void showLegendModal({
    required BuildContext context,
    required Widget modal,
    ModalConfiguration? config,
  }) {
    /*  showModal(
      concontext,
      builder: (context) {
        return modal;
      },
      configuration: config ?? _modalConfiguration,
    );*/

    showDialog(
      context: context,
      builder: (context) => modal,
      barrierColor: Colors.transparent,
      barrierDismissible: true,
      useRootNavigator: false,
    );
  }
}
