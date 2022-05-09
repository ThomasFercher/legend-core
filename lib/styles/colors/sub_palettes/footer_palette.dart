import 'package:flutter/widgets.dart';
import 'package:legend_utils/functions/functions.dart';

const Color nullColor = Color(0xFFFFFFFE);

class FooterPalette {
  late final Color background;
  late final Color foreground;

  factory FooterPalette.from({
    required FooterPalette? footerPalette,
    required Color background,
    required Color foreground,
  }) {
    if (footerPalette == null) {
      return FooterPalette(
        background: background,
        foreground: foreground,
      );
    } else {
      return FooterPalette(
        background: LegendFunctions.isNullColor(footerPalette.background)
            ? background
            : footerPalette.background,
        foreground: LegendFunctions.isNullColor(footerPalette.foreground)
            ? foreground
            : footerPalette.foreground,
      );
    }
  }

  FooterPalette({
    Color? background,
    Color? foreground,
  }) {
    this.background = background ?? nullColor;

    this.foreground = foreground ?? nullColor;
  }
}
