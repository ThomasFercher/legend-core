import 'package:flutter/material.dart';
import 'package:legend_utils/functions/functions.dart';

class LegendText extends StatelessWidget {
  final String? data;
  final TextStyle? style;
  final bool selectable;
  final TextAlign? textAlign;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final TextOverflow? overflow;
  final bool dynamicSizing;

  final double? fontSize;
  final FontWeight? fontWeight;
  final Color? color;

  const LegendText(
    this.data, {
    this.selectable = true,
    this.dynamicSizing = false,
    this.style,
    this.textAlign,
    this.padding,
    this.overflow,
    this.fontSize,
    this.fontWeight,
    this.color,
    this.margin,
  });

  @override
  Widget build(BuildContext context) {
    final _style = style != null
        ? style!.copyWith(
            fontSize: fontSize,
            fontWeight: fontWeight,
            color: color,
          )
        : TextStyle(
            fontSize: fontSize,
            fontWeight: fontWeight,
            color: color,
          );
    Widget text = dynamicSizing
        ? _sizedText(_style)
        : selectable
            ? _selectableText(_style)
            : _text(_style);

    return Container(
      padding: padding,
      margin: margin,
      height: style?.height,
      child: text,
    );
  }

  ///
  /// TODO: Pfusch?
  ///
  Widget _sizedText(TextStyle _style) {
    Size s = LegendFunctions.calcTextSize(data ?? '', _style);

    Widget text = selectable ? _selectableText(_style) : _text(_style);

    return ConstrainedBox(
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
  Widget _text(TextStyle _style) {
    return Text(
      data ?? '',
      style: _style,
      textAlign: textAlign,
      softWrap: true,
    );
  }

  ///
  /// Selectable Text
  ///
  Widget _selectableText(TextStyle _style) {
    return SelectableText(
      data ?? '',
      style: _style,
      textAlign: textAlign,
    );
  }
}
