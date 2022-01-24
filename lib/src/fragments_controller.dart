import 'package:flutter/material.dart';
import 'package:flutter_fragments/flutter_fragments.dart';

class FragmentsController {
  late AnimationController _animationController;
  ScreenshotController _screenshotController = ScreenshotController();
  FragmentsController({
    Duration duration = const Duration(milliseconds: 1000),
    required TickerProvider vsync,
  }) {
    _animationController = AnimationController(vsync: vsync, duration: duration);
  }

  ScreenshotController get screenshotController => _screenshotController;

  Animation<double> get animation => _animationController.view;

  start() {
    screenshotController.start(callback: () => _animationController.forward(from: 0));
  }

  dispose() {
    _animationController.dispose();
    _screenshotController.dispose();
  }
}