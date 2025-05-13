import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:ilabs_assignment/models/user_model.dart';
import 'package:ilabs_assignment/view_model/auth_view_model.dart';
import 'package:ilabs_assignment/view_model/profile_view_model.dart';
import 'package:ilabs_assignment/view/screens/profile_view.dart';
import 'package:ilabs_assignment/view/screens/login_view.dart';
import 'package:ilabs_assignment/view/screens/welcome_view.dart';
import 'test_resources/test_images.dart';

// Mock classes
class MockAuthViewModel extends ChangeNotifier implements AuthViewModel {
  @override
  String email = 'test@example.com';

  @override
  String password = 'password123';

  @override
  String name = 'Test User';
  @override
  UserModel? user = UserModel(
    email: "stebin.alex@example.com",
    password: "password123",
    name: "Test User",
    headline: "Freelance Developer",
    company: "Gooogle",
    location: "Bengaluru, Karnataka, India",
    profileImage: TestImages.mockProfileImage,
    bannerImage: TestImages.mockBannerImage,
    connections: 100,
    followers: 200,
    talkingAbout: ["flutter", "dart", "mobileappdevelopment"],
  );

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
  UserModel? user = UserModel(
    email: "stebin.alex@example.com",
    password: "password123",
    name: "Stebin Alex",
    headline: "Freelance iOS Developer | UIKit | SwiftUI",
    company: "LEAN TRANSITION SOLUTIONS - LTS",
    location: "Thiruvananthapuram, Kerala, India",
    profileImage: TestImages.mockProfileImage,
    bannerImage: TestImages.mockBannerImage,
    connections: 500,
    followers: 4413,
    talkingAbout: ["swift", "swiftui", "iosdevelopment"],
  );

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
  Future<void> refreshProfileData() async {
    notifyListeners();
  }

  @override
  Future<void> toggleCreatorMode() async {
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
  Future<int> get experienceCount async => 3;

  @override
  Future<List<Map<String, dynamic>>> get activities async {
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
      ); // Act
      await tester.pump();
      await tester
          .pumpAndSettle(); // Wait for all animations and async operations

      // Assert
      // First verify we're on the profile page
      expect(find.byType(Scaffold), findsOneWidget);

      // Look for static elements we know should be there
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
      await tester.pump(); // Assert
      expect(find.text('Linked'), findsOneWidget); // LinkedIn logo text
      expect(find.text('in'), findsOneWidget); // LinkedIn logo text
      expect(find.byType(GestureDetector),
          findsAtLeast(1)); // Custom buttons using GestureDetector
    });
  });
}
