import 'package:flutter/material.dart';

class NavigationService {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  Future<dynamic>? pushNamed(String routeName, {dynamic arguments}) {
    return navigatorKey.currentState
        ?.pushNamed(routeName, arguments: arguments);
  }

  Future<dynamic>? pushReplacementNamed(String routeName, {dynamic arguments}) {
    return navigatorKey.currentState
        ?.pushReplacementNamed(routeName, arguments: arguments);
  }

  void pop({dynamic result}) {
    navigatorKey.currentState?.pop(result);
  }
}
