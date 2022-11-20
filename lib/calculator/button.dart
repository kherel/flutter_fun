part of 'calculator.dart';

class _Button extends StatelessWidget {
  const _Button.dark({
    required this.value,
  })  : backgroundColor = const Color(0xFF343434),
        textColor = Colors.white,
        fontHeight = 1.2,
        padding = EdgeInsets.zero;

  const _Button.light({
    required this.value,
    this.fontHeight = 1.0,
  })  : backgroundColor = const Color(0xFFA5A5A5),
        textColor = Colors.black,
        padding = EdgeInsets.zero;

  const _Button.orange({
    required this.value,
    this.padding = EdgeInsets.zero,
  })  : backgroundColor = const Color(0xFFFF9F0A),
        textColor = Colors.white,
        fontHeight = 1;

  final String value;
  final Color backgroundColor;
  final Color textColor;
  final double fontHeight;
  final EdgeInsets padding;

  @override
  Widget build(BuildContext context) {
    var sizeK = MediaQuery.of(context).size.width / 375;
    return Container(
      height: 75 * sizeK,
      width: 75 * sizeK,
      padding: padding * sizeK,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: backgroundColor,
      ),
      alignment: Alignment.center,
      child: Text(
        value,
        style: TextStyle(
          color: textColor,
          fontSize: 30,
          height: fontHeight,
        ),
      ),
    );
  }
}
