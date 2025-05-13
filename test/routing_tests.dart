import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ilabs_assignment/routing/custom_page_route.dart';
import 'package:ilabs_assignment/routing/routes.dart';
import 'package:ilabs_assignment/routing/navigation_service.dart';
import 'package:mockito/mockito.dart';

class MockNavigatorObserver extends Mock implements NavigatorObserver {}

void main() {
  group('Custom Page Routes Tests', () {
    testWidgets('FadePageRoute transitions correctly',
        (WidgetTester tester) async {
      // Prepare test widgets
      final testWidget = const Scaffold(
        body: Center(child: Text('Test Page Content')),
      );

      // Build the app with the custom route
      await tester.pumpWidget(
        MaterialApp(
          home: Builder(
            builder: (context) => ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  FadePageRoute(page: testWidget),
                );
              },
              child: const Text('Navigate'),
            ),
          ),
        ),
      );

      // Verify initial state
      expect(find.text('Navigate'), findsOneWidget);
      expect(find.text('Test Page Content'), findsNothing);

      // Tap the button to trigger navigation
      await tester.tap(find.text('Navigate'));
      await tester.pump(); // Start the transition

      // During the transition, both pages should exist with opacity animation
      expect(find.text('Test Page Content'), findsOneWidget);

      // Complete the transition
      await tester.pumpAndSettle();

      // After transition, only the destination page should be visible
      expect(find.text('Navigate'), findsNothing);
      expect(find.text('Test Page Content'), findsOneWidget);
    });

    testWidgets('SlideUpPageRoute transitions correctly',
        (WidgetTester tester) async {
      // Prepare test widgets
      final testWidget = const Scaffold(
        body: Center(child: Text('Slide Up Content')),
      );

      // Build the app with the custom route
      await tester.pumpWidget(
        MaterialApp(
          home: Builder(
            builder: (context) => ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  SlideUpPageRoute(page: testWidget),
                );
              },
              child: const Text('Navigate Up'),
            ),
          ),
        ),
      );

      // Verify initial state
      expect(find.text('Navigate Up'), findsOneWidget);
      expect(find.text('Slide Up Content'), findsNothing);

      // Tap the button to trigger navigation
      await tester.tap(find.text('Navigate Up'));
      await tester.pump(); // Start the transition

      // During the transition, both pages should exist with slide animation
      expect(find.text('Slide Up Content'), findsOneWidget);

      // Complete the transition
      await tester.pumpAndSettle();

      // After transition, only the destination page should be visible
      expect(find.text('Navigate Up'), findsNothing);
      expect(find.text('Slide Up Content'), findsOneWidget);
    });
  });

  group('Routes Tests', () {
    test('Routes constants are defined correctly', () {
      expect(Routes.splash, '/');
      expect(Routes.welcome, '/welcome');
      expect(Routes.login, '/login');
      expect(Routes.signup, '/signup');
      expect(Routes.home, '/home');
      expect(Routes.profile, '/profile');
    });

    test('Routes map contains all route definitions', () {
      final routes = Routes.routes;

      expect(routes.containsKey(Routes.splash), isTrue);
      expect(routes.containsKey(Routes.welcome), isTrue);
      expect(routes.containsKey(Routes.login), isTrue);
      expect(routes.containsKey(Routes.signup), isTrue);
      expect(routes.containsKey(Routes.home), isTrue);
      expect(routes.containsKey(Routes.profile), isTrue);
    });
  });
}
