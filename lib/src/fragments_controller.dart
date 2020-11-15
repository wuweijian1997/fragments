import 'package:flutter/material.dart';
import 'dart:ui' as ui;

import 'package:flutter/rendering.dart';

class FragmentsController {
  FragmentsController({this.animationController}) {
    _globalKey = GlobalKey();
  }

  AnimationController animationController;
  ui.Image _image;
  GlobalKey _globalKey;

  ui.Image get image => _image;

  GlobalKey get globalKey => _globalKey;

  double get value => animationController?.value;

  void start({bool disableCache = false}) {
    _cacheVerification(
      disableCache: disableCache,
      event: () {
        animationController.forward(from: 0);
      },
    );
  }

  ///Verify whether to use cache
  void _cacheVerification({@required VoidCallback event, bool disableCache}) {
    if (disableCache == false && image != null ) {
      event?.call();
      return;
    }
    generateImage(() {
      event?.call();
    });
  }

  void generateImage(VoidCallback onEnd) {
    RenderRepaintBoundary boundary =
        _globalKey.currentContext.findRenderObject();
    boundary.toImage().then((value) {
      _image = value;
      onEnd?.call();
    });
  }

  void dispose() {
    animationController?.dispose();
    _image = null;
    _globalKey = null;
  }
}
