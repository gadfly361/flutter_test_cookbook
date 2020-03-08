import 'package:flutter_test/flutter_test.dart';
import 'package:ftc/main.dart';

void main() {
  testWidgets("How do I drag something?", (WidgetTester tester) async {
    await tester.pumpWidget(MyApp());

    Finder draggableFinder = find.text("Draggable");
    Finder dragTargetFinder = find.text("Drag Target");

    expect(draggableFinder, findsOneWidget);
    expect(dragTargetFinder, findsOneWidget);

    await tester.drag(draggableFinder, Offset(0, 100));
    await tester.pump();

    expect(dragTargetFinder, findsNothing);

    Finder successfulDragFinder = find.text("Successful drag!");
    expect(successfulDragFinder, findsOneWidget);
  });
}
