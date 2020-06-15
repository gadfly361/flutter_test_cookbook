# Question

How do I mock an async http request?

# Answer

We will be using the [http](https://pub.dev/packages/http) package to make an http request, and [mockito](https://pub.dev/packages/mockito) to mock it.
   

## 1) Create a flutter application.

```sh
flutter create ftc
cd ftc
```

## 2) Add http and mockito to your `pubspec.yaml` file

```yaml
dependencies:
  flutter:
    sdk: flutter
  http: 0.12.1

dev_dependencies:
  flutter_test:
    sdk: flutter
  mockito: 4.1.1
```

Then get the dependencies by running:

```sh
flutter packages get
```

## 3) Replace the `lib/main.dart` file

Replace the `lib/main.dart` file with the following:

```dart
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() => runApp(MyApp());

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
        await http.get('https://jsonplaceholder.typicode.com/todos/1');
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
```

## 4) Replace the `test/widget_test.dart` file.

Replace the `test/widget_test.dart` file with the following:

```dart
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:ftc/main.dart';
import 'package:mockito/mockito.dart';

class MockAppHttpClient extends Mock implements http.Client {}

const String applicationJson = 'application/json; charset=utf-8';

void main() {
  testWidgets("A todo item should appear on the screen",
      (WidgetTester tester) async {
    await tester.pumpWidget(MyApp());

    // A todo should not be shown when the page loads
    expect(find.byKey(Key('todo-1')), findsNothing);

    // Use mockito to mock an http request's response
    httpClient = MockAppHttpClient();
    when(
      httpClient.get(
        'https://jsonplaceholder.typicode.com/todos/1',
      ),
    ).thenAnswer((_) async {
      return http.Response(
          jsonEncode({'id': 1, 'title': 'Do the laundry'}), 200,
          headers: {'content-type': 'application/json; charset=utf-8'});
    });

    // Make the http request
    //
    // IMPORTANT NOTE: We are *not* tapping the [RaisedButton] directly.
    // Instead, we are finding the state object, and then running the asyncOnPressed function
    // which is passed to the onPressed of the RaisedButton. If we were to tap the RaisedButton directly,
    // the test wouldn't wait properly because the onPressed signature is a VoidCallback instead
    // of an AsyncCallback.
    await tester.state<BodyState>(find.byType(Body)).asyncOnPressed();
    await tester.pump();

    // A todo should be shown after the http request receives a response
    expect(find.byKey(Key('todo-1')), findsOneWidget);
  });
}
```


## 5) Run the flutter tests

```sh
flutter test
```

# Run tests from example code in cookbook itself

If you have cloned [flutter_test_cookbook](https://github.com/gadfly361/flutter_test_cookbook/tree/master) and simply want to run the tests from this recipe, then:

```sh
flutter create .
flutter packages get
flutter test
```

# Outputs when recipe was made / updated

## Output of running flutter tests

```sh
$ flutter test 
00:02 +1: All tests passed!
```

## Output of running `flutter doctor -v`

```sh
$ flutter doctor -v
[✓] Flutter (Channel stable, v1.17.2, on Mac OS X 10.15.5 19F101, locale en-US)
    • Flutter version 1.17.2 at /Users/matthew/gadfly/flutter_versions/flutter_1.17.2
    • Framework revision 5f21edf8b6 (2 weeks ago), 2020-05-28 12:44:12 -0700
    • Engine revision b851c71829
    • Dart version 2.8.3

[✓] Android toolchain - develop for Android devices (Android SDK version 28.0.3)
    • Android SDK at /Users/matthew/Library/Android/sdk
    • Platform android-29, build-tools 28.0.3
    • Java binary at: /Applications/Android Studio.app/Contents/jre/jdk/Contents/Home/bin/java
    • Java version OpenJDK Runtime Environment (build 1.8.0_152-release-1343-b01)
    • All Android licenses accepted.

[✓] Xcode - develop for iOS and macOS (Xcode 11.5)
    • Xcode at /Applications/Xcode.app/Contents/Developer
    • Xcode 11.5, Build version 11E608c
    • CocoaPods version 1.9.1

[✓] Android Studio (version 3.4)
    • Android Studio at /Applications/Android Studio.app/Contents
    • Flutter plugin version 35.2.1
    • Dart plugin version 183.6270
    • Java version OpenJDK Runtime Environment (build 1.8.0_152-release-1343-b01)

[!] IntelliJ IDEA Ultimate Edition (version 2020.1.2)
    • IntelliJ at /Applications/IntelliJ IDEA.app
    ✗ Flutter plugin not installed; this adds Flutter specific functionality.
    ✗ Dart plugin not installed; this adds Dart specific functionality.
    • For information about installing plugins, see
      https://flutter.dev/intellij-setup/#installing-the-plugins

[✓] VS Code (version 1.45.1)
    • VS Code at /Applications/Visual Studio Code.app/Contents
    • Flutter extension version 3.10.2

[✓] Connected device (1 available)
    • iPhone 8 • C9868AFF-E4CE-4C0B-AC2B-9600508F6C1F • ios • com.apple.CoreSimulator.SimRuntime.iOS-13-5 (simulator)

! Doctor found issues in 1 category.
```
