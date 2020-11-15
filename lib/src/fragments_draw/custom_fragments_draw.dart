import 'dart:math';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter_fragments/src/fragments_draw/fragments_draw_delegate.dart';
import 'package:flutter_fragments/src/models/coordinate.dart';

class CustomFragmentsDraw extends FragmentsDrawDelegate {
  const CustomFragmentsDraw();

  @override
  void draw({
    Canvas canvas,
    List<List<Rect>> fragments,
    ui.Image paintImage,
    double progress,
    int rowLength,
    int columnLength,
    Coordinate startingCoordinate,
  }) {
    Paint paint = Paint();
    double transition = (rowLength + columnLength) / (rowLength * columnLength);
    transition = min(transition, .1);
    double maxDistance = startingCoordinate.maxDistance(
        maxX: rowLength, maxY: columnLength);
    for (int i = 0; i < rowLength; i++) {
      for (int j = 0; j < columnLength; j++) {
        double opacity;
        double currentProgress = calculateFragmentsProgress(
          currentCoordinate: Coordinate(x: i, y: j),
          startingCoordinate: startingCoordinate,
          maxDistance: maxDistance,
        );
        if (currentProgress <= progress) {
          opacity = 0;
        } else {
          opacity = 1;
        }
        if (opacity > 0) {
          paint.color = Colors.white.withOpacity(opacity);
          canvas.drawImageRect(
              paintImage, fragments[i][j], fragments[i][j], paint);
        }
      }
    }
  }

  double calculateFragmentsProgress({
    Coordinate currentCoordinate,
    Coordinate startingCoordinate,
    double maxDistance,
  }) {
    double distance = currentCoordinate.distance(startingCoordinate);
    return (distance / maxDistance).clamp(.0, 1.0);
  }

}
