import 'dart:math';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter_fragments/src/fragments_draw/fragments_draw_delegate.dart';
import 'package:flutter_fragments/src/models/index.dart';

class DefaultFragmentsDraw extends FragmentsDrawDelegate {
  final bool disableTransition;
  final int rowLength;
  final int columnLength;
  List<List<Rect>> _fragments;
  Coordinate _startingCoordinate;
  Offset _startingOffset;

  DefaultFragmentsDraw({
    this.disableTransition = false,
    this.rowLength = 10,
    this.columnLength = 10,
  });

  Coordinate get startingCoordinate => _startingCoordinate;

  @override
  void draw({
    Canvas canvas,
    ui.Image paintImage,
    double progress,
    Offset startingOffset,
  }) {
    Size imageSize = Size(paintImage.width.toDouble(), paintImage.height.toDouble());
    if (_startingOffset != startingOffset) {
      _startingCoordinate = initCoordinate(
        size: imageSize,
        rowLength: rowLength,
        columnLength: columnLength,
        startingOffset: startingOffset,
      );
    }
    Paint paint = Paint();
    double maxDistance = startingCoordinate.maxDistance(
      maxX: rowLength - 1,
      maxY: columnLength - 1,
    );
    for (int i = 0; i < rowLength; i++) {
      for (int j = 0; j < columnLength; j++) {
        double currentProgress = calculateFragmentsProgress(
          currentCoordinate: Coordinate(x: i, y: j),
          startingCoordinate: startingCoordinate,
          maxDistance: maxDistance,
        );
        if (currentProgress > progress) {
          Rect rect = calculateFragment(i: i, j: j, size: imageSize);
          if (disableTransition == false) {
            double opacity = 1;
            double transition = (rowLength + columnLength) / (rowLength * columnLength);
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

  double calculateFragmentsProgress({
    Coordinate currentCoordinate,
    Coordinate startingCoordinate,
    double maxDistance,
  }) {
    double distance = currentCoordinate.distance(startingCoordinate);
    return (distance / maxDistance).clamp(.0, 1.0);
  }

  Rect calculateFragment({int i, int j, Size size}) {
    if(_fragments == null) {
      _fragments = List(rowLength);
    }
    if(_fragments[i] == null) {
      _fragments[i] = List(columnLength);
    }
    if(_fragments[i][j] == null) {
      double fragmentsWidth = size.width / rowLength;
      double fragmentsHeight = size.height / columnLength;
      _fragments[i][j] = Rect.fromLTWH(fragmentsWidth * i, fragmentsHeight * j,
          fragmentsWidth, fragmentsHeight);
    }
    return _fragments[i][j];
  }

  Coordinate initCoordinate({
    Size size,
    int rowLength,
    int columnLength,
    Offset startingOffset = Offset.zero,
  }) {
    double fragmentsWidth = size.width / rowLength;
    int x = ((startingOffset.dx ~/ fragmentsWidth)).clamp(0, rowLength);
    double fragmentsHeight = size.height / columnLength;
    int y = ((startingOffset.dy ~/ fragmentsHeight)).clamp(0, columnLength);
    return Coordinate(x: x, y: y);
  }
}
