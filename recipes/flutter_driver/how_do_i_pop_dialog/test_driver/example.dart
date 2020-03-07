import 'package:flutter_driver/driver_extension.dart';
import 'package:ftc/main.dart' as app;

Future<String> dataHandler(String message) async {
  // We are using the data handler to execute a pop side-effect
  if (message == "pop") {
    app.appNavigatorKey.currentState.pop();
  }

  return null;
}

void main() {
  enableFlutterDriverExtension(
    // we are adding the dataHandler here
    handler: dataHandler,
  );

  app.main();
}
