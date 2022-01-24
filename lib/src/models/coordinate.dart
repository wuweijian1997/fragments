import 'dart:math';

class Coordinate {
  final int x;
  final int y;

  const Coordinate({required this.x, required this.y});

  double maxDistance({required int maxX, required int maxY}) {
    int maxHorDistance = max(x, (x - maxX).abs());
    int maxVerDistance= max(y, (y- maxY).abs());
    return sqrt(maxHorDistance * maxHorDistance + maxVerDistance * maxVerDistance);
  }

  distance(Coordinate c) {
    return sqrt((x - c.x) * (x - c.x) + (y - c.y) * (y - c.y));
  }

  @override
  String toString() {
    return 'Coordinate{x: $x, y: $y}';
  }
}