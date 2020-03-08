# Question

How do I run multiple test files without restarting the app?

# Answer

We are going to start an app, record its uri, then run our test suites referencing an existing app at the uri.     

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

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Column(children: [
          Text("Suite 1 will check this"),
          Text("Suite 2 will check this"),
        ]),
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

## 5) Add a `start_app.dart` file.

Create a `test_driver/start_app.dart` file, and add the following to it:

```dart
import 'package:flutter_driver/driver_extension.dart';
import 'package:ftc/main.dart' as app;

void main() {
  enableFlutterDriverExtension();

  app.main();
}
```

## 6) Add a `suite1.dart` file and a `suite1_test.dart` file

Create a `test_driver/suite1.dart` file, and add the following to it:

```dart
// Note: this is intentionally blank,
// but the existence of this file is still needed
// for flutter drive to run the tests
```

Then create a `test_driver/suite1_test.dart` file, and add the following to it:

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

  test("Suite 1", () async {
    SerializableFinder textFinder = find.text("Suite 1 will check this");

    await driver.waitFor(textFinder);
  });
}
```

## 7) Add a `suite2.dart` file and a `suite2_test.dart` file

Create a `test_driver/suite2.dart` file, and add the following to it:

```dart
// Note: this is intentionally blank,
// but the existence of this file is still needed
// for flutter drive to run the tests
```

Then create a `test_driver/suite2_test.dart` file, and add the following to it:

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

  test("Suite 2", () async {
    SerializableFinder textFinder = find.text("Suite 2 will check this");

    await driver.waitFor(textFinder);
  });
}
```

## 8) Add a `run_all_tests.sh` file

Create a `run_all_tests.sh` file and add the following to it:

```sh
#!/bin/bash

# start the app and write the uri to a file
flutter run --target=test_driver/start_app.dart --vmservice-out-file="test_driver/uri.txt" --start-paused --no-resident

# run the test suites using the uri in the aforementioned file
flutter driver --target=test_driver/suite1.dart --use-existing-app="$(cat test_driver/uri.txt)"
flutter driver --target=test_driver/suite2.dart --use-existing-app="$(cat test_driver/uri.txt)"
```

Then make it executable by running

```sh
chmod +x run_all_tests.sh
```

## 8) Run the flutter driver tests

```sh
./run_all_tests.sh
```

# Run tests from example code in cookbook itself

If you have cloned [flutter_test_cookbook](https://github.com/gadfly361/flutter_test_cookbook/tree/master) and simply want to run the tests from this recipe, then:

```sh
flutter create .
flutter packages get
./run_all_tests.sh
```

# Outputs when recipe was made / updated

## Output of running flutter driver tests

```sh
$ ./run_all_tests.sh 
Launching test_driver/start_app.dart on iPhone 8 in debug mode...
Running Xcode build...                                                  
 ├─Assembling Flutter resources...                           2.6s
 └─Compiling, linking and signing...                         2.9s
Xcode build done.                                            6.7s
Syncing files to device iPhone 8...                                     
 4,776ms (!)                                       
Using device iPhone 8.
Will connect to already running application instance.
00:00 +0: (setUpAll)

[info ] FlutterDriver: Connecting to Flutter application at ws://127.0.0.1:56503/87Z5gLVG5E8=/ws
[trace] FlutterDriver: Isolate found with number: 1576235581101003
[trace] FlutterDriver: Isolate is paused at start.
[trace] FlutterDriver: Attempting to resume isolate
[trace] FlutterDriver: Waiting for service extension
[info ] FlutterDriver: Connected to Flutter application.
00:00 +0: Suite 1

00:00 +1: (tearDownAll)

00:00 +1: All tests passed!

Leaving the application running.
Using device iPhone 8.
Will connect to already running application instance.
00:00 +0: (setUpAll)

[info ] FlutterDriver: Connecting to Flutter application at ws://127.0.0.1:56503/87Z5gLVG5E8=/ws
[trace] FlutterDriver: Isolate found with number: 1576235581101003
[trace] FlutterDriver: Isolate is not paused. Assuming application is ready.
[info ] FlutterDriver: Connected to Flutter application.
00:00 +0: Suite 2

00:00 +1: (tearDownAll)

00:00 +1: All tests passed!

Leaving the application running.
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
