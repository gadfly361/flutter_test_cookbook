# Question

How do I run a [flutter driver](https://api.flutter.dev/flutter/flutter_driver/flutter_driver-library.html) test?

# Answer

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
        body: Center(
          child: Text("Hello World"),
        ),
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

void main() {
  // Add the following to leverage flutter_driver
  enableFlutterDriverExtension();

  app.main();
}
```

[Reference](https://flutter.dev/docs/cookbook/testing/integration/introduction#4-instrument-the-app)

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

  test("'Hello World' text exists", () async {
    SerializableFinder helloWorldTextFinder = find.text("Hello World");

    await driver.waitFor(helloWorldTextFinder);
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
 ├─Assembling Flutter resources...                           7.9s
 └─Compiling, linking and signing...                         4.1s
Xcode build done.                                           13.2s
flutter: Observatory listening on http://127.0.0.1:60787/uPVFLEOkdqo=/
00:00 +0: (setUpAll)

[info ] FlutterDriver: Connecting to Flutter application at http://127.0.0.1:60787/uPVFLEOkdqo=/
[trace] FlutterDriver: Isolate found with number: 4366875479017451
[trace] FlutterDriver: Isolate is paused at start.
[trace] FlutterDriver: Attempting to resume isolate
[trace] FlutterDriver: Waiting for service extension
[info ] FlutterDriver: Connected to Flutter application.
00:00 +0: 'Hello World' text exists

00:00 +1: (tearDownAll)

00:00 +1: All tests passed!

Stopping application instance.
```

## Output of running `flutter doctor -v`

```sh
$ flutter doctor -v[✓] Flutter (Channel stable, v1.12.13+hotfix.5, on Mac OS X 10.15.2
    19C57, locale en-US)
    • Flutter version 1.12.13+hotfix.5 at
      /Users/matthew/gadfly/flutter_versions/flutter_1.12.13+hotfix.5
    • Framework revision 27321ebbad (7 weeks ago), 2019-12-10 18:15:01
      -0800
    • Engine revision 2994f7e1e6
    • Dart version 2.7.0

[✓] Android toolchain - develop for Android devices (Android SDK
    version 28.0.3)
    • Android SDK at /Users/matthew/Library/Android/sdk
    • Android NDK location not configured (optional; useful for native
      profiling support)
    • Platform android-29, build-tools 28.0.3
    • Java binary at: /Applications/Android
      Studio.app/Contents/jre/jdk/Contents/Home/bin/java
    • Java version OpenJDK Runtime Environment (build
      1.8.0_152-release-1343-b01)
    • All Android licenses accepted.

[✓] Xcode - develop for iOS and macOS (Xcode 11.3.1)
    • Xcode at /Applications/Xcode.app/Contents/Developer
    • Xcode 11.3.1, Build version 11C504
    • CocoaPods version 1.8.4

[✓] Android Studio (version 3.4)
    • Android Studio at /Applications/Android Studio.app/Contents
    • Flutter plugin version 35.2.1
    • Dart plugin version 183.6270
    • Java version OpenJDK Runtime Environment (build
      1.8.0_152-release-1343-b01)

[✓] IntelliJ IDEA Community Edition (version 2019.3.2)
    • IntelliJ at /Applications/IntelliJ IDEA CE.app
    • Flutter plugin version 42.1.4
    • Dart plugin version 193.6015.9

[✓] VS Code (version 1.40.1)
    • VS Code at /Applications/Visual Studio Code.app/Contents
    • Flutter extension version 3.4.1

[✓] Connected device (1 available)
    • iPhone 8 • AD7A90EB-5E73-427E-B9B7-DD3B07E2FEF1 • ios •
      com.apple.CoreSimulator.SimRuntime.iOS-13-3 (simulator)

• No issues found!
```
