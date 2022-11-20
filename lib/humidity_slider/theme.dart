import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

var kBallSize = 44.0;

var humiditySliderTheme = ThemeData.dark().copyWith(
  backgroundColor: BrandColors.background,
  textTheme: GoogleFonts.rubikTextTheme(
    TextTheme(
      subtitle1: TextStyle(
        color: BrandColors.secondaryText,
        fontSize: 14.5,
      ),
      bodyText1: TextStyle(
        color: BrandColors.mainText,
      ),
    ),
  ),
);

var currentHumidityStyle = const TextStyle(
  fontSize: 80,
  fontWeight: FontWeight.bold,
);

class BrandColors {
  static Color get attention => schoolBusYellow;
  static Color get background => blackpearl;
  static Color get mainText => sugarCane;
  static Color get secondaryText => fiord;
  static Color get active => cerulean;

  static const blackpearl = Color(0xFF060829);
  static const sugarCane = Color(0xFFfefffe);
  static const cerulean = Color(0xFF00b4e1);
  static const redViolet = Color(0xFFff008d);
  static const fiord = Color(0xFF444c68);
  static const schoolBusYellow = Color(0xFFfddc08);
}
