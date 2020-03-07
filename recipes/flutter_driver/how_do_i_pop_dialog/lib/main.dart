import 'package:flutter/material.dart';

void main() => runApp(MyApp());

GlobalKey<NavigatorState> appNavigatorKey = GlobalKey<NavigatorState>();

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // Note: we are adding a navigatorKey here
      navigatorKey: appNavigatorKey,
      home: Scaffold(
        body: Body(),
      ),
    );
  }
}

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: RaisedButton(
        child: Text("Open Dialog"),
        onPressed: () {
          showDialog(
            context: context,
            builder: (BuildContext _context) {
              return Dialog(
                child: SizedBox(
                  height: 100,
                  child: Center(
                    child: Text("This is a Dialog"),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
