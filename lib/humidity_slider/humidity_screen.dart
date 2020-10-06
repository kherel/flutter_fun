import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'humidity.dart';
import 'humidity_congfig.dart';
import 'humidity_info.dart';
import 'scaffold.dart';
import 'slider.dart';

class HumidityScreen extends StatelessWidget {
  const HumidityScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider(create: (_) => HumidityConfig(25, 50)),
        ChangeNotifierProvider(create: (_) => Humidity())
      ],
      child: HSScaffold(
        activeIndex: 1,
        body: HumiditySliderPage(),
      ),
    );
  }
}

class HumiditySliderPage extends StatelessWidget {
  const HumiditySliderPage({Key key}) : super(key: key);

  final bool kShowBack = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(
        image: kShowBack
            ? DecorationImage(
                image: AssetImage("assets/design.png"),
                fit: BoxFit.cover,
              )
            : null,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            width: 208,
            child: HumiditySlider(),
          ),
          Expanded(child: HumidityInfo())
        ],
      ),
    );
  }
}
