import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:ftc/main.dart';

void main() {
  // If you're running a test, you can call the `TestWidgetsFlutterBinding.ensureInitialized()` as the first line in your test's `main()` method to initialize the binding.
  TestWidgetsFlutterBinding.ensureInitialized();

  testWidgets(
      "The value displayed should fallback to 0 if the shared_preferences value isn't mocked",
      (WidgetTester tester) async {
    await tester.pumpWidget(MyApp());

    expect(find.text("The shared_preferences value is: 0"), findsOneWidget);
  });

  testWidgets(
      "The value displayed should be updated when mocking initial shared_preferences values",
      (WidgetTester tester) async {
    // We are setting the initial value to 10
    SharedPreferences.setMockInitialValues({"myValue": 10});

    // then we are pumping our top-level widget
    await tester.pumpWidget(MyApp());

    // However, because we are grabbing shared_preferences value in our initState, and then using setState
    // to set the value displayed in our app, we need to pump one more time!
    await tester.pump();

    // Then we expect out mock value to be displayed
    expect(find.text("The shared_preferences value is: 10"), findsOneWidget);
  });
}
