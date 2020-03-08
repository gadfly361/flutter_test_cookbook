#!/bin/bash

# start the app and write the uri to a file
flutter run --target=test_driver/start_app.dart --vmservice-out-file="test_driver/uri.txt" --start-paused --no-resident

# run the test suites using the uri in the aforementioned file
flutter driver --target=test_driver/suite1.dart --use-existing-app="$(cat test_driver/uri.txt)"
flutter driver --target=test_driver/suite2.dart --use-existing-app="$(cat test_driver/uri.txt)"