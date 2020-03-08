# Question

How do I open a [Drawer](https://api.flutter.dev/flutter/material/Drawer-class.html)?

# Answer

There are several methods to open a Drawer:

a) Open Drawer by tapping the menu icon in the Appbar
b) Open Drawer by using scaffoldKey
c) Open Drawer by using a BuildContext and finding a Scaffold with Scaffold.of
d) Open Drawer by swiping from the left edge

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

GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        key: scaffoldKey,
        appBar: AppBar(),
        drawer: Drawer(),
        body: Body(),
      ),
    );
  }
}

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text("There is a drawer"),
    );
  }
}
```

## 4) Replace the `test/widget_test.dart` file.

Replace the `test/widget_test.dart` file with the following:

```dart
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:ftc/main.dart';

void main() {
  testWidgets('How do I open a Drawer?', (WidgetTester tester) async {
    await tester.pumpWidget(MyApp());

    Finder drawerFinder = find.byType(Drawer);

    expect(drawerFinder, findsNothing);

    //
    // Method a)
    //

    // open Drawer by tapping the menu icon in the Appbar
    Finder menuIconFinder = find.byIcon(Icons.menu);
    await tester.tap(menuIconFinder);
    await tester.pumpAndSettle();

    // confirm that the Drawer is open
    expect(drawerFinder, findsOneWidget);

    // close Drawer
    Navigator.of(tester.element(drawerFinder)).pop();
    await tester.pumpAndSettle();
    expect(drawerFinder, findsNothing);

    //
    // Method b)
    //

    // open Drawer by using scaffoldKey
    scaffoldKey.currentState.openDrawer();
    await tester.pumpAndSettle();

    // confirm that the Drawer is open
    expect(drawerFinder, findsOneWidget);

    // close Drawer
    Navigator.of(tester.element(drawerFinder)).pop();
    await tester.pumpAndSettle();
    expect(drawerFinder, findsNothing);

    //
    // Method c)
    //

    // open Drawer by using a BuildContext and finding a Scaffold with Scaffold.of
    Finder bodyFinder = find.byType(Body);
    Scaffold.of(tester.element(bodyFinder)).openDrawer();
    await tester.pumpAndSettle();

    // confirm that the Drawer is open
    expect(drawerFinder, findsOneWidget);

    // close Drawer
    Navigator.of(tester.element(drawerFinder)).pop();
    await tester.pumpAndSettle();
    expect(drawerFinder, findsNothing);

    //
    // Method d)
    //

    // open Drawer by swiping from the left edge
    await tester.dragFrom(Offset(0, 100), Offset(300, 100));
    await tester.pumpAndSettle();

    // confirm that the Drawer is open
    expect(drawerFinder, findsOneWidget);

    // close Drawer
    Navigator.of(tester.element(drawerFinder)).pop();
    await tester.pumpAndSettle();
    expect(drawerFinder, findsNothing);
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

[✓] Connected device (1 available)
    • iPhone 8 • AD7A90EB-5E73-427E-B9B7-DD3B07E2FEF1 • ios • com.apple.CoreSimulator.SimRuntime.iOS-13-3 (simulator)

• No issues found!
```