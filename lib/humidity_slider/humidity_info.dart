import 'package:flutter/material.dart';
import 'package:flutter_fun/fun_icons_icons.dart';
import 'package:flutter_fun/humidity_slider/theme.dart';
import 'package:provider/provider.dart';

import 'humidity.dart';

class HumidityInfo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var value = context.watch<Humidity>().finalValue;
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Spacer(flex: 2),
          Container(
            height: 470,
            alignment: Alignment.topLeft,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _Subtitle('Return temperature'),
                SizedBox(height: 10),
                Text(
                  '20℃',
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 50),
                _Subtitle('Current humidity'),
                SizedBox(height: 10),
                Row(
                  children: [
                    AnimatedLetter(
                      letter: value.toString()[0],
                    ),
                    AnimatedLetter(
                      letter: value.toString()[1],
                    ),
                    SizedBox(
                      child: Text('%', style: currentHumidityStyle),
                    )
                  ],
                ),
                SizedBox(height: 40),
                _Subtitle('Absolute humidity'),
                SizedBox(height: 12),
                Text(
                  '4gr/fg3',
                  style: TextStyle(
                    fontSize: 27,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 42),
                Icon(
                  FunIcons.warningSign,
                  color: BrandColors.attention,
                ),
                SizedBox(height: 10),
                RichText(
                  text: TextSpan(
                    children: <InlineSpan>[
                      WidgetSpan(
                        alignment: PlaceholderAlignment.middle,
                        child: Icon(
                          Icons.brightness_1,
                          size: 8,
                          color: BrandColors.attention,
                        ),
                      ),
                      TextSpan(
                        style: TextStyle(height: 1.3),
                        text:
                            ' — extreme humidity level. \n Use precaution for set-points \n outside of 20%-50%',
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          Spacer(flex: 1),
        ],
      ),
    );
  }
}

class AnimatedLetter extends StatefulWidget {
  AnimatedLetter({Key? key, this.letter}) : super(key: key);

  final String? letter;

  @override
  _AnimatedLetterState createState() => _AnimatedLetterState();
}

class _AnimatedLetterState extends State<AnimatedLetter>
    with SingleTickerProviderStateMixin {
  AnimationController? controller;

  String? currentLetter;
  String? prevLetter;

  @override
  void initState() {
    controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    currentLetter = widget.letter;
    prevLetter = widget.letter;
    super.initState();
  }

  @override
  void didUpdateWidget(AnimatedLetter oldWidget) {
    if (widget.letter != oldWidget.letter) {
      setState(() {
        prevLetter = oldWidget.letter;
        currentLetter = widget.letter;
        controller
          ..reset()
          ..forward();
      });
    }

    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: controller!,
        builder: (_, __) {
          return Container(
            width: 48,
            child: Stack(
              children: [
                Transform.translate(
                  offset: Offset(0, -controller!.value * 50),
                  child: Opacity(
                    opacity: 1 - controller!.value,
                    child: Text(
                      prevLetter!,
                      style: currentHumidityStyle,
                    ),
                  ),
                ),
                Transform.translate(
                  offset: Offset(0, 50 - controller!.value * 50),
                  child: Opacity(
                    opacity: controller!.value,
                    child: Text(
                      currentLetter!,
                      style: currentHumidityStyle,
                    ),
                  ),
                ),
              ],
            ),
          );
        });
  }
}

class _Subtitle extends StatelessWidget {
  const _Subtitle(
    this.text, {
    Key? key,
  }) : super(key: key);

  final String text;
  @override
  Widget build(BuildContext context) {
    return Text(
      text.toUpperCase(),
      style: Theme.of(context).textTheme.subtitle1,
    );
  }
}
