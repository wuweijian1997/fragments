import 'package:flutter/material.dart';
import 'dart:ui' as ui;

import 'package:flutter/rendering.dart';

class FragmentsController {
  FragmentsController() {
    _globalKey = GlobalKey();
  }

  AnimationController animationController;
  ui.Image _image;
  GlobalKey _globalKey;
  Size _imageSize;

  ui.Image get image => _image;

  Size get imageSize => _imageSize;

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
    if (disableCache == false && image != null && imageSize != null) {
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
      _imageSize = Size(value.width.toDouble(), value.height.toDouble());
      _image = value;
      onEnd?.call();
    });
  }

  void addListener(VoidCallback listener) {
    animationController?.addListener(listener);
  }

  void addStatusListener(AnimationStatusListener listener) {
    animationController?.addStatusListener(listener);
  }

  void completed(VoidCallback callback) {
    animationController.addStatusListener((AnimationStatus status) {
      if (status == AnimationStatus.completed) {
        callback?.call();
      }
    });
  }

  void dispose() {
    animationController?.dispose();
    _image = null;
    _imageSize = null;
    _globalKey = null;
  }
}
