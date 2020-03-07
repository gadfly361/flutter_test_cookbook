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

  test("'Hello world' text exists", () async {
    SerializableFinder helloWorldTextFinder = find.text("Hello world");

    await driver.waitFor(helloWorldTextFinder);
  });
}
