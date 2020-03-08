# Question

How do I test an animation?

# Answer

In this example, we will be taking a box, with a height of 0, and growing it to 100 over the course of 1000 milliseconds. Since flutter test doesn't automatically pump the widget, we can do it manually and check the box size along the way.

## 1) Create a flutter application.

```sh
flutter create ftc
cd ftc
```

## 2) Get dependencies

```sh
flutter packages get
```

## 3) Replace the `lib/main.dart` file

Replace the `lib/main.dart` file with the following:

```dart
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  MyApp();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Body(),
        ),
      ),
    );
  }
}

class Body extends StatefulWidget {
  Body();

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> with SingleTickerProviderStateMixin {
  Animation<double> animation;
  AnimationController controller;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 1000),
    );
    animation = Tween<double>(begin: 0, end: 100).animate(controller);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        RaisedButton(
          onPressed: () {
            controller.forward();
          },
          child: Text("Start animation"),
        ),
        AnimatedBuilder(
          animation: animation,
          builder: (BuildContext _context, _child) {
            return Container(
              key: Key("animatedBox"),
              height: animation.value,
              width: animation.value,
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.black,
                  width: 2,
                ),
              ),
            );
          },
        )
      ],
    );
  }
}
```

## 4) Replace the `test/widget_test.dart` file.

Replace the `test/widget_test.dart` file with the following:

```dart
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ftc/main.dart';

void main() {
  testWidgets("How do I test an animation?", (WidgetTester tester) async {
    await tester.pumpWidget(MyApp());

    Finder startAnimationFinder = find.text("Start animation");
    Finder animatedBoxFinder = find.byKey(Key("animatedBox"));

    expect(startAnimationFinder, findsOneWidget);
    expect(animatedBoxFinder, findsOneWidget);

    // The box starts off with a height of 0
    RenderConstrainedBox animatedBox = tester.renderObject(animatedBoxFinder);
    expect(animatedBox.size.height, 0);

    // Once we start the animation
    await tester.tap(startAnimationFinder);
    await tester.pump();

    // and wait 100 milliseconds
    await tester.pump(Duration(milliseconds: 100));
    // we expect the height to grow from 0 to 10
    expect(animatedBox.size.height, 10);

    // after another 100 milliseconds it should grow to 20
    await tester.pump(Duration(milliseconds: 100));
    expect(animatedBox.size.height, 20);

    await tester.pump(Duration(milliseconds: 100));
    // and then 30
    expect(animatedBox.size.height, 30);

    await tester.pump(Duration(milliseconds: 100));
    // and then 40
    expect(animatedBox.size.height, 40);

    await tester.pump(Duration(milliseconds: 100));
    // and then 50
    expect(animatedBox.size.height, 50);

    await tester.pump(Duration(milliseconds: 500));
    // and then after another 500 milliseconds, the animation should be 
    // complete and be a total height of 100
    expect(animatedBox.size.height, 100);
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
[✓] Flutter (Channel stable, v1.12.13+hotfix.5, on Mac OS X 10.15.2 19C57, locale en-US)
    • Flutter version 1.12.13+hotfix.5 at /Users/matthew/gadfly/flutter_versions/flutter_1.12.13+hotfix.5
    • Framework revision 27321ebbad (3 months ago), 2019-12-10 18:15:01 -0800
    • Engine revision 2994f7e1e6
    • Dart version 2.7.0

[✓] Android toolchain - develop for Android devices (Android SDK version 28.0.3)
    • Android SDK at /Users/matthew/Library/Android/sdk
    • Android NDK location not configured (optional; useful for native profiling support)
    • Platform android-29, build-tools 28.0.3
    • Java binary at: /Applications/Android Studio.app/Contents/jre/jdk/Contents/Home/bin/java
    • Java version OpenJDK Runtime Environment (build 1.8.0_152-release-1343-b01)
    • All Android licenses accepted.

[✓] Xcode - develop for iOS and macOS (Xcode 11.3.1)
    • Xcode at /Applications/Xcode.app/Contents/Developer
    • Xcode 11.3.1, Build version 11C504
    • CocoaPods version 1.8.4

[✓] Android Studio (version 3.4)
    • Android Studio at /Applications/Android Studio.app/Contents
    • Flutter plugin version 35.2.1
    • Dart plugin version 183.6270
    • Java version OpenJDK Runtime Environment (build 1.8.0_152-release-1343-b01)

[✓] IntelliJ IDEA Community Edition (version 2019.3.3)
    • IntelliJ at /Applications/IntelliJ IDEA CE.app
    • Flutter plugin version 44.0.3
    • Dart plugin version 193.6494.35

[✓] VS Code (version 1.41.1)
    • VS Code at /Applications/Visual Studio Code.app/Contents
    • Flutter extension version 3.4.1

[!] Connected device
    • Device 9C251FFBA00174 is not authorized.
      You might need to check your device for an authorization dialog.

! Doctor found issues in 1 category.
```
