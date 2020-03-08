import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';
import 'dart:io' show File;

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

  test("How do I take a screenshot?", () async {
    // It is good practice to call this before taking a screenshot
    // to ensure everything has settled
    await driver.waitUntilNoTransientCallbacks();

    // Take the screenshot and store as a list of ints
    // Note: the image will be returned as a PNG
    final List<int> screenshotPixels = await driver.screenshot();

    // Write to a file
    final File screenshotFile = new File("my_screenshot.png");
    await screenshotFile.writeAsBytes(screenshotPixels);
  });
}
