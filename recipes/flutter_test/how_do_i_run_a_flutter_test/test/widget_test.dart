import 'package:flutter_test/flutter_test.dart';
import 'package:ftc/main.dart';

void main() {
  testWidgets("'Hello world' text exists", (WidgetTester tester) async {
    await tester.pumpWidget(MyApp());

    expect(find.text('Hello world'), findsOneWidget);
  });
}
