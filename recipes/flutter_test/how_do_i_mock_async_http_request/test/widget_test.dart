import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:ftc/main.dart';
import 'package:mockito/mockito.dart';

class MockAppHttpClient extends Mock implements http.Client {}

const String applicationJson = 'application/json; charset=utf-8';

void main() {
  testWidgets("A todo item should appear on the screen",
      (WidgetTester tester) async {
    await tester.pumpWidget(MyApp());

    // A todo should not be shown when the page loads
    expect(find.byKey(Key('todo-1')), findsNothing);

    // Use mockito to mock an http request's response
    httpClient = MockAppHttpClient();
    when(
      httpClient.get(
        'https://jsonplaceholder.typicode.com/todos/1',
      ),
    ).thenAnswer((_) async {
      return http.Response(
          jsonEncode({'id': 1, 'title': 'Do the laundry'}), 200,
          headers: {'content-type': 'application/json; charset=utf-8'});
    });

    // Make the http request
    //
    // IMPORTANT NOTE: We are *not* tapping the [RaisedButton] directly.
    // Instead, we are finding the state object, and then running the asyncOnPressed function
    // which is passed to the onPressed of the RaisedButton. If we were to tap the RaisedButton directly,
    // the test wouldn't wait properly because the onPressed signature is a VoidCallback instead
    // of an AsyncCallback.
    await tester.state<BodyState>(find.byType(Body)).asyncOnPressed();
    await tester.pump();

    // A todo should be shown after the http request receives a response
    expect(find.byKey(Key('todo-1')), findsOneWidget);
  });
}
