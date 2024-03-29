import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class ScreenshotController {
  ScreenshotController();

  ui.Image? _image;
  GlobalKey _globalKey = GlobalKey();

  ui.Image? get image => _image;

  GlobalKey get globalKey => _globalKey;

  void start({bool disableCache = false, VoidCallback? callback}) {
    if (disableCache == false && image != null) {
      callback?.call();
    } else {
      generateImage(() {
        callback?.call();
      });
    }
  }

  void generateImage(VoidCallback? onEnd) {
    RenderRepaintBoundary boundary =
    _globalKey.currentContext?.findRenderObject() as RenderRepaintBoundary;
    boundary.toImage().then((value) {
      _image = value;
      onEnd?.call();
    });
  }

  void dispose() {
    _image = null;
  }
}
