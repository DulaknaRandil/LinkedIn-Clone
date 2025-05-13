import 'package:flutter/material.dart';
import '../view/screens/splash_view.dart';
import '../view/screens/welcome_view.dart';
import '../view/screens/login_view.dart';
import '../view/screens/signup_view.dart';
import '../view/screens/home_view.dart';
import '../view/screens/profile_view.dart';

class Routes {
  static const splash = '/';
  static const welcome = '/welcome';
  static const login = '/login';
  static const signup = '/signup';
  static const home = '/home';
  static const profile = '/profile';

  // Route configuration map
  static Map<String, WidgetBuilder> get routes => {
        splash: (context) => const SplashView(),
        welcome: (context) => const WelcomeView(),
        login: (context) => const LoginView(),
        signup: (context) => const SignupView(),
        home: (context) => const HomeView(),
        profile: (context) => const ProfileView(),
      };

  // Get a route builder function for custom transitions
  static Widget Function(dynamic) getRouteBuilder(String routeName) {
    switch (routeName) {
      case splash:
        return (_) => const SplashView();
      case welcome:
        return (_) => const WelcomeView();
      case login:
        return (_) => const LoginView();
      case signup:
        return (_) => const SignupView();
      case home:
        return (_) => const HomeView();
      case profile:
        return (args) => const ProfileView();
      default:
        return (_) =>
            const Scaffold(body: Center(child: Text('Route not found')));
    }
  }
}
