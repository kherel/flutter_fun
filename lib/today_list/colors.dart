import 'package:flutter/material.dart';

class BrandColors {
  static Color pink = const Color(0xFFece4f7);

  static Gradient gradient1 = const LinearGradient(colors: [
    Colors.blue,
    Colors.blueAccent,
  ]);

  static Gradient gradient2 = const LinearGradient(
    colors: [
      Colors.redAccent,
      Colors.orange,
    ],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static Gradient gradient3 = const RadialGradient(
    colors: [
      Colors.greenAccent,
      Colors.green,
    ],
  );
}
