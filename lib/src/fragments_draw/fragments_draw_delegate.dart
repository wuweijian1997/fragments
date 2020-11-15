import 'package:flutter/material.dart';
import 'dart:ui' as ui;

import 'package:flutter_fragments/flutter_fragments.dart';

abstract class FragmentsDrawDelegate {
  const FragmentsDrawDelegate();

  void draw({
    Canvas canvas,
    List<List<Rect>> fragments,
    ui.Image paintImage,
    double progress,
    int rowLength,
    int columnLength,
    Coordinate startingCoordinate,
  });
}
