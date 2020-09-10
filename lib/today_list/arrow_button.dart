import 'dart:math' as math;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ArrowButton extends StatefulWidget {
  ArrowButton({
    Key key,
    @required this.onTap,
    @required this.isExpanded,
  })  : assert(onTap != null),
        assert(isExpanded != null),
        super(key: key);

  final void Function(bool isExpanded) onTap;
  final bool isExpanded;

  @override
  _ArrowButtonState createState() => _ArrowButtonState();
}

class _ArrowButtonState extends State<ArrowButton>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation<double> _animation;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    _controller = AnimationController(
      duration: Duration(milliseconds: 150),
      vsync: this,
    );
    _animation = _controller.drive(CurveTween(curve: Curves.easeIn));

    super.initState();
  }

  void _handleTap() {
    setState(() {
      widget.onTap(!widget.isExpanded);
      if (widget.isExpanded) {
        _controller.reverse();
      } else {
        _controller.forward();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _handleTap,
      behavior: HitTestBehavior.opaque,
      child: Padding(
        padding: const EdgeInsets.all(3.0),
        child: AnimatedBuilder(
          animation: _controller.view,
          builder: (context, child) {
            return Transform.rotate(
              angle: math.pi * _animation.value * 0.5,
              child: child,
            );
          },
          child: Icon(
            Icons.arrow_forward_ios,
            color: Colors.white30,
            size: 14,
          ),
        ),
      ),
    );
  }
}
