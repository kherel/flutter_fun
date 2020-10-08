import 'package:flutter/material.dart';
import 'package:flutter_fun/raw_rgba_fun/points.dart';
import 'package:flutter_fun/raw_rgba_fun/screenshot.dart';
import 'package:flutter_fun/raw_rgba_fun/settings.dart';
import 'package:flutter_fun/raw_rgba_fun/settings_form.dart';

import 'package:provider/provider.dart';

import 'animated_points.dart';

class RawRgbaAnimationScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => PointNotifier()),
        ChangeNotifierProvider(create: (_) => Settings())
      ],
      child: Material(
        child: Scaffold(
          body: SafeArea(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  MainScene(),
                  SettingsForm(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class MainScene extends StatefulWidget {
  @override
  _MainSceneState createState() => _MainSceneState();
}

class _MainSceneState extends State<MainScene> {
  @override
  Widget build(BuildContext context) {
    final settings = context.watch<Settings>();
    return context.watch<PointNotifier>().isReady
        ? AnimatedPoints()
        : ScreenShot(
            size: settings.size,
            speed: settings.speed,
            resolution: settings.resolution,
            text: settings.text,
          );
  }
}
