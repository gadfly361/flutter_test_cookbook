# Question

How do I send a keyboard action like `done` or `next`?

# Answer

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
      home: Scaffold(
        body: MyForm(),
      ),
    );
  }
}

class MyForm extends StatefulWidget {
  @override
  _MyFormState createState() => _MyFormState();
}

class _MyFormState extends State<MyForm> {
  // We are creating controllers and focus nodes for our two text fields
  TextEditingController firstNameController;
  FocusNode firstNameFocusNode;

  TextEditingController lastNameController;
  FocusNode lastNameFocusNode;

  @override
  void initState() {
    super.initState();
    firstNameController = TextEditingController();
    firstNameFocusNode = FocusNode();

    lastNameController = TextEditingController();
    lastNameFocusNode = FocusNode();
  }

  // and we are cleaning up after ourselves by disposing the controllers and focus nodes
  @override
  void dispose() {
    firstNameController.dispose();
    firstNameFocusNode.dispose();

    lastNameController.dispose();
    lastNameFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        TextField(
          decoration: InputDecoration(labelText: "First name"),
          textInputAction: TextInputAction.next,
          controller: firstNameController,
          focusNode: firstNameFocusNode,
          // When a user hits 'next' on the keyboard, it will unfocus firstName and focus lastName
          onSubmitted: (String _firstName) {
            firstNameFocusNode.unfocus();
            FocusScope.of(context).requestFocus(lastNameFocusNode);
          },
        ),
        TextField(
          decoration: InputDecoration(labelText: "Last name"),
          textInputAction: TextInputAction.done,
          controller: lastNameController,
          focusNode: lastNameFocusNode,
          // When a user hits 'done' on the keyboard, it will unfocus lastName and then show a SnackBar with the full name
          onSubmitted: (String _lastName) {
            lastNameFocusNode.unfocus();
            Scaffold.of(context).showSnackBar(SnackBar(
              content: Text(
                  "Your name is: ${firstNameController.text} ${lastNameController.text}"),
            ));
          },
        ),
      ],
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
  testWidgets("How do I send a keyboard action?", (WidgetTester tester) async {
    await tester.pumpWidget(MyApp());

    // First, let's confirm we have two TextFields on the page
    Finder firstNameFinder = find.byType(TextField).at(0);
    Finder lastNameFinder = find.byType(TextField).at(1);

    expect(firstNameFinder, findsOneWidget);
    expect(lastNameFinder, findsOneWidget);

    // Next, let's enter our first name
    await tester.showKeyboard(firstNameFinder);
    tester.testTextInput.enterText("John");

    // Tap the 'next' action in the keyboard
    await tester.testTextInput.receiveAction(TextInputAction.next);

    // This should automatically focus the last name
    // which means we don't need to show a new keyboard with a new finder
    tester.testTextInput.enterText("Doe");

    // Tap the 'done' action in the keyboard
    await tester.testTextInput.receiveAction(TextInputAction.done);

    // This should open a SnackBar with the entered name
    await tester.pumpAndSettle();
    expect(find.text("Your name is: John Doe"), findsOneWidget);
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
