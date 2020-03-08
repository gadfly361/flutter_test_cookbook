# Question

How do I mock [shared_preferences](https://pub.dev/packages/shared_preferences)?

# Answer

There are a few subtle things that can go wrong when testing shared_preferences.  

a) If you are grabbing a value from shared_preferences during `initState`, then there is the need for an extra `pump` when testing. 
b) If you try to get shared_preferences in your main file before your call to `runApp`, you may experience an error.  If so, you will need to add a call to [WidgetsFlutterBinding.ensureInitialized](https://api.flutter.dev/flutter/widgets/WidgetsFlutterBinding/ensureInitialized.html) (as well as [TestWidgetsFlutterBinding.ensureInitialized](https://api.flutter.dev/flutter/flutter_test/TestWidgetsFlutterBinding/ensureInitialized.html) to your tests).

This recipe covers a).   

## 1) Create a flutter application.

```sh
flutter create ftc
cd ftc
```

## 2) Add shared_preferences to your `pubspec.yaml` file

```yaml
dependencies:
  flutter:
    sdk: flutter
  shared_preferences: 0.5.6+2
```

Then get the dependencies by running:

```sh
flutter packages get
```

## 3) Replace the `lib/main.dart` file

Replace the `lib/main.dart` file with the following:

```dart
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  int spValue = 0;

  @override
  void initState() {
    super.initState();
    SharedPreferences.getInstance().then((SharedPreferences prefs) {
      setState(() {
        spValue = prefs.getInt("myValue") ?? 0;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text("The shared_preferences value is: $spValue"),
    );
  }
}
```

## 4) Replace the `test/widget_test.dart` file.

Replace the `test/widget_test.dart` file with the following:

```dart
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:ftc/main.dart';

void main() {
  // If you're running a test, you can call the `TestWidgetsFlutterBinding.ensureInitialized()` as the first line in your test's `main()` method to initialize the binding.
  TestWidgetsFlutterBinding.ensureInitialized();

  testWidgets(
      "The value displayed should fallback to 0 if the shared_preferences value isn't mocked",
      (WidgetTester tester) async {
    await tester.pumpWidget(MyApp());

    expect(find.text("The shared_preferences value is: 0"), findsOneWidget);
  });

  testWidgets(
      "The value displayed should be updated when mocking initial shared_preferences values",
      (WidgetTester tester) async {
    // We are setting the initial value to 10
    SharedPreferences.setMockInitialValues({"myValue": 10});

    // then we are pumping our top-level widget
    await tester.pumpWidget(MyApp());

    // However, because we are grabbing shared_preferences value in our initState, and then using setState
    // to set the value displayed in our app, we need to pump one more time!
    await tester.pump();

    // Then we expect out mock value to be displayed
    expect(find.text("The shared_preferences value is: 10"), findsOneWidget);
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
00:06 +1: All tests passed!  
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

[✓] Connected device (1 available)
    • iPhone 8 • AD7A90EB-5E73-427E-B9B7-DD3B07E2FEF1 • ios • com.apple.CoreSimulator.SimRuntime.iOS-13-3 (simulator)

• No issues found!
```
