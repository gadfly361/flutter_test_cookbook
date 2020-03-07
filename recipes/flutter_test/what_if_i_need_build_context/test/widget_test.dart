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
