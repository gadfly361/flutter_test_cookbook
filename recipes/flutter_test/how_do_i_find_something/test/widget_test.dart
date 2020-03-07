import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:ftc/main.dart';

void main() {
  testWidgets('how do i find something?', (WidgetTester tester) async {
    await tester.pumpWidget(MyApp());

    // Let's find a widget by its type
    Finder raisedButtonFinder = find.byType(RaisedButton);
    expect(raisedButtonFinder, findsOneWidget);

    // Let's find a specific string of text
    Finder textFinder = find.text("we will find this by searching for text");
    expect(textFinder, findsOneWidget);

    // Let's find a widget by its key
    Finder keyFinder = find.byKey(Key("mykey"));
    expect(keyFinder, findsOneWidget);
  });
}
