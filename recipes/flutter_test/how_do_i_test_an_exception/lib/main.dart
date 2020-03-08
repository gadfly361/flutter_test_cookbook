import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Column(children: [
          RaisedButton(
            child: Text("Throw Exception"),
            onPressed: () {
              throw Exception();
            },
          ),
          RaisedButton(
            child: Text("Throw MyCustomException"),
            onPressed: () {
              throw MyCustomException();
            },
          ),
        ]),
      ),
    );
  }
}

class MyCustomException implements Exception {
  MyCustomException();
}
