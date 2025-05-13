import 'package:flutter_test/flutter_test.dart';
import 'package:ilabs_assignment/models/user_model.dart';
import 'package:ilabs_assignment/view_model/auth_view_model.dart';
import 'package:ilabs_assignment/view_model/profile_view_model.dart';
import 'package:ilabs_assignment/repository/auth_repository.dart';
import 'package:ilabs_assignment/repository/profile_analytics_repository.dart';
import 'package:ilabs_assignment/repository/activity_repository.dart';
import 'package:ilabs_assignment/repository/experience_repository.dart';
import 'test_helpers/testable_profile_view_model.dart';
import 'package:mockito/mockito.dart';
import 'package:ilabs_assignment/services/service_locator.dart';
import 'package:get_it/get_it.dart';
import 'package:ilabs_assignment/services/analytics_service.dart';
import 'package:ilabs_assignment/services/api_service.dart';
import 'package:ilabs_assignment/services/storage_service.dart';
import 'package:ilabs_assignment/services/data_service.dart';
import 'package:ilabs_assignment/routing/navigation_service.dart';

// Mock classes
class MockAuthRepository extends Mock implements AuthRepository {}

class MockAnalyticsService extends Mock implements AnalyticsService {}

class MockApiService extends Mock implements ApiService {}

class MockStorageService extends Mock implements StorageService {}

class MockNavigationService extends Mock implements NavigationService {}

class MockDataService extends Mock implements DataService {}

// Mock repositories
class MockProfileAnalyticsRepository extends ProfileAnalyticsRepository {
  @override
  int getProfileViewsSync() => 111;

  @override
  int getPostImpressionsSync() => 500;

  @override
  int getSearchAppearancesSync() => 85;

  @override
  bool getCreatorModeSync() => true;

  bool _creatorMode = true;

  @override
  Future<void> toggleCreatorMode() async {
    _creatorMode = !_creatorMode;
    super.toggleCreatorMode();
  }

  @override
  Future<bool> getCreatorMode() async => _creatorMode;
}

class MockActivityRepository extends ActivityRepository {
  final _activities = [
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

  @override
  List<Map<String, dynamic>> getActivitiesSync() => _activities;
}

class MockExperienceRepository extends ExperienceRepository {
  final _experiences = [
    {
      'company': 'iLabs Technologies',
      'role': 'Flutter Developer',
      'duration': 'May 2023 - Present · 1 yr 1 mo',
      'location': 'Bangalore, Karnataka, India',
      'description':
          'Working on cutting-edge mobile applications using Flutter and Dart.',
      'logo': 'https://example.com/logo.png',
    },
    {
      'company': 'TechInnovate Solutions',
      'role': 'Junior Mobile Developer',
      'duration': 'Jun 2022 - Apr 2023 · 11 mo',
      'location': 'Bangalore, Karnataka, India',
      'description':
          'Worked on mobile app development focusing on UI/UX implementation.',
      'logo': 'https://example.com/logo2.png',
    },
    {
      'company': 'CodeCraft Academy',
      'role': 'Mobile Development Intern',
      'duration': 'Jan 2022 - May 2022 · 5 mo',
      'location': 'Bangalore, Karnataka, India',
      'description': 'Assisted in development of mobile applications.',
      'logo': 'https://example.com/logo3.png',
    }
  ];

  @override
  List<Map<String, dynamic>> getExperiencesSync({int limit = 100}) =>
      _experiences.take(limit).toList();
}

void main() {
  setUpAll(() {
    // Initialize service locator with mocks
    GetIt.instance.registerSingleton<AnalyticsService>(MockAnalyticsService());
    GetIt.instance.registerSingleton<ApiService>(MockApiService());
    GetIt.instance.registerSingleton<StorageService>(MockStorageService());
    GetIt.instance
        .registerSingleton<NavigationService>(MockNavigationService());
    GetIt.instance.registerSingleton<DataService>(MockDataService());
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
    late TestableProfileViewModel profileViewModel;
    late UserModel testUser;

    setUp(() {
      // Use our testable version specifically designed for tests
      profileViewModel = TestableProfileViewModel();
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
    test('Toggle creator mode changes its state', () async {
      // Arrange
      final initialState = profileViewModel.creatorMode;

      // Act
      await profileViewModel.toggleCreatorMode();

      // Assert - verify it's been toggled to the opposite state
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
    test('Get activities returns valid activities', () async {
      // Act
      final activities = await profileViewModel.activities;

      // Assert
      expect(activities, isNotEmpty);
    });
    test('Refresh profile data sets loading state correctly', () async {
      // Act - now this is async so we need to await it
      profileViewModel.refreshProfileData();

      // Assert - Check loading state is initially true
      expect(profileViewModel.isLoading, isTrue);

      // Wait for the refresh to complete
      await Future.delayed(const Duration(milliseconds: 100));

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
