import 'package:flutter/material.dart';
import 'package:flutter_fun/raw_rgba_fun/points.dart';
import 'package:flutter_fun/raw_rgba_fun/screenshot.dart';
import 'package:flutter_fun/raw_rgba_fun/settings.dart';
import 'package:flutter_fun/raw_rgba_fun/settings_form.dart';

import 'package:provider/provider.dart';

import 'animated_points.dart';

class RawRgbaAnimationScreen extends StatelessWidget {
  const RawRgbaAnimationScreen({super.key});

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
                children: const [
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
  const MainScene({super.key});

  @override
  State<MainScene> createState() => _MainSceneState();
}

class _MainSceneState extends State<MainScene> {
  @override
  Widget build(BuildContext context) {
    final settings = context.watch<Settings>();
    return context.watch<PointNotifier>().isReady
        ? const AnimatedPoints()
        : ScreenShot(
            size: settings.size,
            speed: settings.speed,
            resolution: settings.resolution,
            text: settings.text,
          );
  }
}
