import 'package:flutter/material.dart';
import 'routes.dart';
import 'custom_page_route.dart';

class NavigationService {
  static final NavigationService _instance = NavigationService._internal();

  factory NavigationService() => _instance;

  NavigationService._internal();

  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  Future<dynamic> navigateTo(String routeName,
      {Object? arguments, bool useTransition = true}) {
    if (!useTransition) {
      return navigatorKey.currentState!
          .pushNamed(routeName, arguments: arguments);
    }

    final route = _getRouteWithTransition(routeName, arguments: arguments);
    return navigatorKey.currentState!.push(route);
  }

  Future<dynamic> replaceTo(String routeName,
      {Object? arguments, bool useTransition = true}) {
    if (!useTransition) {
      return navigatorKey.currentState!
          .pushReplacementNamed(routeName, arguments: arguments);
    }

    final route = _getRouteWithTransition(routeName, arguments: arguments);
    return navigatorKey.currentState!.pushReplacement(route);
  }

  Future<dynamic> pushAndRemoveUntil(String routeName,
      {Object? arguments, bool useTransition = true}) {
    if (!useTransition) {
      return navigatorKey.currentState!.pushNamedAndRemoveUntil(
          routeName, (route) => false,
          arguments: arguments);
    }

    final route = _getRouteWithTransition(routeName, arguments: arguments);
    return navigatorKey.currentState!.pushAndRemoveUntil(route, (r) => false);
  }

  // Helper method to get appropriate route with transition
  Route _getRouteWithTransition(String routeName, {Object? arguments}) {
    final routeBuilder = Routes.getRouteBuilder(routeName);
    final page = routeBuilder(arguments);

    // Use different transitions for different page types
    if (routeName == Routes.profile) {
      return SlideUpPageRoute(page: page); // Profile slides up
    }

    return FadePageRoute(page: page); // Default fade transition
  }

  void goBack() {
    return navigatorKey.currentState!.pop();
  }

  // Common navigation methods
  void toWelcome() => replaceTo(Routes.welcome);
  void toLogin() => navigateTo(Routes.login);
  void toSignup() => navigateTo(Routes.signup);
  void toHome() => pushAndRemoveUntil(Routes.home);
  void toProfile() => navigateTo(Routes.profile);
}
