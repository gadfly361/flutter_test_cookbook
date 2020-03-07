import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

void main() {
  FlutterDriver driver;

  setUpAll(() async {
    driver = await FlutterDriver.connect();
  });

  tearDownAll(() async {
    if (driver != null) {
      await driver.close();
    }
  });

  test("let's find a widget by its type", () async {
    // There is a RaisedButton in the main.dart file
    SerializableFinder raisedButtonFinder = find.byType("RaisedButton");

    await driver.waitFor(raisedButtonFinder);
    await driver.tap(raisedButtonFinder);
  });

  test("let's find a specific string of text", () async {
    // This is the exact string of text found in a Text widget in the main.dart file
    SerializableFinder textFinder =
        find.text("we will find this by searching for text");

    await driver.waitFor(textFinder);
  });

  test("let's find a widget by its key", () async {
    // There is a widget with its key defined as `Key("mykey")` in the main.dart file
    SerializableFinder keyFinder = find.byValueKey("mykey");

    await driver.waitFor(keyFinder);
  });
}
