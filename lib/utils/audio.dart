import 'dart:js' as js;

import 'package:flutter/foundation.dart';

class PlayAudio {
  static void playAudio(String path) {
    if (kIsWeb) {
      js.context.callMethod('playAudio', [path]);
    } else {
      // not on the web so we must use a mobile/desktop library...
    }
  }
}
