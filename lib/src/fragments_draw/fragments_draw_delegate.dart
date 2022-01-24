import 'dart:ui' as ui;

import 'package:flutter/material.dart';

abstract class FragmentsDrawDelegate {
  const FragmentsDrawDelegate();

  void draw({
    required Canvas canvas,
    required ui.Image paintImage,
    required double progress,
    required Offset startingOffset,
  });
}
