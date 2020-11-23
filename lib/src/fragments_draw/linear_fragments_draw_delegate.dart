import 'dart:math';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter_fragments/flutter_fragments.dart';

enum LinearDirection {
  top,
  bottom,
  left,
  right,
}

extension LinearDirectionExten on LinearDirection {
  bool get vertical =>
      this == LinearDirection.top || this == LinearDirection.bottom;

  bool get horizontal =>
      this == LinearDirection.left || this == LinearDirection.right;
}

class LineFragmentsDraw extends RowAndColumnFragmentsDrawDelegate {
  final int lines;
  final LinearDirection direction;
  LinearDirection _direction;

  LineFragmentsDraw({
    this.lines = 20,
    this.direction = LinearDirection.left,
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
        currentProgress += (Random().nextDouble() - .5) / 10;
        if (currentProgress > progress) {
          Rect rect = calculateFragment(i: i, j: j, size: size);
          canvas.drawImageRect(paintImage, rect, rect, paint);
        }
      }
    }
  }

  Offset calculateStartingOffsetWithDirection(
      LinearDirection direction,
    Size size,
  ) {
    Offset offset;
    switch (direction) {
      case LinearDirection.right:
      case LinearDirection.bottom:
        offset = size.bottomRight(Offset.zero);
        break;
      default:
        offset = Offset.zero;
    }
    return offset;
  }

  double calculateFragmentProgress({
    Coordinate currentCoordinate,
    LinearDirection direction,
    double maxDistance,
  }) {
    double progress;
    switch (direction) {
      case LinearDirection.left:
        progress = currentCoordinate.y / maxDistance;
        break;
      case LinearDirection.right:
        progress = (numberOfColumn - currentCoordinate.y) / maxDistance;
        break;
      case LinearDirection.top:
        progress = currentCoordinate.x / maxDistance;
        break;
      case LinearDirection.bottom:
        progress = (numberOfRow - currentCoordinate.x) / maxDistance;
        break;
    }
    return progress.clamp(0, 1);
  }
}
