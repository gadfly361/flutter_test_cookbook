import 'package:flutter_test/flutter_test.dart';
import 'package:ftc/main.dart';
import 'dart:io';

void main() async {
  testWidgets("How do I run a script?", (WidgetTester tester) async {
    await tester.pumpWidget(MyApp());

    // Running a script inside of flutter_test is different than with flutter_driver.
    // With flutter_test, we need to:
    // a) use tester.runAsync, and
    // b) write the path of the script from the perspective of this file
    ProcessResult result = await tester.runAsync(() async {
      return await Process.run('../echo.sh', ['1']);
    });

    //Note: echo appends a newline to the result
    expect(result.stdout, '1\n');
  });
}
