import 'package:flutter/cupertino.dart';
import 'package:get_it/get_it.dart';

import 'app_navigator.dart';

class AppNav {
  static GetIt locator = GetIt.instance;

  static Future<dynamic> toNamed(String routeName, {dynamic arguments}) {
    return locator<AppNavigator>().toNamed(routeName, argument: arguments);
  }

  static void pop({dynamic arguments}) {
    return locator<AppNavigator>().pop(arguments);
  }

  static Future<dynamic> offNamed(String routeName, {dynamic arguments}) {
    return locator<AppNavigator>().offNamed(routeName, argument: arguments);
  }

  static void offAllToNamed(String routeName, {dynamic arguments}) {
    locator<AppNavigator>().offAllToNamed(routeName, argument: arguments);
  }
}