import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_fun/raw_rgba_fun/points.dart';
import 'package:flutter_fun/raw_rgba_fun/settings.dart';

import 'package:provider/provider.dart';

class ScreenShot extends StatefulWidget {
  ScreenShot({
    Key key,
    this.size,
    this.speed,
    this.resolution,
    this.text,
  }) : super(key: key);

  final int size;
  final int speed;
  final int resolution;
  final String text;

  @override
  _ScreenShotState createState() => _ScreenShotState();
}

class _ScreenShotState extends State<ScreenShot> {
  final GlobalKey _globalKey = GlobalKey();
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _setArray());
  }

  _setArray() async {
    Future.delayed(Duration(milliseconds: 100), () async {
      try {
        RenderRepaintBoundary boundary =
            _globalKey.currentContext.findRenderObject();
        var image = await boundary.toImage(pixelRatio: 1);
        var width = image.width;
        var height = image.height;

        var byteData =
            await image.toByteData(format: ui.ImageByteFormat.rawRgba);
        var pngBytes = byteData.buffer.asUint8List();
        var points = <Point>[];

        /// [step] is how many pixel we step forvard, cannot be 0;
        var step = kMax.round() - widget.resolution + 1;
        for (var y = 3; y < height; y += step) {
          for (var x = 0; x < width; x += step) {
            var index = 4 * (y * width + x) + 3;

            if (pngBytes[index] != 0) {
              points.add(
                Point(
                  Offset(
                    x.toDouble(),
                    y.toDouble(),
                  ),
                  pngBytes[index],
                  widget.speed,
                ),
              );
            }
          }
        }
        context.read<PointNotifier>().setPoints(points);
        context.read<PointNotifier>().setIsReady(true);
      } catch (e) {
        print(e);
      }
    });
  }

  AnimationController controller;
  @override
  void didUpdateWidget(ScreenShot oldWidget) {
    if (oldWidget.size != widget.size ||
        oldWidget.speed != widget.speed ||
        oldWidget.resolution != widget.resolution ||
        oldWidget.text != widget.text) {
      context.read<PointNotifier>().setIsReady(false);
      _setArray();
    }

    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      key: _globalKey,
      child: Container(
        height: 300,
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FlutterLogo(
              size: 150,
            ),
            SizedBox(height: 30),
            Text(
              context.watch<Settings>().text,
              style: TextStyle(fontSize: 55),
            ),
          ],
        ),
      ),
    );
  }
}
