import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Column(
          children: <Widget>[
            RaisedButton(
              onPressed: () => print("rasied button was clicked"),
              child: Text("we will find this by searching for a type"),
            ),
            Text(
              "we will find this by searching for text",
            ),
            Text(
              "will will find this by searching for a key",
              key: Key("mykey"),
            ),
          ],
        ),
      ),
    );
  }
}
