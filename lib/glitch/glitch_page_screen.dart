import 'package:flutter/material.dart';

import 'glitch.dart';

class GlitchPageScreen extends StatelessWidget {
  const GlitchPageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const GlithEffect(
          child: Text(
            'Flutter Demo Home Page',
          ),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            const SizedBox(height: 100),
            GlithEffect(
              child: Image.asset(
                'assets/kherel.jpeg',
                width: 150,
              ),
            ),
            const SizedBox(height: 100),
            const GlithEffect(
              child: Text(
                'You have pushed the button this many times:',
              ),
            ),
            GlithEffect(
              child: Text(
                '$_counter',
                style: Theme.of(context).textTheme.headline4!.copyWith(
                      fontSize: 60,
                    ),
              ),
            ),
            const SizedBox(height: 50),
            GlithEffect(
              child: ElevatedButton(
                onPressed: _incrementCounter,
                child: const Icon(Icons.add),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
