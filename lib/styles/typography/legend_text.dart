import 'package:flutter/material.dart';
import 'package:legend_utils/functions/functions.dart';

class LegendText extends StatelessWidget {
  final String? text;
  final TextStyle? textStyle;
  final bool selectable;
  final TextAlign? textAlign;
  final EdgeInsets? padding;
  final TextOverflow? overflow;

  final bool dynamicSizing;

  LegendText({
    required this.text,
    this.selectable = true,
    this.textStyle,
    this.textAlign,
    this.padding,
    this.overflow,
    this.dynamicSizing = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding ?? EdgeInsets.zero,
      height: textStyle?.height,
      child: dynamicSizing ? dynamicSized() : webText(),
    );
  }

  Widget dynamicSized() {
    Size s = LegendFunctions.calcTextSize(text ?? '', textStyle ?? TextStyle());

    return Container(
      constraints: BoxConstraints(
        maxHeight: s.height,
      ),
      child: FittedBox(
        alignment: Alignment.centerLeft,
        fit: BoxFit.fitHeight,
        child: Container(
          child: Text(
            text ?? '',
            style: textStyle,
            textAlign: textAlign,
          ),
        ),
      ),
    );
  }

  Widget webText() {
    return Text(
      text ?? '',
      style: textStyle,
      textAlign: textAlign,
      softWrap: true,
    );
  }
}
