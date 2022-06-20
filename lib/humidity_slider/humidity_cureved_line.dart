import 'package:flutter/material.dart';
import 'package:flutter_fun/humidity_slider/theme.dart';

class HumidityCurevedLine extends StatelessWidget {
  const HumidityCurevedLine({Key? key, this.y}) : super(key: key);

  final double? y;
  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: _MovingCurvedCliper(y),
      child: Container(
        width: 41,
        decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment(0, -1),
              end: Alignment(0, 1),
              colors: [
                BrandColors.background,
                BrandColors.redViolet,
                BrandColors.redViolet,
                BrandColors.cerulean,
                BrandColors.cerulean,
                BrandColors.redViolet,
                BrandColors.redViolet,
                BrandColors.background,
              ],
              stops: [
                0.01,
                0.1,
                0.25,
                0.37,
                0.66,
                0.78,
                0.9,
                0.99
              ]),
        ),
      ),
    );
  }
}

class _MovingCurvedCliper extends CustomClipper<Path> {
  _MovingCurvedCliper(this.centerY);

  final double? centerY;

  @override
  Path getClip(Size size) {
    var unit = size.height / 100;

    var deltaY = -(52 - centerY! / unit) * unit;
    return Path()
      ..moveTo(unit * 4.49826, unit * 45.4994 + deltaY)
      ..lineTo(unit * 4.49826, 0.0)
      ..lineTo(unit * 5.02865, 0.0)
      ..lineTo(unit * 5.02865, unit * 45.4994 + deltaY)
      ..cubicTo(unit * 5.0289, unit * 48.0554 + deltaY, unit * 3.8406,
          unit * 49.3551 + deltaY, unit * 2.7054, unit * 50.5294 + deltaY)
      ..cubicTo(unit * 2.6739, unit * 50.5620 + deltaY, unit * 2.6424,
          unit * 50.5944 + deltaY, unit * 2.6111, unit * 50.6268 + deltaY)
      ..cubicTo(unit * 1.5185, unit * 51.7552 + deltaY, unit * 0.5304,
          unit * 52.7758 + deltaY, unit * 0.5304, unit * 54.7627 + deltaY)
      ..cubicTo(unit * 0.5304, unit * 56.7496 + deltaY, unit * 1.5185,
          unit * 57.7702 + deltaY, unit * 2.6111, unit * 58.8986 + deltaY)
      ..cubicTo(unit * 2.6424, unit * 58.9310 + deltaY, unit * 2.6739,
          unit * 58.9635 + deltaY, unit * 2.7054, unit * 58.9961 + deltaY)
      ..cubicTo(unit * 3.8406, unit * 60.1703 + deltaY, unit * 5.0289,
          unit * 61.4700 + deltaY, unit * 5.0286, unit * 64.0260 + deltaY)
      ..lineTo(unit * 5.02865, size.height)
      ..lineTo(unit * 4.49826, size.height)
      ..lineTo(unit * 4.49826, unit * 64.026 + deltaY)
      ..cubicTo(unit * 4.4985, unit * 61.6857 + deltaY, unit * 3.4377,
          unit * 60.5159 + deltaY, unit * 2.3237, unit * 59.3636 + deltaY)
      ..cubicTo(unit * 2.2857, unit * 59.3244 + deltaY, unit * 2.2477,
          unit * 59.2851 + deltaY, unit * 2.2096, unit * 59.2459 + deltaY)
      ..cubicTo(unit * 1.1236, unit * 58.1252 + deltaY, 0.0,
          unit * 56.9659 + deltaY, 0.0, unit * 54.7627 + deltaY)
      ..cubicTo(0.0, unit * 52.5596 + deltaY, unit * 1.1236,
          unit * 51.4003 + deltaY, unit * 2.2096, unit * 50.2796 + deltaY)
      ..cubicTo(unit * 2.2477, unit * 50.2403 + deltaY, unit * 2.2857,
          unit * 50.2011 + deltaY, unit * 2.3237, unit * 50.1618 + deltaY)
      ..cubicTo(unit * 3.4377, unit * 49.0096 + deltaY, unit * 4.4985,
          unit * 47.8397 + deltaY, unit * 4.4983, unit * 45.4994 + deltaY)
      ..close();
  }

  @override
  bool shouldReclip(_MovingCurvedCliper oldClipper) {
    return oldClipper.centerY != centerY;
  }
}
