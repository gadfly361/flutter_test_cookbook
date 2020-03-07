# Question

What do I do if I need a [BuildContext](https://api.flutter.dev/flutter/widgets/BuildContext-class.html)?

# Answer

There are several reasons we might _want_ to use a BuildContext in our tests (it is a matter of opinion if we actually should).

There are two main methods to get a BuildContext when using flutter_test.

a) Finding an [Element](https://api.flutter.dev/flutter/widgets/Element-class.html) and taking advantage of the fact that [an Element can be used as a BuildContext](https://www.reddit.com/r/Flutter/comments/bcmj70/please_tell_me_simply_what_is_context_and_build/eldf63d?utm_source=share&utm_medium=web2x)

b) Using a [GlobalKey](https://api.flutter.dev/flutter/widgets/GlobalKey-class.html)

For the sake of this recipe, we are going to use a _contrived_ example.  We have two pages, Page1 and Page2, and we want to navigate between them in our tests using a [Navigator](https://api.flutter.dev/flutter/dart-html/Navigator-class.html).

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
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: "/page1",
      routes: {
        "/page1": (BuildContext context) => Page1(),
        "/page2": (BuildContext context) => Page2(),
      },
    );
  }
}

class Page1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text("Page 1")),
    );
  }
}

class Page2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text("Page 2")),
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
  testWidgets("What if I need a build context?", (WidgetTester tester) async {
    await tester.pumpWidget(MyApp());
    Finder page1Finder = find.byType(Page1);
    Finder page2Finder = find.byType(Page2);

    // Since the initial route was for /page1
    // we expect to see a [Page1] widget and not a [Page2] widget
    expect(page1Finder, findsOneWidget);
    expect(page2Finder, findsNothing);

    //
    // Method a)
    //

    // get [BuildContext] from an element
    BuildContext page1BuildContext = tester.element(page1Finder);

    // find the closest [Navigator] (which is made available because of [MaterialApp])
    // and pushNamed to /page2
    Navigator.of(page1BuildContext).pushNamed("/page2");

    // Note, since we are using a [MaterialApp] and its named routes use the [MaterialPageRoute],
    // there is a transition of 300 ms
    // https://github.com/flutter/flutter/blob/e58dc16d7bec7199190f1408667e24e38328cc3b/packages/flutter/lib/src/material/page.dart#L61
    // ... so we will need to pump until that transition has settled
    await tester.pumpAndSettle();

    // We now expect to be on [Page2]
    expect(page1Finder, findsNothing);
    expect(page2Finder, findsOneWidget);

    //
    // Method b)
    //

    // get [BuildContext] from a [GlobalKey]
    BuildContext page2BuildContext = page2ScaffoldKey.currentContext;

    // Let's navigate back to [Page1]
    Navigator.of(page2BuildContext).pushNamed("/page1");
    await tester.pumpAndSettle();

    // We now expect to be on [Page1] again
    expect(page1Finder, findsOneWidget);
    expect(page2Finder, findsNothing);
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
    ! No devices available

! Doctor found issues in 1 category.
```
