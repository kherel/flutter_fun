import 'package:flutter/material.dart';
import 'package:flutter_fun/raw_rgba_fun/points.dart';
import 'package:flutter_fun/raw_rgba_fun/settings.dart';
import 'package:provider/provider.dart';

class SettingsForm extends StatefulWidget {
  const SettingsForm({Key key}) : super(key: key);

  @override
  _SettingsFormState createState() => _SettingsFormState();
}

class _SettingsFormState extends State<SettingsForm> {
  TextEditingController _controller;

  double _resolution;
  double _size;
  double _speed;

  void initState() {
    var settings = context.read<Settings>();
    _controller = TextEditingController(text: settings.text);
    _resolution = settings.resolution.toDouble();
    _size = settings.size.toDouble();
    _speed = settings.speed.toDouble();

    super.initState();
  }

  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void Function(double value) _notifyChange(Function callback) =>
      (double value) {
        callback(value);
        context.read<PointNotifier>().setIsReady(false);
      };

  @override
  Widget build(BuildContext context) {
    final settings = Provider.of<Settings>(context);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40.0),
      child: Column(
        children: [
          TextField(
            textAlign: TextAlign.center,
            controller: _controller,
            onChanged: (String value) {
              context.read<PointNotifier>().setIsReady(false);
              settings.updateText(value);
            },
          ),
          SizedBox(height: 30),
          _buildSlider(
            'Size',
            _size,
            (v) => _size = v,
            _notifyChange(settings.updateSize),
          ),
          _buildSlider(
            'Speed',
            _speed,
            (v) => _speed = v,
            _notifyChange(settings.updateDuration),
          ),
          _buildSlider(
            'Resolution',
            _resolution,
            (v) => _resolution = v,
            _notifyChange(settings.updateResolution),
          ),
        ],
      ),
    );
  }

  Widget _buildSlider(
    String name,
    double value,
    Function onChange,
    Function setValue, {
    canBeZero = false,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(child: Text(name)),
        Slider(
          min: canBeZero ? 0 : 1,
          max: kMax,
          value: value.toDouble(),
          onChanged: (value) =>
              setState(() => onChange(value.round().toDouble())),
          onChangeEnd: setValue,
        ),
      ],
    );
  }
}
