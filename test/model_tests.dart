import 'package:flutter_test/flutter_test.dart';
import 'package:ilabs_assignment/models/user_model.dart';
import 'package:ilabs_assignment/view_model/profile_view_model.dart';
import 'package:mockito/mockito.dart';
import 'package:ilabs_assignment/repository/user_repository.dart';

// Mock classes
class MockUserRepository extends Mock implements UserRepository {}

void main() {
  group('User Model Tests', () {
    test('Default user model values are set correctly', () {
      final user = UserModel(
        email: 'test@example.com',
        password: 'password123',
        name: 'Test User',
        headline: 'Software Developer',
        profileImage: 'https://example.com/image.jpg',
      );

      expect(user.email, 'test@example.com');
      expect(user.password, 'password123');
      expect(user.name, 'Test User');
      expect(user.company, 'Gooogle'); // Default value
      expect(user.location, 'Bengaluru, Karnataka, India'); // Default value
      expect(user.connections, 0); // Default value
      expect(user.followers, 0); // Default value
    });

    test('LinkedIn profile factory method creates expected values', () {
      final user = UserModel.linkedInProfile();

      expect(user.email, 'stebin.alex@example.com');
      expect(user.password, 'password123');
      expect(user.name, 'Stebin Alex');
      expect(user.headline, 'Freelance iOS Developer | UIKit | SwiftUI');
      expect(user.company, 'LEAN TRANSITION SOLUTIONS - LTS');
      expect(user.location, 'Thiruvananthapuram, Kerala, India');
      expect(user.connections, 500);
      expect(user.followers, 4413);
      expect(user.talkingAbout, contains('swift'));
      expect(user.talkingAbout, contains('swiftui'));
    });
  });

  group('ProfileViewModel Integration Tests', () {
    late ProfileViewModel profileViewModel;
    late MockUserRepository mockUserRepository;

    setUp(() {
      mockUserRepository = MockUserRepository();
      profileViewModel = ProfileViewModel();
    });
    test('ProfileViewModel initializes with correct default values', () {
      expect(profileViewModel.profileViews, 111);
      expect(profileViewModel.postImpressions, 500);
      expect(profileViewModel.searchAppearances, 85);
      expect(profileViewModel.creatorMode, isTrue); // Fixed getter name
      expect(profileViewModel.user, isNull);
    });

    test('ProfileViewModel sets user correctly', () {
      // Arrange
      final testUser = UserModel.linkedInProfile();

      // Act
      profileViewModel.setUser(testUser);

      // Assert
      expect(profileViewModel.user, equals(testUser));
      expect(profileViewModel.user?.name, equals('Stebin Alex'));
    });
    test('ProfileViewModel provides experiences correctly', () {
      final experiences = profileViewModel
          .getExperiences(); // Using the method instead of a getter

      expect(experiences, isNotEmpty);
      expect(experiences.length, equals(3)); // Based on the default data
      expect(experiences[0]['company'], equals('iLabs Technologies'));
      expect(experiences[0]['role'], equals('Flutter Developer'));
    });
  });
}
