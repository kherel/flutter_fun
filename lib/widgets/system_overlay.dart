import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SystemOverlay extends StatelessWidget {
  const SystemOverlay({
    Key? key,
    this.isFontBlack,
    required this.child,
  }) : super(key: key);

  final bool? isFontBlack;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    SystemUiOverlayStyle overlayStyle;

    if (isFontBlack == null) {
      overlayStyle = Theme.of(context).brightness == Brightness.dark
          ? SystemUiOverlayStyle.light
          : SystemUiOverlayStyle.dark;
    } else {
      overlayStyle =
          isFontBlack! ? SystemUiOverlayStyle.dark : SystemUiOverlayStyle.light;
    }

    return AnnotatedRegion(
      value: overlayStyle,
      child: child,
    );
  }
}
