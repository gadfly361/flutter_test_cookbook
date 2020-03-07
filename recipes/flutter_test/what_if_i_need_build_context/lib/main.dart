import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: "/page1",
      routes: {
        "/page1": (BuildContext context) => Page1(),
        "/page2": (BuildContext context) => Page2(),
      },
    );
  }
}

class Page1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text("Page 1")),
    );
  }
}

GlobalKey<ScaffoldState> page2ScaffoldKey = GlobalKey<ScaffoldState>();

class Page2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: page2ScaffoldKey,
      body: Center(child: Text("Page 2")),
    );
  }
}
