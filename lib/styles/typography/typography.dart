import 'package:flutter/material.dart';

import 'style/typography_colors.dart';
import 'style/typography_sizing.dart';

class LegendTypography {
  final TextStyle h0;
  final TextStyle h1;
  final TextStyle h2;
  final TextStyle h3;
  final TextStyle h4;
  final TextStyle h5;

  final IconData backIcon;
  final IconData menuIcon;
  final IconData closeIcon;

  const LegendTypography({
    required this.h0,
    required this.h1,
    required this.h2,
    required this.h3,
    required this.h4,
    required this.h5,
    this.backIcon = Icons.arrow_back,
    this.menuIcon = Icons.menu,
    this.closeIcon = Icons.close,
  });

  factory LegendTypography.applyStyles({
    required LegendTypography base,
    required TypographyColors colors,
    required TypographySizing sizing,
  }) {
    return LegendTypography(
      h0: base.h0.copyWith(color: colors.h0, fontSize: sizing.h0),
      h1: base.h1.copyWith(color: colors.h1, fontSize: sizing.h1),
      h2: base.h2.copyWith(color: colors.h2, fontSize: sizing.h2),
      h3: base.h3.copyWith(color: colors.h3, fontSize: sizing.h3),
      h4: base.h4.copyWith(color: colors.h4, fontSize: sizing.h4),
      h5: base.h5.copyWith(color: colors.h5, fontSize: sizing.h5),
    );
  }
}
