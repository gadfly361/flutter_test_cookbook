import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:ftc/main.dart';

void main() {
  testWidgets("How do I test for an exception?", (WidgetTester tester) async {
    await tester.pumpWidget(MyApp());

    Finder exceptionButtonFinder = find.byType(RaisedButton).at(0);
    Finder customExceptionButtonFinder = find.byType(RaisedButton).at(1);

    await tester.tap(exceptionButtonFinder);
    Exception exception = tester.takeException();
    expect(exception, isException);

    await tester.tap(customExceptionButtonFinder);
    Exception customException = tester.takeException();
    expect(customException, isInstanceOf<MyCustomException>());
  });
}
