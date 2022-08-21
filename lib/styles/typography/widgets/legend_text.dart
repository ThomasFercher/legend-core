import 'package:flutter/material.dart';
import 'package:legend_utils/functions/functions.dart';

class LegendText extends StatelessWidget {
  final String? data;
  final TextStyle? textStyle;
  final bool selectable;
  final TextAlign? textAlign;
  final EdgeInsets? padding;
  final TextOverflow? overflow;
  final bool dynamicSizing;

  const LegendText(
    this.data, {
    this.selectable = true,
    this.dynamicSizing = false,
    this.textStyle,
    this.textAlign,
    this.padding,
    this.overflow,
  });

  @override
  Widget build(BuildContext context) {
    Widget text = dynamicSizing
        ? _sizedText()
        : selectable
            ? _selectableText()
            : _text();

    return Container(
      padding: padding ?? EdgeInsets.zero,
      height: textStyle?.height,
      child: text,
    );
  }

  ///
  /// TODO: Pfusch?
  ///
  Widget _sizedText() {
    Size s = LegendFunctions.calcTextSize(data ?? '', textStyle ?? TextStyle());

    Widget text = selectable ? _selectableText() : _text();

    return Container(
      constraints: BoxConstraints(
        maxHeight: s.height,
      ),
      child: FittedBox(
        alignment: Alignment.centerLeft,
        fit: BoxFit.fitHeight,
        child: Container(
          child: text,
        ),
      ),
    );
  }

  ///
  /// Ordinary Text Widget
  ///
  Widget _text() {
    return Text(
      data ?? '',
      style: textStyle,
      textAlign: textAlign,
      softWrap: true,
    );
  }

  ///
  /// Selectable Text
  ///
  Widget _selectableText() {
    return SelectableText(
      data ?? '',
      style: textStyle,
      textAlign: textAlign,
    );
  }
}
