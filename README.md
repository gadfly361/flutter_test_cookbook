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

### flutter_driver recipes

- [How do I run a flutter driver test?](https://github.com/gadfly361/flutter_test_cookbook/blob/master/recipes/flutter_driver/how_do_i_run_a_flutter_driver_test)
- [How do I find something?](https://github.com/gadfly361/flutter_test_cookbook/blob/master/recipes/flutter_driver/how_do_i_find_something)

## External Resources

This section is a list of external resources that may be useful when exploring how to test your flutter application.

## Want to contribute?

First of all, thank you. Contributions are encouraged!  Please follow the guidelines below.

### Want to add your own recipe?

Each recipe should:

- be focused on a specific topic
- be concise
- have runnable tests
- only check in 'meaningful' files

### Want to suggest a recipe?

If you'd like to suggest a recipe, please open an issue using the following template.

### Want to fix a typo?

If you'd like to fix a typo, please add `[fix-typo]` to the beginning of your PR's title.

### Want to correct an error in an existing recipe?

If you'd like to correct an error in an existing recipe, please add `[fix-recipe]` to the beginning of your PR's title.

### Want to add a link to an external resource?

If you'd like to add a link to an external resource, please add `[add-resource]` to the beginning of your PR's title.

## LICENSE

Copyright © 2020 Matthew Jaoudi

Distributed under the The MIT License (MIT).
