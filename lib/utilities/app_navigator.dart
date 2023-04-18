import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';


import 'app_routes.dart';

class AppNavigator {
  GlobalKey<NavigatorState> navigationKey = GlobalKey<NavigatorState>();

  Future<dynamic> toNamed(String name, {dynamic argument}) {
    return navigationKey.currentState!.pushNamed(name, arguments: argument);
  }

  Future<dynamic> offNamed(String name, {dynamic argument}) {
    return navigationKey.currentState!.popAndPushNamed(name, arguments: argument);
  }

  void pop([dynamic result]) {
    navigationKey.currentState!.pop(result);
  }

  void offAllToNamed(String name, {dynamic argument}) {
    navigationKey.currentState!.popUntil((route) => route.settings.name == AppRoutes.none);
    toNamed(name, argument: argument);
  }
}

GetIt locator = GetIt.instance;

setupLocator() {
  locator.registerLazySingleton(() => AppNavigator());
}
