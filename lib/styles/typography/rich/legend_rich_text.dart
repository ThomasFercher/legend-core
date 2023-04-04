import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class RichTextItem {
  final TextStyle style;
  final String text;
  final Color? hoverColor;
  final void Function()? onTap;

  RichTextItem({
    required this.style,
    required this.text,
    this.hoverColor,
    this.onTap,
  });
}

class LegendRichText extends StatefulWidget {
  final List<RichTextItem> text;
  late final bool tapable;

  LegendRichText({
    required this.text,
  }) {
    tapable = text.any((item) => item.onTap != null);
  }

  @override
  State<LegendRichText> createState() => _LegendRichTextState();
}

class _LegendRichTextState extends State<LegendRichText> {
  late final List<bool> hovered;
  @override
  void initState() {
    super.initState();
    hovered = widget.text.map((e) => false).toList();
  }

  List<TextSpan> _buildTextSpans() {
    List<TextSpan> spans = [];
    String c = ' ';
    for (var i = 0; i < widget.text.length; i++) {
      final item = widget.text[i];
      String string = item.text;
      TextStyle style = item.style;
      bool hover = item.hoverColor != null;
      if (i < widget.text.length - 1 && string.characters.last != '\n') {
        string += c;
      }

      final GestureRecognizer? gestureRecognizer;
      if (item.onTap != null) {
        gestureRecognizer = TapGestureRecognizer()..onTap = item.onTap;
      } else {
        gestureRecognizer = null;
      }

      final span = TextSpan(
        text: string,
        mouseCursor: item.onTap != null
            ? SystemMouseCursors.click
            : SystemMouseCursors.text,
        style: hovered[i] ? style.copyWith(color: item.hoverColor) : style,
        recognizer: gestureRecognizer,
        onEnter: hover
            ? (event) {
                setState(() {
                  hovered[i] = true;
                });
              }
            : null,
        onExit: hover
            ? (event) {
                setState(() {
                  hovered[i] = false;
                });
              }
            : null,
      );
      spans.add(span);
    }

    return spans;
  }

  @override
  Widget build(BuildContext context) {
    return widget.tapable
        ? GestureDetector(
            onTap: () {
              int i = hovered.indexWhere((hov) => hov == true);
              RichTextItem item = widget.text[i];
              if (item.onTap != null) {
                item.onTap!();
              }
            },
            child: SelectableText.rich(
              TextSpan(
                children: _buildTextSpans(),
              ),
              enableInteractiveSelection: true,
            ),
          )
        : SelectableText.rich(
            TextSpan(
              children: _buildTextSpans(),
            ),
            enableInteractiveSelection: true,
          );
  }
}
