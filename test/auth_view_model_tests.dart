import 'package:flutter_test/flutter_test.dart';
import 'package:ilabs_assignment/view_model/auth_view_model.dart';
import 'package:ilabs_assignment/repository/auth_repository.dart';
import 'package:ilabs_assignment/models/user_model.dart';
import 'package:mockito/mockito.dart';
import 'package:ilabs_assignment/services/service_locator.dart';
import 'package:get_it/get_it.dart';
import 'package:ilabs_assignment/services/analytics_service.dart';
import 'package:ilabs_assignment/services/api_service.dart';
import 'package:ilabs_assignment/services/storage_service.dart';

// Mock classes
class MockAuthRepository extends Mock implements AuthRepository {}

class MockAnalyticsService extends Mock implements AnalyticsService {}

class MockApiService extends Mock implements ApiService {}

class MockStorageService extends Mock implements StorageService {}

void main() {
  setUpAll(() {
    // Register mocks with GetIt
    final getIt = GetIt.instance;
    if (!getIt.isRegistered<AnalyticsService>()) {
      getIt.registerSingleton<AnalyticsService>(MockAnalyticsService());
    }
    if (!getIt.isRegistered<ApiService>()) {
      getIt.registerSingleton<ApiService>(MockApiService());
    }
    if (!getIt.isRegistered<StorageService>()) {
      getIt.registerSingleton<StorageService>(MockStorageService());
    }
  });

  group('AuthViewModel Tests', () {
    late AuthViewModel authViewModel;
    late MockAuthRepository mockAuthRepository;

    setUp(() {
      mockAuthRepository = MockAuthRepository();
      authViewModel = AuthViewModel();
      authViewModel.setEmail('test@example.com');
      authViewModel.setPassword('password123');
      authViewModel.setName('Test User');
    });

    test('AuthViewModel initializes with empty values', () {
      final newAuthViewModel = AuthViewModel();

      expect(newAuthViewModel.email, isEmpty);
      expect(newAuthViewModel.password, isEmpty);
      expect(newAuthViewModel.name, isEmpty);
      expect(newAuthViewModel.user, isNull);
      expect(newAuthViewModel.isLoading, isFalse);
      expect(newAuthViewModel.error, isEmpty);
    });

    test('Login validation fails with empty email', () async {
      // Arrange
      authViewModel.setEmail('');

      // Act
      final result = await authViewModel.login();

      // Assert
      expect(result, isFalse);
      expect(authViewModel.error, isNotEmpty);
    });

    test('Login validation fails with empty password', () async {
      // Arrange
      authViewModel.setPassword('');

      // Act
      final result = await authViewModel.login();

      // Assert
      expect(result, isFalse);
      expect(authViewModel.error, isNotEmpty);
    });

    test('Signup validation fails with short password', () async {
      // Arrange
      authViewModel.setPassword('123');

      // Act
      final result = await authViewModel.signup();

      // Assert
      expect(result, isFalse);
      expect(authViewModel.error,
          contains('Password must be at least 6 characters'));
    });

    test('Signup validation fails with empty fields', () async {
      // Arrange
      final newAuthViewModel = AuthViewModel();

      // Act
      final result = await newAuthViewModel.signup();

      // Assert
      expect(result, isFalse);
      expect(newAuthViewModel.error, contains('All fields are required'));
    });
  });
}
