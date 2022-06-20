import 'package:flutter/material.dart';
import 'package:flutter_fun/glitch/glitch_page_screen.dart';
import 'package:flutter_fun/raw_rgba_fun/raw_rgba_screen.dart';
import 'package:flutter_fun/utils/navigation.dart';
import 'humidity_slider/humidity_screen.dart';
import 'today_list/today_list.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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
            child: Text('Glitch effect'),
            onPressed: () => Navigator.of(context).push(
              noAnimationRoute(GlitchPageScreen()),
            ),
          ),
          ElevatedButton(
            child: Text('HumiditySlider'),
            onPressed: () => Navigator.of(context).push(
              noAnimationRoute(HumidityScreen()),
            ),
          ),
          ElevatedButton(
            child: Text('ImageAnimationScreen'),
            onPressed: () => Navigator.of(context).push(
              noAnimationRoute(RawRgbaAnimationScreen()),
            ),
          ),
          ElevatedButton(
            child: Text('IOS 13 Today List'),
            onPressed: () => Navigator.of(context).push(
              noAnimationRoute(TodayListScreen()),
            ),
          ),
        ],
      ),
    );
  }
}
