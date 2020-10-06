import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          RaisedButton(
            child: Text('HumiditySlider'),
            onPressed: () => Navigator.of(context).push(
              noAnimationRoute(HumidityScreen()),
            ),
          ),
          RaisedButton(
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
