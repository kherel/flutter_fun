part of 'calculator.dart';

class _Keyboard extends StatelessWidget {
  const _Keyboard();

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var gap = SizedBox(height: (width - (width / 375 * 75 * 4) - 30) / 3);

    return Column(
      children: [
        _buildRow(const [
          _Button.light(value: 'C', fontHeight: 1.2),
          _Button.light(value: '±'),
          _Button.orange(value: '(', padding: EdgeInsets.only(right: 5)),
          _Button.orange(value: ')', padding: EdgeInsets.only(left: 5)),
        ]),
        gap,
        _buildRow(const [
          _Button.dark(value: '7'),
          _Button.dark(value: '8'),
          _Button.dark(value: '9'),
          _Button.orange(value: '÷'),
        ]),
        gap,
        _buildRow(const [
          _Button.dark(value: '4'),
          _Button.dark(value: '5'),
          _Button.dark(value: '6'),
          _Button.orange(value: '×'),
        ]),
        gap,
        _buildRow(const [
          _Button.dark(value: '1'),
          _Button.dark(value: '2'),
          _Button.dark(value: '3'),
          _Button.orange(value: '-'),
        ]),
        gap,
        _buildRow(const [
          _Button.dark(value: '0'),
          _Button.dark(value: ','),
          _Button.orange(value: '='),
          _Button.orange(value: '+'),
        ]),
      ],
    );
  }

  Row _buildRow(List<Widget> rowChildren) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: rowChildren,
    );
  }
}
