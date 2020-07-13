import 'dart:io';

import 'package:flutter/material.dart';
import 'package:share/share.dart';

class AppUtil {
  static void onShareTap(BuildContext context) {
    final RenderBox box = context.findRenderObject();
    String share = "";

    if (Platform.isAndroid) {
      share =
          "https://play.google.com/store/apps/details?id=";
    } else if (Platform.isIOS) {
      share =
          "https://apps.apple.com/us/app/";
    }
    if (share.isNotEmpty)
      Share.share(share,
          sharePositionOrigin: box.localToGlobal(Offset.zero) & box.size);
  }
}
