import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';

const List<String> types = ['png', 'jpg', 'jpeg', 'gif', 'svg', 'webp'];

class AssetLoader {
  ///
  /// This Method prechaches all Images in the assets folder.
  ///
  static Future<void> prechacheAssets(BuildContext context) async {
    final String manifestContent =
        await rootBundle.loadString('AssetManifest.json');
    final Map<String, dynamic> manifestMap =
        json.decode(manifestContent) as Map<String, dynamic>;
    final List<String> paths = manifestMap.keys.where((element) {
      for (final String type in types) {
        if (element.contains(type)) return true;
      }
      return false;
    }).toList();
    for (final String path in paths) {
      if (path.contains('svg')) {
        await precachePicture(
          ExactAssetPicture(
            SvgPicture.svgStringDecoderOutsideViewBoxBuilder,
            path,
          ),
          context,
        );
      } else {
        await precacheImage(
          AssetImage(path),
          context,
        );
      }
    }
  }
}
