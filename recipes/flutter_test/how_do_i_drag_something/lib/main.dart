import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(),
        body: Body(),
      ),
    );
  }
}

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  bool isDragAccepted = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Draggable(
          feedback: Container(
            height: 100,
            width: 100,
            decoration: BoxDecoration(
              border: Border.all(width: 2.0, color: Colors.black),
            ),
          ),
          child: Container(
            height: 100,
            width: 100,
            decoration: BoxDecoration(
              border: Border.all(width: 2.0, color: Colors.black),
            ),
            child: Center(
              child: Text("Draggable"),
            ),
          ),
          childWhenDragging: Container(
            height: 100,
            width: 100,
            decoration: BoxDecoration(
              border: Border.all(width: 2.0, color: Colors.grey),
            ),
          ),
        ),
        DragTarget(
          onAccept: (data) {
            setState(() {
              isDragAccepted = true;
            });
          },
          builder: (BuildContext context, candidateData, rejectedData) {
            return Container(
              height: 100,
              width: 100,
              decoration: BoxDecoration(
                border: Border.all(
                    width: 2.0,
                    color: isDragAccepted ? Colors.green : Colors.black),
              ),
              child: Center(
                child:
                    Text(isDragAccepted ? "Successful drag!" : "Drag Target"),
              ),
            );
          },
        ),
      ],
    );
  }
}
