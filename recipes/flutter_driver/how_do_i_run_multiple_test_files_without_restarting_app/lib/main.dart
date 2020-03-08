import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Column(children: [
          Text("Suite 1 will check this"),
          Text("Suite 2 will check this"),
        ]),
      ),
    );
  }
}
