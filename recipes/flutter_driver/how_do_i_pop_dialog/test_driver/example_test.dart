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

  test("let's open a dialog and then close it", () async {
    SerializableFinder raisedButtonFinder = find.byType("RaisedButton");
    await driver.waitFor(raisedButtonFinder);
    // tapping the button opens the Dialog
    await driver.tap(raisedButtonFinder);

    // make sure the the Dialog is open
    SerializableFinder dialogFinder = find.byType("Dialog");
    await driver.waitFor(dialogFinder);

    // now, let's close the dialog using the dataHandler we defined in
    // our [enableFlutterDriverExtension] function.
    await driver.requestData("pop");

    // finally, let's wait to make sure the Dialog is gone
    await driver.waitForAbsent(dialogFinder);
  });
}
