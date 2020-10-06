import 'package:flutter/widgets.dart';

Route noAnimationRoute(Widget widget) => PageRouteBuilder(
      pageBuilder: (context, animation1, animation2) => widget,
    );
