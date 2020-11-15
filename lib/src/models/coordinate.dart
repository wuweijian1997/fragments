import 'dart:math';

import 'package:flutter/material.dart';

class Coordinate {
  final int x;
  final int y;

  const Coordinate({@required this.x, @required this.y});

  maxDistance({int maxX, int maxY}) {
    assert(x != null && y != null);
    int maxHorDistance = max(x, (x - maxX - 1).abs());
    int maxVerDistance= max(y, (y- maxY - 1).abs());
    return sqrt(maxHorDistance * maxHorDistance + maxVerDistance * maxVerDistance);
  }

  distance(Coordinate c) {
    assert(x != null && y != null);
    assert(c.x != null && c.y != null);
    return sqrt((x - c.x) * (x - c.x) + (y - c.y) * (y - c.y));
  }

  @override
  String toString() {
    return 'Coordinate{x: $x, y: $y}';
  }
}