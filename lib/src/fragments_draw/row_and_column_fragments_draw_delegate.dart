import 'dart:ui';

import 'package:flutter_fragments/flutter_fragments.dart';

abstract class RowAndColumnFragmentsDrawDelegate extends FragmentsDrawDelegate {
  ///行
  final int numberOfRow;
  ///列
  final int numberOfColumn;
  Coordinate? _startingCoordinate;
  List<List<Rect?>?>? _fragments;

  RowAndColumnFragmentsDrawDelegate({
    required this.numberOfRow,
    required this.numberOfColumn,
  })  : assert(numberOfRow > 0),
        assert(numberOfColumn > 0);

  Coordinate? get startingCoordinate => _startingCoordinate;

  Rect calculateFragment({required int i, required int j, required Size size}) {

    assert(i >= 0 && j >= 0);
    if (_fragments == null) {
      _fragments = List.filled(numberOfColumn, null);
    }
    if (_fragments?[i] == null) {
      _fragments?[i] = List.filled(numberOfRow, null);
    }
    if (_fragments?[i]?[j] == null) {
      double fragmentsWidth = size.width / numberOfRow;
      double fragmentsHeight = size.height / numberOfColumn;
      _fragments?[i]?[j] = Rect.fromLTWH(
        fragmentsWidth * j,
        fragmentsHeight * i,
        fragmentsWidth,
        fragmentsHeight,
      );
    }
    return _fragments![i]![j]!;
  }

  void calculateStartingCoordinate({
    required Size size,
    Offset startingOffset = Offset.zero,
  }) {
    double fragmentsWidth = size.width / numberOfRow;
    double fragmentsHeight = size.height / numberOfColumn;
    int x = ((startingOffset.dx ~/ fragmentsWidth)).clamp(0, numberOfRow);
    int y = ((startingOffset.dy ~/ fragmentsHeight)).clamp(0, numberOfColumn);
    _startingCoordinate = Coordinate(x: x, y: y);
  }
}
