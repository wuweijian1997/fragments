import 'dart:ui' as ui;

import 'package:flutter/material.dart';

abstract class FragmentsDrawDelegate {
  const FragmentsDrawDelegate();

  void draw({
    Canvas canvas,
    ui.Image paintImage,
    double progress,
    Offset startingOffset,
  });
}
