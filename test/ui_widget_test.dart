import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:ilabs_assignment/models/user_model.dart';
import 'package:ilabs_assignment/view_model/auth_view_model.dart';
import 'package:ilabs_assignment/view_model/profile_view_model.dart';
import 'package:ilabs_assignment/view/screens/profile_view.dart';
import 'package:ilabs_assignment/view/screens/login_view.dart';
import 'package:ilabs_assignment/view/screens/welcome_view.dart';

// Mock classes
class MockAuthViewModel extends ChangeNotifier implements AuthViewModel {
  @override
  String email = 'test@example.com';

  @override
  String password = 'password123';

  @override
  String name = 'Test User';

  @override
  UserModel? user = UserModel.linkedInProfile();

  @override
  String get error => '';

  @override
  bool get isLoading => false;

  @override
  String get errorMessage => '';

  @override
  void setEmail(String val) {
    email = val;
    notifyListeners();
  }

  @override
  void setPassword(String val) {
    password = val;
    notifyListeners();
  }

  @override
  void setName(String val) {
    name = val;
    notifyListeners();
  }

  @override
  Future<bool> login() async {
    return true;
  }

  @override
  Future<bool> signup() async {
    return true;
  }

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

class MockProfileViewModel extends ChangeNotifier implements ProfileViewModel {
  @override
  UserModel? user = UserModel.linkedInProfile();

  @override
  bool get isLoading => false;

  @override
  String get errorMessage => '';

  @override
  int get profileViews => 111;

  @override
  int get postImpressions => 500;

  @override
  int get searchAppearances => 85;

  @override
  bool get creatorMode => true; // Fixed getter name to match ProfileViewModel

  @override
  void setUser(UserModel user) {
    this.user = user;
    notifyListeners();
  }

  @override
  void refreshProfileData() {
    notifyListeners();
  }

  @override
  void toggleCreatorMode() {
    notifyListeners();
  }

  @override
  int getFollowersCount() {
    return user?.followers ?? 4413;
  }

  @override
  String getConnectionsText() {
    return user!.connections > 500
        ? '500+ connections'
        : '${user?.connections ?? 0} connections';
  }

  @override
  List<Map<String, dynamic>> getExperiences({int limit = 100}) {
    return [
      {
        'company': 'iLabs Technologies',
        'role': 'Flutter Developer',
        'duration': 'May 2023 - Present · 1 yr 1 mo',
        'location': 'Bangalore, Karnataka, India',
        'description':
            'Working on cutting-edge mobile applications using Flutter and Dart.',
        'logo': 'https://example.com/logo.png',
      }
    ];
  }

  @override
  int get experienceCount => 3;

  @override
  List<Map<String, dynamic>> get activities {
    return [
      {
        'type': 'post',
        'title': 'Sample Post',
        'content': 'This is a sample LinkedIn post about Flutter development.'
      },
      {
        'type': 'share',
        'title': 'Shared Article',
        'content':
            'Check out this great article about MVVM architecture in Flutter!'
      }
    ];
  }

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

void main() {
  group('UI Widget Tests', () {
    testWidgets('ProfileView UI renders correctly',
        (WidgetTester tester) async {
      // Arrange
      final mockAuthViewModel = MockAuthViewModel();
      final mockProfileViewModel = MockProfileViewModel();

      await tester.pumpWidget(
        MaterialApp(
          home: MultiProvider(
            providers: [
              ChangeNotifierProvider<AuthViewModel>.value(
                  value: mockAuthViewModel),
              ChangeNotifierProvider<ProfileViewModel>.value(
                  value: mockProfileViewModel),
            ],
            child: const ProfileView(),
          ),
        ),
      );

      // Act
      await tester.pump();

      // Assert
      expect(find.text('Stebin Alex'), findsOneWidget);
      expect(find.text('Freelance iOS Developer | UIKit | SwiftUI'),
          findsOneWidget);
      expect(find.text('111'), findsOneWidget); // Profile views
      expect(find.text('500'), findsOneWidget); // Post impressions
      expect(find.text('85'), findsOneWidget); // Search appearances
    });

    testWidgets('LoginView UI renders correctly', (WidgetTester tester) async {
      // Arrange
      final mockAuthViewModel = MockAuthViewModel();

      await tester.pumpWidget(
        MaterialApp(
          home: ChangeNotifierProvider<AuthViewModel>.value(
            value: mockAuthViewModel,
            child: const LoginView(),
          ),
        ),
      );

      // Act
      await tester.pump(); // Assert
      expect(find.textContaining('Sign in').first,
          findsOneWidget); // Use first to handle multiple matching widgets
      expect(
          find.byType(TextField), findsAtLeast(2)); // Email and password fields
      expect(find.byType(ElevatedButton), findsOneWidget); // Login button
    });
    testWidgets('WelcomeView UI renders correctly',
        (WidgetTester tester) async {
      // Arrange
      await tester.pumpWidget(
        const MaterialApp(
          home: WelcomeView(),
        ),
      );

      // Act
      await tester.pump();

      // Assert
      expect(find.text('Linked'), findsOneWidget); // LinkedIn logo text
      expect(find.text('in'), findsOneWidget); // LinkedIn logo text
      expect(find.byType(ElevatedButton), findsAtLeast(1)); // Buttons
    });
  });
}
