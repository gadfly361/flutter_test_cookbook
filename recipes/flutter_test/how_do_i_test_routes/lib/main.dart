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
        "/page3": (BuildContext context) => Page3(),
      },
    );
  }
}

class Page1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Page 1"),
      ),
      body: Column(
        children: <Widget>[
          RaisedButton(
            onPressed: () => Navigator.of(context).pushNamed("/page2"),
            child: Text("pushNamed to page2"),
          ),
          RaisedButton(
            onPressed: () =>
                Navigator.of(context).pushReplacementNamed("/page2"),
            child: Text("pushReplacementNamed to page2"),
          )
        ],
      ),
    );
  }
}

class Page2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Page 2"),
      ),
      body: Column(
        children: <Widget>[
          RaisedButton(
            onPressed: () => Navigator.of(context).pushNamed("/page3"),
            child: Text("pushNamed to page3"),
          ),
        ],
      ),
    );
  }
}

class Page3 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Page 3"),
      ),
      body: Column(
        children: <Widget>[
          RaisedButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text("pop"),
          ),
          RaisedButton(
            onPressed: () => Navigator.of(context).popUntil((Route route) {
              return route.settings.name == "/page1";
            }),
            child: Text("popUntil page1"),
          )
        ],
      ),
    );
  }
}
