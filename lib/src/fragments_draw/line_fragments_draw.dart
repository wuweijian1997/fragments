import 'dart:math';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter_fragments/flutter_fragments.dart';

enum LineDirection {
  top,
  bottom,
  left,
  right,
}

extension LineDirectionExten on LineDirection {
  bool get vertical =>
      this == LineDirection.top || this == LineDirection.bottom;

  bool get horizontal =>
      this == LineDirection.left || this == LineDirection.right;
}

class LineFragmentsDraw extends RectFragmentsDrawDelegate {
  final int lines;
  final LineDirection direction;
  LineDirection _direction;

  LineFragmentsDraw({
    this.lines = 20,
    this.direction = LineDirection.left,
  }) : super(
          numberOfRow: direction.vertical ? 1 : lines,
          numberOfColumn: direction.vertical ? lines : 1,
        );

  @override
  void draw({
    Canvas canvas,
    ui.Image paintImage,
    double progress,
    Offset startingOffset,
  }) {
    Paint paint = Paint();
    Size size = Size(paintImage.width.toDouble(), paintImage.height.toDouble());
    if (direction != _direction) {
      Offset offset = calculateStartingOffsetWithDirection(direction, size);
      calculateStartingCoordinate(size: size, startingOffset: offset);
    }
    int maxDistance = max(numberOfColumn, numberOfRow);
    for (int i = 0; i < numberOfColumn; i++) {
      for (int j = 0; j < numberOfRow; j++) {
        double currentProgress = calculateFragmentProgress(
          currentCoordinate: Coordinate(x: i + 1, y: j + 1),
          direction: direction,
          maxDistance: maxDistance.toDouble(),
        );
        if (currentProgress > progress) {
          Rect rect = calculateFragment(i: i, j: j, size: size);
          canvas.drawImageRect(paintImage, rect, rect, paint);
        }
      }
    }
  }

  Offset calculateStartingOffsetWithDirection(
    LineDirection direction,
    Size size,
  ) {
    Offset offset;
    switch (direction) {
      case LineDirection.right:
      case LineDirection.bottom:
        offset = size.bottomRight(Offset.zero);
        break;
      default:
        offset = Offset.zero;
    }
    return offset;
  }

  double calculateFragmentProgress({
    Coordinate currentCoordinate,
    LineDirection direction,
    double maxDistance,
  }) {
    double progress;
    switch (direction) {
      case LineDirection.left:
        progress = currentCoordinate.y / maxDistance;
        break;
      case LineDirection.right:
        progress = (numberOfColumn - currentCoordinate.y) / maxDistance;
        break;
      case LineDirection.top:
        progress = currentCoordinate.x / maxDistance;
        break;
      case LineDirection.bottom:
        progress = (numberOfRow - currentCoordinate.x) / maxDistance;
        break;
    }
    return progress.clamp(0, 1);
  }
}
