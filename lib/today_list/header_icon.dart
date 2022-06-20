import 'package:flutter/material.dart';

class HeaderIcon extends StatelessWidget {
  const HeaderIcon({
    Key? key,
    required this.gradient,
    required this.iconData,
  })  : assert(iconData != null),
        assert(gradient != null),
        super(key: key);

  final IconData iconData;
  final Gradient gradient;
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(5),
      child: Container(
        decoration: BoxDecoration(
          gradient: gradient
        ),
        height: 23,
        width: 23,
        child: Icon(
          iconData,
          size: 18,
          color: Colors.white,
        ),
      ),
    );
  }
}
