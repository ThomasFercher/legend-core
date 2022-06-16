import 'dart:io';

import 'package:flutter/foundation.dart';

class PlatformInfo {
  static bool get isWeb => kIsWeb;
  static bool get isIos => !isWeb ? Platform.isIOS : false;
  static bool get isAndroid => !isWeb ? Platform.isAndroid : false;
  static bool get isMacOS => !isWeb ? Platform.isMacOS : false;
  static bool get isWindows => !isWeb ? Platform.isWindows : false;
  static bool get isLinux => !isWeb ? Platform.isLinux : false;

  static bool get isMobile => isIos || isAndroid;
  static bool get isDesktop => isMacOS || isWindows || isLinux;
}
