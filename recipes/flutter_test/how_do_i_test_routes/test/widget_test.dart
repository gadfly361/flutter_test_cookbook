import 'package:flutter_test/flutter_test.dart';
import 'package:ftc/main.dart';

void main() {
  testWidgets("How do I test routes?", (WidgetTester tester) async {
    await tester.pumpWidget(MyApp());

    // First, let's make sure we are on /page1
    expect(find.byType(Page1), findsOneWidget);
    expect(find.byType(Page2), findsNothing);
    expect(find.byType(Page3), findsNothing);

    //
    // Next, let's navigate to /page2
    //
    await tester.tap(find.text("pushNamed to page2"));
    await tester.pumpAndSettle();

    // Confirm we are on /page2
    expect(find.byType(Page1), findsNothing);
    expect(find.byType(Page2), findsOneWidget);
    expect(find.byType(Page3), findsNothing);

    // However, since routes are in a stack, and we pushed page2 on top of page1,
    // we should confirm that page1 still exists.
    // We can do this by setting `skipOffstage` to false.
    expect(find.byType(Page1, skipOffstage: false), findsOneWidget);
    expect(find.byType(Page2, skipOffstage: false), findsOneWidget);
    expect(find.byType(Page3, skipOffstage: false), findsNothing);

    //
    // Next, let's navigate to /page3
    //

    await tester.tap(find.text("pushNamed to page3"));
    await tester.pumpAndSettle();

    // Confirm we are on /page3
    expect(find.byType(Page1), findsNothing);
    expect(find.byType(Page2), findsNothing);
    expect(find.byType(Page3), findsOneWidget);
    expect(find.byType(Page1, skipOffstage: false), findsOneWidget);
    expect(find.byType(Page2, skipOffstage: false), findsOneWidget);
    expect(find.byType(Page3, skipOffstage: false), findsOneWidget);

    //
    // Next, let's navigate back to /page2
    //

    await tester.tap(find.text("pop"));
    await tester.pumpAndSettle();

    // confirm we are on /page2
    expect(find.byType(Page1), findsNothing);
    expect(find.byType(Page2), findsOneWidget);
    expect(find.byType(Page3), findsNothing);
    expect(find.byType(Page1, skipOffstage: false), findsOneWidget);
    expect(find.byType(Page2, skipOffstage: false), findsOneWidget);
    expect(find.byType(Page3, skipOffstage: false), findsNothing);

    //
    // Finally, let's navigate back to /page3 and then popUntil we are on /page1
    //

    await tester.tap(find.text("pushNamed to page3"));
    await tester.pumpAndSettle();

    // Confirm we are on /page3
    expect(find.byType(Page1), findsNothing);
    expect(find.byType(Page2), findsNothing);
    expect(find.byType(Page3), findsOneWidget);
    expect(find.byType(Page1, skipOffstage: false), findsOneWidget);
    expect(find.byType(Page2, skipOffstage: false), findsOneWidget);
    expect(find.byType(Page3, skipOffstage: false), findsOneWidget);

    await tester.tap(find.text("popUntil page1"));
    await tester.pumpAndSettle();

    // Confirm we are on /page1
    expect(find.byType(Page1), findsOneWidget);
    expect(find.byType(Page2), findsNothing);
    expect(find.byType(Page3), findsNothing);
    expect(find.byType(Page1, skipOffstage: false), findsOneWidget);
    expect(find.byType(Page2, skipOffstage: false), findsNothing);
    expect(find.byType(Page3, skipOffstage: false), findsNothing);
  });
}
