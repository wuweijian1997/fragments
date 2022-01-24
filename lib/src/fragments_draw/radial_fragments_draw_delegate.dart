import 'dart:math';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter_fragments/flutter_fragments.dart';

class RadialFragmentsDraw extends RowAndColumnFragmentsDrawDelegate {
  final bool disableTransition;
  Offset? _startingOffset;

  RadialFragmentsDraw({
    numberOfRow = 20,
    numberOfColumn = 20,
    this.disableTransition = false,
  }) : super(numberOfColumn: numberOfColumn, numberOfRow: numberOfRow);


  @override
  void draw({
    required Canvas canvas,
    required ui.Image paintImage,
    required double progress,
    required Offset startingOffset,
  }) {
    Paint paint = Paint();
    Size imageSize =
        Size(paintImage.width.toDouble(), paintImage.height.toDouble());
    if (_startingOffset != startingOffset) {
      calculateStartingCoordinate(
        size: imageSize,
        startingOffset: startingOffset,
      );
      _startingOffset = startingOffset;
    }
    double maxDistance = startingCoordinate?.maxDistance(
      maxX: numberOfRow - 1,
      maxY: numberOfColumn - 1,
    )?? 0;
    for (int i = 0; i < numberOfColumn; i++) {
      for (int j = 0; j < numberOfRow; j++) {
        double currentProgress = calculateFragmentProgress(
          maxDistance: maxDistance,
          currentCoordinate: Coordinate(x: j, y: i),
        );
        if (currentProgress > progress) {
          Rect rect = calculateFragment(i: i, j: j, size: imageSize);
          if (disableTransition == false) {
            double opacity = 1;
            double transition =
                (numberOfRow + numberOfColumn) / (numberOfRow * numberOfColumn);
            transition = min(transition, .1);
            if (currentProgress - transition < progress) {
              opacity = .6;
            } else if (currentProgress - transition / 2 < progress) {
              opacity = .8;
            }
            paint.color = Colors.white.withOpacity(opacity);
          }
          canvas.drawImageRect(paintImage, rect, rect, paint);
        }
      }
    }
  }

  double calculateFragmentProgress({
    required double maxDistance,
    required Coordinate currentCoordinate,
  }) {
    if(startingCoordinate != null) {
      double distance = currentCoordinate.distance(startingCoordinate!);
      return (distance / maxDistance).clamp(.0, 1.0);
    }
    return 0;
  }
}
