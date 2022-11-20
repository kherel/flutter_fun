import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter_fun/raw_rgba_fun/points.dart';
import 'package:flutter_fun/raw_rgba_fun/settings.dart';

import 'package:provider/provider.dart';

class AnimatedPoints extends StatefulWidget {
  const AnimatedPoints({Key? key}) : super(key: key);

  @override
  State<AnimatedPoints> createState() => _AnimatedPointsState();
}

class _AnimatedPointsState extends State<AnimatedPoints>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  @override
  void initState() {
    controller = AnimationController(
      lowerBound: 0.0,
      upperBound: 1000.0,
      duration: const Duration(seconds: 1000),
      vsync: this,
    );
    controller.forward();
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var points = context.watch<PointNotifier>().points;
    var settings = context.watch<Settings>();

    return SizedBox(
      height: 300,
      width: MediaQuery.of(context).size.width,
      child: AnimatedBuilder(
        animation: controller,
        builder: (_, __) {
          return CustomPaint(
            painter: PointsPainter(points, controller.value, settings),
          );
        },
      ),
    );
  }
}

class PointsPainter extends CustomPainter {
  PointsPainter(
    this.points,
    this.animationValue,
    this.settings,
  );

  final List<Point>? points;
  final double animationValue;
  final Settings settings;

  @override
  void paint(ui.Canvas canvas, ui.Size size) {
    var paint = Paint()..style = PaintingStyle.fill;
    for (var point in points!) {
      paint.color = point.color;
      // print(point.startDelay);
      if (animationValue >= point.startDelay) {
        var animationFactor =
            ((animationValue - point.startDelay) * settings.speed % kMax / kMax)
                .abs();

        var size = settings.size * point.sizeFactor * animationFactor;
        canvas.drawCircle(
          point.offset,
          size,
          paint,
        );
      }
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
