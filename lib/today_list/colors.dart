import 'dart:ui';

import 'package:flutter/material.dart';

class BrandColors {
  static Color pink = Color(0xFFece4f7);

  static Gradient gradient1 = LinearGradient(colors: [
    Colors.blue,
    Colors.blueAccent,
  ]);

  static Gradient gradient2 = LinearGradient(
    colors: [
      Colors.redAccent,
      Colors.orange,
    ],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static Gradient gradient3 = RadialGradient(
    colors: [
      Colors.greenAccent,
      Colors.green,
    ],
  );
}
