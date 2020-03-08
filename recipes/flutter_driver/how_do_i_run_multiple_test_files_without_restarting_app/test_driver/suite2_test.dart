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

  test("Suite 2", () async {
    SerializableFinder textFinder = find.text("Suite 2 will check this");

    await driver.waitFor(textFinder);
  });
}
