import 'dart:async';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_fun/utils/colors.dart';

class GlithEffect extends StatefulWidget {
  const GlithEffect({Key? key, this.child}) : super(key: key);

  final Widget? child;

  @override
  _GlithEffectState createState() => _GlithEffectState();
}

class _GlithEffectState extends State<GlithEffect>
    with SingleTickerProviderStateMixin {
  GlitchController? _controller;
  late Timer _timer;

  @override
  void initState() {
    _controller = GlitchController(
      duration: Duration(
        milliseconds: 400,
      ),
    );

    _timer = Timer.periodic(
      Duration(seconds: 3),
      (_) {
        _controller!
          ..reset()
          ..forward();
      },
    );
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _timer.cancel();
    _controller!.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: _controller!,
        builder: (_, __) {
          var color = getRandomColor().withOpacity(0.5);
          if (!_controller!.isAnimating) {
            return widget.child!;
          }
          return Stack(
            children: [
              if (random.nextBool()) _clipedChild,
              Transform.translate(
                offset: randomOffset,
                child: ShaderMask(
                  shaderCallback: (Rect bounds) {
                    return LinearGradient(
                      colors: <Color>[
                        color,
                        color,
                      ],
                    ).createShader(bounds);
                  },
                  blendMode: BlendMode.srcATop,
                  child: _clipedChild,
                ),
              ),
            ],
          );
        });
  }

  Offset get randomOffset => Offset(
        (random.nextInt(10) - 5).toDouble(),
        (random.nextInt(10) - 5).toDouble(),
      );
  Widget get _clipedChild => ClipPath(
        clipper: GlitchClipper(),
        child: widget.child,
      );
}

var random = math.Random();

class GlitchClipper extends CustomClipper<Path> {
  final deltaMax = 15;
  final min = 3;

  @override
  getClip(Size size) {
    var path = Path();
    var y = randomStep;
    while (y < size.height) {
      var yRandom = randomStep;
      var x = randomStep;

      while (x < size.width) {
        var xRandom = randomStep;
        path.addRect(
          Rect.fromPoints(
            Offset(x, y.toDouble()),
            Offset(x + xRandom, y + yRandom),
          ),
        );
        x += randomStep * 2;
      }
      y += yRandom;
    }

    path.close();
    return path;
  }

  double get randomStep => min + random.nextInt(deltaMax).toDouble();

  @override
  bool shouldReclip(covariant CustomClipper oldClipper) => true;
}

class GlitchController extends Animation<int?>
    with
        AnimationEagerListenerMixin,
        AnimationLocalListenersMixin,
        AnimationLocalStatusListenersMixin {
  GlitchController({this.duration});

  Duration? duration;
  List<Timer> _timers = [];
  bool isAnimating = false;

  forward() {
    isAnimating = true;
    var oneStep = (duration!.inMicroseconds / 3).round();
    _status = AnimationStatus.forward;
    _timers = [
      Timer(
        Duration(microseconds: oneStep),
        () => setValue(1),
      ),
      Timer(
        Duration(microseconds: oneStep * 2),
        () => setValue(2),
      ),
      Timer(
        Duration(microseconds: oneStep * 3),
        () => setValue(3),
      ),
      Timer(
        Duration(microseconds: oneStep * 4),
        () {
          _status = AnimationStatus.completed;
          isAnimating = false;
          notifyListeners();
        },
      ),
    ];
  }

  setValue(value) {
    _value = value;
    notifyListeners();
  }

  reset() {
    _status = AnimationStatus.dismissed;
    _value = 0;
  }

  @override
  void dispose() {
    _timers.forEach((timer) => timer.cancel());
    super.dispose();
  }

  @override
  AnimationStatus get status => _status;
  late AnimationStatus _status;

  @override
  int? get value => _value;
  int? _value;
}
