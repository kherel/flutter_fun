import 'package:flutter/material.dart';

import 'glitch.dart';

class GlitchPageScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, this.title}) : super(key: key);

  final String? title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
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
        title: GlithEffect(child: Text(widget.title!)),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            SizedBox(height: 100),
            GlithEffect(
              child: Image.asset(
                'assets/kherel.jpeg',
                width: 150,
              ),
            ),
            SizedBox(height: 100),
            GlithEffect(
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
            SizedBox(height: 50),
            GlithEffect(
              child: ElevatedButton(
                child: Icon(Icons.add),
                onPressed: _incrementCounter,
                //   RoundedRectangleBorder(
                //   borderRadius: BorderRadius.circular(30.0),
                // ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
