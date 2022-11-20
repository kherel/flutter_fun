import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_fun/widgets/system_overlay.dart';

part 'button.dart';
part 'keyboard.dart';
part 'display.dart';

class CalculatorScreen extends StatefulWidget {
  const CalculatorScreen({super.key});

  @override
  State<CalculatorScreen> createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  @override
  Widget build(BuildContext context) {
    return SystemOverlay(
      isFontBlack: false,
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              SizedBox(
                height: max(10, MediaQuery.of(context).padding.top),
              ),
              const Expanded(child: _Display()),
              const _Keyboard(),
              SizedBox(
                height: max(10, MediaQuery.of(context).padding.bottom),
              )
            ],
          ),
        ),
      ),
    );
  }
}
