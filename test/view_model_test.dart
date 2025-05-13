import 'package:flutter_test/flutter_test.dart';
import 'package:ilabs_assignment/models/user_model.dart';
import 'package:ilabs_assignment/view_model/auth_view_model.dart';
import 'package:ilabs_assignment/view_model/profile_view_model.dart';
import 'package:ilabs_assignment/repository/auth_repository.dart';
import 'package:mockito/mockito.dart';
import 'package:ilabs_assignment/services/service_locator.dart';
import 'package:get_it/get_it.dart';
import 'package:ilabs_assignment/services/analytics_service.dart';
import 'package:ilabs_assignment/services/api_service.dart';
import 'package:ilabs_assignment/services/storage_service.dart';
import 'package:ilabs_assignment/routing/navigation_service.dart';

// Mock classes
class MockAuthRepository extends Mock implements AuthRepository {}

class MockAnalyticsService extends Mock implements AnalyticsService {}

class MockApiService extends Mock implements ApiService {}

class MockStorageService extends Mock implements StorageService {}

class MockNavigationService extends Mock implements NavigationService {}

void main() {
  setUpAll(() {
    // Initialize service locator with mocks
    GetIt.instance.registerSingleton<AnalyticsService>(MockAnalyticsService());
    GetIt.instance.registerSingleton<ApiService>(MockApiService());
    GetIt.instance.registerSingleton<StorageService>(MockStorageService());
    GetIt.instance
        .registerSingleton<NavigationService>(MockNavigationService());
  });

  tearDownAll(() {
    // Reset service locator
    GetIt.instance.reset();
  });

  group('AuthViewModel Tests', () {
    late AuthViewModel authViewModel;

    setUp(() {
      authViewModel = AuthViewModel();
    });

    test('Setting email updates the email property', () {
      // Arrange
      const testEmail = 'test@example.com';

      // Act
      authViewModel.setEmail(testEmail);

      // Assert
      expect(authViewModel.email, equals(testEmail));
    });

    test('Setting password updates the password property', () {
      // Arrange
      const testPassword = 'password123';

      // Act
      authViewModel.setPassword(testPassword);

      // Assert
      expect(authViewModel.password, equals(testPassword));
    });

    test('Setting name updates the name property', () {
      // Arrange
      const testName = 'John Doe';

      // Act
      authViewModel.setName(testName);

      // Assert
      expect(authViewModel.name, equals(testName));
    });

    test('Login fails with empty credentials', () async {
      // Arrange
      authViewModel.setEmail('');
      authViewModel.setPassword('');

      // Act
      final result = await authViewModel.login();

      // Assert
      expect(result, isFalse);
      expect(authViewModel.error, isNotEmpty);
    });

    test('Signup fails with empty fields', () async {
      // Arrange
      authViewModel.setEmail('');
      authViewModel.setPassword('');
      authViewModel.setName('');

      // Act
      final result = await authViewModel.signup();

      // Assert
      expect(result, isFalse);
      expect(authViewModel.error, isNotEmpty);
    });

    test('Signup fails with short password', () async {
      // Arrange
      authViewModel.setEmail('test@example.com');
      authViewModel.setPassword('123');
      authViewModel.setName('Test User');

      // Act
      final result = await authViewModel.signup();

      // Assert
      expect(result, isFalse);
      expect(authViewModel.error,
          contains('Password must be at least 6 characters'));
    });
  });

  group('ProfileViewModel Tests', () {
    late ProfileViewModel profileViewModel;
    late UserModel testUser;

    setUp(() {
      profileViewModel = ProfileViewModel();
      testUser = UserModel.linkedInProfile();
    });

    test('Setting user updates the user property', () {
      // Act
      profileViewModel.setUser(testUser);

      // Assert
      expect(profileViewModel.user, equals(testUser));
    });

    test('Profile analytics have correct initial values', () {
      // Assert - check the defaults match LinkedIn screenshot values
      expect(profileViewModel.profileViews, equals(111));
      expect(profileViewModel.postImpressions, equals(500));
      expect(profileViewModel.searchAppearances, equals(85));
    });
    test('Creator mode is enabled by default', () {
      expect(profileViewModel.creatorMode, isTrue);
    });

    test('Toggle creator mode changes its state', () {
      // Arrange
      final initialState = profileViewModel.creatorMode;

      // Act
      profileViewModel.toggleCreatorMode();

      // Assert
      expect(profileViewModel.creatorMode, equals(!initialState));
    });
    test('Get experiences returns correct experience list', () {
      // Act
      final experiences = profileViewModel.getExperiences();

      // Assert
      expect(experiences, isNotEmpty);
      expect(experiences.length, equals(3)); // Based on the mockup data
      expect(experiences[0]['company'], equals('iLabs Technologies'));
    });

    test('Get activities returns valid activities', () {
      // Act
      final activities = profileViewModel.activities;

      // Assert
      expect(activities, isNotEmpty);
    });

    test('Refresh profile data sets loading state correctly', () async {
      // Act
      profileViewModel.refreshProfileData();

      // Assert - Check loading state is initially true
      expect(profileViewModel.isLoading, isTrue);

      // Wait for the refresh to complete
      await Future.delayed(const Duration(seconds: 1));

      // Assert - Check loading state is reset to false
      expect(profileViewModel.isLoading, isFalse);
    });
  });

  group('UserModel Tests', () {
    test('LinkedInProfile factory creates user with correct values', () {
      // Act
      final user = UserModel.linkedInProfile();

      // Assert
      expect(user.name, equals('Stebin Alex'));
      expect(user.email, equals('stebin.alex@example.com'));
      expect(
          user.headline, equals('Freelance iOS Developer | UIKit | SwiftUI'));
      expect(user.location, equals('Thiruvananthapuram, Kerala, India'));
      expect(user.connections, equals(500));
      expect(user.followers, equals(4413));
    });

    test('UserModel creates object with default values when not provided', () {
      // Act
      final user = UserModel(
        email: 'test@example.com',
        password: 'password',
        name: 'Test User',
        headline: 'Test Headline',
        profileImage: 'https://example.com/image.jpg',
      );

      // Assert
      expect(user.company, equals('Gooogle')); // Default value
      expect(user.location,
          equals('Bengaluru, Karnataka, India')); // Default value
      expect(user.connections, equals(0)); // Default value
      expect(user.followers, equals(0)); // Default value
      expect(user.talkingAbout, contains('flutter')); // Default value
    });
  });
}
