part of 'calculator.dart';

class _Display extends StatefulWidget {
  const _Display({super.key});

  @override
  State<_Display> createState() => __DisplayState();
}

class __DisplayState extends State<_Display> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const SizedBox(),
        const Text(
          '(((())))',
          style: TextStyle(
            fontSize: 22,
            color: Colors.white,
          ),
        ),
        Expanded(
          child: Stack(
            children: const [
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Text(
                  '',
                  style: TextStyle(
                    fontSize: 60,
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.right,
                  textScaleFactor: 1,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
