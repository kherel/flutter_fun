class HumidityConfig {
  HumidityConfig(int minValue, int maxValue) {
    firstActiveIndex = list.indexWhere((n) => n >= minValue);
    lastActiveIndex = list.lastIndexWhere((n) => n <= maxValue);
  }

  int firstActiveIndex;
  int lastActiveIndex;

  final paddingTopInPercentage = 13.3;
  final paddingBottomInPercentage = 11.2;

  final List<int> list = const [0, 10, 25, 30, 35, 40, 45, 50, 75, 100];
}

double kNumberFontSize = 18;
