import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'view_model/home_view_model.dart';
import 'view_model/auth_view_model.dart';
import 'view_model/landing_view_model.dart';
import 'view_model/profile_view_model.dart';
import 'view_model/post_view_model.dart';

import 'services/service_locator.dart';
import 'routing/navigation_service.dart';
import 'routing/routes.dart';

void main() {
  // Initialize service locator before running the app
  setupServiceLocator();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => HomeViewModel()),
        ChangeNotifierProvider(create: (_) => AuthViewModel()),
        ChangeNotifierProvider(create: (_) => LandingViewModel()),
        ChangeNotifierProvider(create: (_) => ProfileViewModel()),
        ChangeNotifierProvider(create: (_) => PostViewModel()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'LinkedIn UI Assignment',
      debugShowCheckedModeBanner: false, // Remove debug banner
      navigatorKey: NavigationService().navigatorKey,
      theme: ThemeData(
        primaryColor: const Color(0xFF0A66C2), // LinkedIn blue
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF0A66C2),
          primary: const Color(0xFF0A66C2), // LinkedIn blue
          secondary: const Color(0xFF70B5F9), // LinkedIn light blue
        ),
        scaffoldBackgroundColor: const Color(0xFFE7EDF4), // LinkedIn background
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          elevation: 0,
        ),
        useMaterial3:
            false, // Keep Material 2 design for consistent LinkedIn look
        fontFamily: 'Roboto',
      ),
      initialRoute: Routes.splash,
      routes: Routes.routes,
      onGenerateRoute: (settings) {
        // This can be used for dynamic routes that aren't in the routes map
        return null;
      },
    );
  }
}
