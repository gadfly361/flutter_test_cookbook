# flutter_test_cookbook

A community driven cookbook with _recipes_ (i.e., examples) on how to test your flutter application.

## Recipes

There are [three pillars](https://flutter.dev/docs/cookbook/testing) of flutter tests:
1) unit
2) widget
3) integration

This cookbook is mostly concerned with 2 and 3.

Currently, [flutter_test](https://api.flutter.dev/flutter/flutter_test/flutter_test-library.html) is used for widget tests, and [flutter_driver](https://api.flutter.dev/flutter/flutter_driver/flutter_driver-library.html) is used for integration tests. However, it is possible that `flutter_driver` could eventually be deprecated, and `flutter_test` could be used for both widget and integration tests.

    We're moving away from flutter_driver in favour of extending flutter_test to work on devices.
	- Hixie
	https://github.com/flutter/flutter/issues/7474#issuecomment-558882182

Because of this, the recipes will be split out into two directories: `flutter_test` and `flutter_driver`

### flutter_test recipes

- [How do I run a flutter test?](https://github.com/gadfly361/flutter_test_cookbook/blob/master/recipes/flutter_test/how_do_i_run_a_flutter_test)
- [How do I find something?](https://github.com/gadfly361/flutter_test_cookbook/blob/master/recipes/flutter_test/how_do_i_find_something)
- [How do I test routes?](https://github.com/gadfly361/flutter_test_cookbook/blob/master/recipes/flutter_test/how_do_i_test_routes)
- [How do I drag something?](https://github.com/gadfly361/flutter_test_cookbook/blob/master/recipes/flutter_test/how_do_i_drag_something)
- [How do I open a Drawer?](https://github.com/gadfly361/flutter_test_cookbook/blob/master/recipes/flutter_test/how_do_i_open_a_drawer)
- [How do I send a keyboard action like done or next?](https://github.com/gadfly361/flutter_test_cookbook/blob/master/recipes/flutter_test/how_do_i_send_a_keyboard_action)
- [How do I test an Exception?](https://github.com/gadfly361/flutter_test_cookbook/blob/master/recipes/flutter_test/how_do_i_test_an_exception)
- [What if I need a BuildContext?](https://github.com/gadfly361/flutter_test_cookbook/blob/master/recipes/flutter_test/what_if_i_need_build_context)
- [How do I mock shared_preferences?](https://github.com/gadfly361/flutter_test_cookbook/blob/master/recipes/flutter_test/how_do_i_mock_shared_preferences)
- [How do I test an animation?](https://github.com/gadfly361/flutter_test_cookbook/blob/master/recipes/flutter_test/how_do_i_test_an_animation)

### flutter_driver recipes

- [How do I run a flutter driver test?](https://github.com/gadfly361/flutter_test_cookbook/blob/master/recipes/flutter_driver/how_do_i_run_a_flutter_driver_test)
- [How do I find something?](https://github.com/gadfly361/flutter_test_cookbook/blob/master/recipes/flutter_driver/how_do_i_find_something)
- [How do I take a screenshot](https://github.com/gadfly361/flutter_test_cookbook/blob/master/recipes/flutter_driver/how_do_i_take_a_screenshot)
- [How do I dismiss (i.e. pop) a dialog?](https://github.com/gadfly361/flutter_test_cookbook/blob/master/recipes/flutter_driver/how_do_i_pop_dialog)

## External Resources

This section is a list of external resources that may be useful when exploring how to test your flutter application.

*Written*
- [Flutter UI Testing (with codemagic)](https://blog.codemagic.io/flutter-ui-testing/)
- [Mock dependencies using Mockito](https://flutter.dev/docs/cookbook/testing/unit/mocking)
- [Flutter: Golden tests - compare Widgets with Snapshots](https://medium.com/flutter-community/flutter-golden-tests-compare-widgets-with-snapshots-27f83f266cea)
- [Testing gestures using Flutter driver](https://medium.com/flutter-community/testing-gestures-using-flutter-driver-b37981c24366)
- [60 Days of Flutter: Day 4-5: Widget Testing with Flutter](https://medium.com/@adityadroid/60-days-of-flutter-day-4-5-widget-testing-with-flutter-a30236dd04fc)
- [Blazingly Fast Flutter Driver Tests](https://medium.com/flutter-community/blazingly-fast-flutter-driver-tests-5e375c833aa)


*Videos*
- [Flutter: Deep Dive with Widget Tests and Mockito](https://www.youtube.com/watch?v=75i5VmTI6A0)
- [Bloc Test Tutorial - Easier Way to Test Blocs in Dart & Flutter](https://resocoder.com/2019/11/29/bloc-test-tutorial-easier-way-to-test-blocs-in-dart-flutter/)


## Want to contribute?

First of all, thank you. Contributions are encouraged!  Please follow the guidelines below.

### Want to suggest a recipe?

If you'd like to suggest a recipe, please open an issue and add `[recipe-suggestion]` to the beginning of the title.

### Want to add your own recipe?

If you'd like to add a recipe, please add `[new-recipe]` to the beginning of your PR's title.

Each recipe should:

- be focused on a specific topic
- be concise
- have runnable tests
- only check in 'meaningful' files

Note: if you want to get an early sense of whether or not your recipe will be accepted, please open a `[recipe-suggestion]` issue first.

### Want to fix a typo?

If you'd like to fix a typo, please add `[fix-typo]` to the beginning of your PR's title.

### Want to correct an error in an existing recipe?

If you'd like to correct an error in an existing recipe, please add `[fix-recipe]` to the beginning of your PR's title.

### Want to add a link to an external resource?

If you'd like to add a link to an external resource, please add `[add-resource]` to the beginning of your PR's title.

## LICENSE

Copyright © 2020 Matthew Jaoudi

Distributed under the The MIT License (MIT).
