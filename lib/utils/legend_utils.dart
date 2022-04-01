import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:url_launcher/url_launcher.dart';

const Color nullColor = Color(0xFFFFFFFE);

class LegendUtils {
  static bool isNullColor(Color c) => c == nullColor;
  static double getTitleIndent(TextStyle style, String text) {
    return calcTextSize(
      text,
      style,
    ).width;
  }

  static Future<void> launchInBrowser(String url) async {
    if (await canLaunch(url)) {
      await launch(
        url,
        forceSafariVC: false,
        forceWebView: false,
        headers: <String, String>{'my_header_key': 'my_header_value'},
      );
    } else {
      throw 'Could not launch $url';
    }
  }

  static Size? getSizeFromKey(GlobalKey k) {
    final RenderBox? renderBoxRed =
        k.currentContext!.findRenderObject() as RenderBox?;
    return renderBoxRed?.size;
  }

  static String capitalite(String s) {
    String first = s[0].toUpperCase();
    s = s.replaceRange(0, 1, first);
    return s;
  }

  static Size calcTextSize(
    String text,
    TextStyle style,
  ) {
    final TextPainter textPainter = TextPainter(
      text: TextSpan(text: text, style: style),
      textDirection: TextDirection.ltr,
      textScaleFactor: WidgetsBinding.instance?.window.textScaleFactor ?? 1.0,
    )..layout();
    return textPainter.size;
  }

  static Offset? getWidgetOffset(BuildContext context, GlobalKey key) {
    final RenderBox? renderBox =
        key.currentContext?.findRenderObject() as RenderBox?;
    return renderBox?.localToGlobal(Offset.zero);
  }

  static double? getVerticalCenter(
      BuildContext context, GlobalKey key, double childWidth) {
    double offset = getWidgetOffset(context, key)?.dx ?? 0;
    double size = (0.5 * (getWidgetSize(context, key)?.width ?? 0));
    double middleOffset = (0.5 * childWidth);
    return offset + size - middleOffset;
  }

  static Size? getWidgetSize(BuildContext context, GlobalKey key) {
    final RenderBox? renderBox =
        key.currentContext?.findRenderObject() as RenderBox?;
    return renderBox?.size; // or _widgetKey.currentContext?.size
  }

  static String getPrettyJSONString(jsonObject) {
    var encoder = JsonEncoder.withIndent('     ');
    return encoder.convert(jsonObject);
  }
}
