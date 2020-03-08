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

  test("Suite 1", () async {
    SerializableFinder textFinder = find.text("Suite 1 will check this");

    await driver.waitFor(textFinder);
  });
}
