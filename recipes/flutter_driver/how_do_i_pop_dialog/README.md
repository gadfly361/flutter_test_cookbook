# Question

How do I dismiss a [Dialog](https://api.flutter.dev/flutter/material/Dialog-class.html) that doesn't have an explicit widget to do so?

# Answer

You may find yourself creating a Dialog that relies on a user pressing on the [ModalBarrier](https://api.flutter.dev/flutter/widgets/ModalBarrier-class.html) to dismiss it (as opposed to them clicking on an explicit widget like a button).

In this situation, we can use the [Navigator](https://api.flutter.dev/flutter/dart-html/Navigator-class.html) to pop the Dialog from the stack (i.e. dismiss the Dialog).

To do so, we can to take advantage of the [DataHandler](https://api.flutter.dev/flutter/flutter_driver_extension/DataHandler.html) found in the [enableFlutterDriverExtension](https://api.flutter.dev/flutter/flutter_driver_extension/enableFlutterDriverExtension.html) function.

## 1) Create a flutter application.

```sh
flutter create ftc
cd ftc
```

## 2) Add [flutter_driver](https://api.flutter.dev/flutter/flutter_driver/flutter_driver-library.html) and [test](https://pub.dev/packages/test) to your `pubspec.yaml` file.

```yaml
dev_dependencies:
  flutter_driver:
    sdk: flutter
  test: any
```

Then get the dependencies by running:

```sh
flutter packages get
```

## 3) Replace the `lib/main.dart` file

Replace the `lib/main.dart` file with the following:

```dart
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
```

## 4) Create a `test_driver` directory.

```sh
mkdir test_driver
cd test_driver
```

## 5) Add an `example.dart` file.

Create a `test_driver/example.dart` file, and add the following to it:

```dart
import 'package:flutter_driver/driver_extension.dart';
import 'package:ftc/main.dart' as app;

Future<String> dataHandler(String message) async {
  // We are using the data handler to execute a pop side-effect
  if (message == "pop") {
    app.appNavigatorKey.currentState.pop();
  }

  return null;
}

void main() {
  enableFlutterDriverExtension(
    // we are adding the dataHandler here
    handler: dataHandler,
  );

  app.main();
}
```

## 6) Add an `example_test.dart` file.

Create a `test_driver/example_test.dart` file, and add the following to it:

```dart
import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

void main() {
  FlutterDriver driver;

  setUpAll(() async {
    driver = await FlutterDriver.connect();
  });

  tearDownAll(() async {
    if (driver != null) {
      await driver.close();
    }
  });

  test("let's open a dialog and then close it", () async {
    SerializableFinder raisedButtonFinder = find.byType("RaisedButton");
    await driver.waitFor(raisedButtonFinder);
    // tapping the button opens the Dialog
    await driver.tap(raisedButtonFinder);

    // make sure the the Dialog is open
    SerializableFinder dialogFinder = find.byType("Dialog");
    await driver.waitFor(dialogFinder);

    // now, let's close the dialog using the dataHandler we defined in
    // our [enableFlutterDriverExtension] function.
    await driver.requestData("pop");
    
   // finally, let's wait to make sure the Dialog is gone
    await driver.waitForAbsent(dialogFinder);
  });
}
```

## 7) Run the flutter driver tests

```sh
flutter driver -t test_driver/example.dart
```

# Run tests from example code in cookbook itself

If you have cloned [flutter_test_cookbook](https://github.com/gadfly361/flutter_test_cookbook/tree/master) and simply want to run the tests from this recipe, then:

```sh
flutter create .
flutter packages get
flutter driver -t test_driver/example.dart
```

# Outputs when recipe was made / updated

## Output of running flutter driver tests

```sh
$ flutter driver -t test_driver/example.dart 
Using device iPhone 8.
Starting application: test_driver/example.dart
Running Xcode build...                                                  
 ├─Assembling Flutter resources...                           2.6s
 └─Compiling, linking and signing...                         2.9s
Xcode build done.                                            6.6s
flutter: Observatory listening on http://127.0.0.1:51796/uIFIjnNgNMs=/
00:00 +0: (setUpAll)

[info ] FlutterDriver: Connecting to Flutter application at http://127.0.0.1:51796/uIFIjnNgNMs=/
[trace] FlutterDriver: Isolate found with number: 491196511285567
[trace] FlutterDriver: Isolate is paused at start.
[trace] FlutterDriver: Attempting to resume isolate
[trace] FlutterDriver: Waiting for service extension
[info ] FlutterDriver: Connected to Flutter application.
00:00 +0: let's open a dialog and then close it

00:00 +1: (tearDownAll)

00:00 +1: All tests passed!

Stopping application instance.
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
