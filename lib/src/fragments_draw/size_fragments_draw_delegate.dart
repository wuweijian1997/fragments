import 'dart:math';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter_fragments/flutter_fragments.dart';

class SizeFragmentsDrawDelegate extends FragmentsDrawDelegate {
  final Size size;
  final bool disableTransition;

  List<List<Rect?>?>? _fragments;
  Coordinate? _startingCoordinate;
  late int numberOfRow;
  late int numberOfColumn;

  SizeFragmentsDrawDelegate({
    this.size = const Size(50, 50),
    this.disableTransition = true,
  });

  @override
  void draw({
    required Canvas canvas,
    required double progress,
    required ui.Image paintImage,
    required Offset startingOffset,
  }) {
    assert(!size.isEmpty);
    Paint paint = Paint();
    Size imageSize = Size(
      paintImage.width.toDouble(),
      paintImage.height.toDouble(),
    );
    calculateRowAndColumn(size: size, imageSize: imageSize);
    calculateStartingCoordinate(
      size: size,
      imageSize: imageSize,
      startingOffset: startingOffset,
    );
    double maxDistance = _startingCoordinate?.maxDistance(
          maxX: numberOfRow - 1,
          maxY: numberOfColumn - 1,
        ) ??
        0;
    for (int i = 0; i < numberOfColumn; i++) {
      for (int j = 0; j < numberOfRow; j++) {
        double currentProgress = calculateFragmentProgress(
          maxDistance: maxDistance,
          currentCoordinate: Coordinate(x: j, y: i),
        );
        if (currentProgress > progress) {
          Rect rect = calculateFragment(i: i, j: j, size: size);
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

  void calculateStartingCoordinate({
    required Size size,
    required Size imageSize,
    required Offset startingOffset,
  }) {
    int x = ((startingOffset.dx ~/ size.width)).clamp(0, numberOfRow);
    int y = ((startingOffset.dy ~/ size.height)).clamp(0, numberOfColumn);
    _startingCoordinate = Coordinate(x: x, y: y);
  }

  void calculateRowAndColumn({required Size size, required Size imageSize}) {
    numberOfRow = (imageSize.width / size.width).ceil();
    numberOfColumn = (imageSize.height / size.height).ceil();
  }

  double calculateFragmentProgress({
    required double maxDistance,
    required Coordinate currentCoordinate,
  }) {
    if (_startingCoordinate != null) {
      double distance = currentCoordinate.distance(_startingCoordinate!);
      return (distance / maxDistance).clamp(.0, 1.0);
    }
    return 0;
  }

  Rect calculateFragment({required int i, required int j, required Size size}) {
    assert(i >= 0);
    assert(j >= 0);
    if (_fragments == null) {
      _fragments = List.filled(numberOfColumn, null);
    }
    if (_fragments?[i] == null) {
      _fragments?[i] = List.filled(numberOfRow, null);
    }
    if (_fragments?[i]?[j] == null) {
      double fragmentsWidth = size.width;
      double fragmentsHeight = size.height;
      _fragments![i]![j] = Rect.fromLTWH(
        fragmentsWidth * j,
        fragmentsHeight * i,
        fragmentsWidth,
        fragmentsHeight,
      );
    }
    return _fragments![i]![j]!;
  }
}
