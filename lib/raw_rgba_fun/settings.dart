import 'package:flutter/widgets.dart';

const kMax = 5.0;

class Settings with ChangeNotifier {
  int _size = 3;
  int _speed = 1;
  int _resolution = 3;
  String _text = 'Flutter';

  int get size => _size;
  int get speed => _speed;
  int get resolution => _resolution;
  String get text => _text;

  void updateText(String newValue) {
    _text = newValue;
    notifyListeners();
  }

  void updateSize(double newValue) {
    _size = newValue.round();
    notifyListeners();
  }

  void updateDuration(double newValue) {
    _speed = newValue.round();
    notifyListeners();
  }

  void updateResolution(double newValue) {
    _resolution = newValue.round();
    notifyListeners();
  }
}
