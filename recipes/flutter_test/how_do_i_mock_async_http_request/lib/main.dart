import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() => runApp(MyApp());

http.Client httpClient = http.Client();

class MyApp extends StatelessWidget {
  MyApp();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Body(),
      ),
    );
  }
}

class Body extends StatefulWidget {
  @override
  BodyState createState() => BodyState();
}

class BodyState extends State<Body> {
  Todo todo;

  Future<void> asyncOnPressed() async {
    http.Response response =
        await httpClient.get('https://jsonplaceholder.typicode.com/todos/1');
    setState(() {
      todo = Todo.fromJson(jsonDecode(response.body));
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        RaisedButton(
          child: Text('Fetch todo'),
          onPressed: asyncOnPressed,
        ),
        SizedBox(
          height: 16,
        ),
        todo == null
            ? Container()
            : Text('Todo: ${todo.title}', key: Key("todo-${todo.id}")),
      ],
    );
  }
}

class Todo {
  final String title;
  final int id;

  Todo({
    @required this.title,
    @required this.id,
  });

  Todo.fromJson(Map<String, dynamic> json)
      : title = json['title'],
        id = json['id'];
}
