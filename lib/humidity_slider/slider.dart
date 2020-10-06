import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_fun/humidity_slider/slider_ball.dart';
import 'package:provider/provider.dart';

import 'humidity.dart';
import 'humidity_congfig.dart';
import 'humidity_cureved_line.dart';
import 'measurement_numbers.dart';
import 'theme.dart';

class HumiditySlider extends StatelessWidget {
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraintes) {
      var maxHeight = constraintes.maxHeight;
      var oneUnit = maxHeight / 100;
      var value = context.watch<Humidity>().transitionalValue;
      return Row(
        children: [MeasurementNumbers(oneUnit, value), SliderHandle(oneUnit)],
      );
    });
  }
}

class SliderHandle extends StatefulWidget {
  SliderHandle(this.oneUnit, {Key key}) : super(key: key);
  final double oneUnit;
  @override
  _SliderHandleState createState() => _SliderHandleState();
}

class _SliderHandleState extends State<SliderHandle> {
  double dy = 400;
  double diameter = kBallSize;
  HumidityConfig config;

  double _min;
  double _max;
  double _stepHeight;
  void Function(double) updateTrasitionalHumidity;
  void Function() updateFinalHumidity;

  void handleDrag(details) {
    double newDy = (details.globalPosition.dy - diameter).clamp(_min, _max);

    if (dy != newDy) {
      setState(() {
        updateTrasitionalHumidity(_calcualteHumidity(newDy));
        dy = newDy;
      });
    }
  }

  double Function(double) _calcualteHumidity;

  @override
  void initState() {
    super.initState();
    updateTrasitionalHumidity = context.read<Humidity>().updateTrasitionalValue;
    updateFinalHumidity = context.read<Humidity>().updateFinalValue;

    config = context.read<HumidityConfig>();
    var fontSizeShift = kNumberFontSize / 2;

    var paddingTop =
        widget.oneUnit * config.paddingTopInPercentage + fontSizeShift;
    var paddingBottom =
        widget.oneUnit * config.paddingBottomInPercentage + fontSizeShift;
    var height = widget.oneUnit * 100;
    var body = height - paddingTop - paddingBottom;
    var stepsCount = config.list.length;
    _stepHeight = body / (stepsCount - 1);
    var disacitvatedTopPart =
        _stepHeight * (stepsCount - config.lastActiveIndex - 1);
    var disacitvatedBottomPart = _stepHeight * (config.firstActiveIndex);

    _calcualteHumidity = (newDy) {
      var procantage = 1 - (newDy - _min) / (_stepHeight * 5);

      var activeCapacity = config.list[config.lastActiveIndex] -
          config.list[config.firstActiveIndex];
      return procantage * activeCapacity + config.list[config.firstActiveIndex];
    };

    _min = disacitvatedTopPart + paddingTop;
    _max = height - disacitvatedBottomPart - paddingBottom;
  }

  @override
  Widget build(BuildContext context) {
    var centerY = dy - diameter / 2;
    return Container(
      width: 100,
      child: Stack(
        fit: StackFit.passthrough,
        children: [
          Positioned(
            top: 0,
            bottom: 0,
            left: 15,
            right: 40,
            child: CustomPaint(painter: LinesPainter(config, centerY)),
          ),
          Positioned(
            top: 0,
            bottom: 0,
            right: 25,
            child: HumidityCurevedLine(
              y: centerY,
            ),
          ),
          Positioned(
            right: 0,
            top: centerY,
            child: GestureDetector(
              onVerticalDragStart: handleDrag,
              onVerticalDragUpdate: handleDrag,
              onVerticalDragEnd: (_) => updateFinalHumidity(),
              child: SliderBall(),
            ),
          ),
        ],
      ),
    );
  }
}

class LinesPainter extends CustomPainter {
  LinesPainter(this.config, this.centerY);
  final HumidityConfig config;
  final double centerY;

  @override
  void paint(Canvas canvas, Size size) {
    final width = size.width;
    final height = size.height;
    final linesCount = (config.list.length - 1) * 5 + 1;

    final paddingTop =
        config.paddingTopInPercentage * height / 100 + kNumberFontSize / 2;
    final paddingBottom =
        config.paddingBottomInPercentage * height / 100 + kNumberFontSize / 2;

    final oneLineStep =
        (height - paddingTop - paddingBottom) / (linesCount - 1);
    var y = paddingTop;
    var path = Path();

    for (var i = 0; i < linesCount; i++) {
      var isLong = i % 5 == 0;
      var startX = isLong ? 22.0 : 29.0;
      var endX = width;
      var fix = 23; // don't know why do I need it. 😅
      var distanceTillCenter = (y - centerY - fix).abs();
      if (distanceTillCenter < 50) {
        var sin = distanceTillCenter / 50;
        var angle = math.asin(sin);
        var cos = math.cos(angle);
        var delta = 30 * cos * cos * 1.05;
        startX -= delta;
        endX -= delta;
      }
      path
        ..moveTo(startX, y)
        ..lineTo(endX, y);

      y += oneLineStep;
    }

    var paint = Paint()
      ..color = BrandColors.fiord
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
