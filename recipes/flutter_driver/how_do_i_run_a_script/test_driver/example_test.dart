import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';
import 'dart:io';

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

  test("How do I run a script inside of a test?", () async {
    ProcessResult result = await Process.run('./echo.sh', ['1']);

    // Note: echo appends a newline to the result
    expect(result.stdout, '1\n');
  });
}
