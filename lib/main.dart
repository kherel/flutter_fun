import 'package:flutter/material.dart';
import 'package:flutter_fun/glitch/glitch_page_screen.dart';
import 'package:flutter_fun/raw_rgba_fun/raw_rgba_screen.dart';
import 'package:flutter_fun/utils/navigation.dart';
import 'humidity_slider/humidity_screen.dart';
import 'today_list/today_list.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Flutter Fun',
      home: Home(),
    );
  }
}

class Home extends StatelessWidget {
  const Home({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
            child: const Text('Glitch effect'),
            onPressed: () => Navigator.of(context).push(
              noAnimationRoute(const GlitchPageScreen()),
            ),
          ),
          ElevatedButton(
            child: const Text('HumiditySlider'),
            onPressed: () => Navigator.of(context).push(
              noAnimationRoute(const HumidityScreen()),
            ),
          ),
          ElevatedButton(
            child: const Text('ImageAnimationScreen'),
            onPressed: () => Navigator.of(context).push(
              noAnimationRoute(const RawRgbaAnimationScreen()),
            ),
          ),
          ElevatedButton(
            child: const Text('IOS 13 Today List'),
            onPressed: () => Navigator.of(context).push(
              noAnimationRoute(const TodayListScreen()),
            ),
          ),
        ],
      ),
    );
  }
}
