import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_fun/raw_rgba_fun/settings.dart';

class PointNotifier with ChangeNotifier {
  List<Point> _points;
  bool _isReady = false;

  List<Point> get points => _points;
  bool get isReady => _isReady;

  void setPoints(List<Point> points) => _points = points;

  void setIsReady(bool isReady) {
    _isReady = isReady;
    notifyListeners();
  }
}

Random random = Random();

class Point {
  Point(this.offset, int alfa, int speed)
      : sizeFactor = alfa / 255,
        color = Colors.primaries[random.nextInt(Colors.primaries.length)],
        startDelay = random.nextDouble() * kMax - speed;

  final Offset offset;
  final double sizeFactor;
  final Color color;
  final double startDelay;
}
