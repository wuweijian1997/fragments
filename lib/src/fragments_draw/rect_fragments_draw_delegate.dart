import 'dart:ui';

import 'package:flutter_fragments/flutter_fragments.dart';

abstract class RectFragmentsDrawDelegate extends FragmentsDrawDelegate {
  ///行
  final int numberOfRow;
  ///列
  final int numberOfColumn;
  Coordinate _startingCoordinate;
  List<List<Rect>> _fragments;

  RectFragmentsDrawDelegate({
    this.numberOfRow,
    this.numberOfColumn,
  })  : assert(numberOfRow != null && numberOfRow > 0),
        assert(numberOfColumn != null && numberOfColumn > 0);

  Coordinate get startingCoordinate => _startingCoordinate;

  Rect calculateFragment({int i, int j, Size size}) {
    assert(size != null);
    assert(i != null && i >= 0);
    assert(j != null && j >= 0);
    if (_fragments == null) {
      _fragments = List(numberOfColumn);
    }
    if (_fragments[i] == null) {
      _fragments[i] = List(numberOfRow);
    }
    if (_fragments[i][j] == null) {
      double fragmentsWidth = size.width / numberOfRow;
      double fragmentsHeight = size.height / numberOfColumn;
      _fragments[i][j] = Rect.fromLTWH(
        fragmentsWidth * j,
        fragmentsHeight * i,
        fragmentsWidth,
        fragmentsHeight,
      );
    }
    return _fragments[i][j];
  }

  void calculateStartingCoordinate({
    Size size,
    Offset startingOffset = Offset.zero,
  }) {
    double fragmentsWidth = size.width / numberOfRow;
    double fragmentsHeight = size.height / numberOfColumn;
    int x = ((startingOffset.dx ~/ fragmentsWidth)).clamp(0, numberOfRow);
    int y = ((startingOffset.dy ~/ fragmentsHeight)).clamp(0, numberOfColumn);
    _startingCoordinate = Coordinate(x: x, y: y);
  }
}
