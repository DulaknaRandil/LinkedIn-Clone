import '../models/user_model.dart';
import '../services/service_locator.dart';
import '../services/api_service.dart';
import '../services/storage_service.dart';
import '../services/analytics_service.dart';

class AuthRepository {
  // Get services from locator
  final _apiService = locator<ApiService>();
  final _storageService = locator<StorageService>();
  final _analyticsService = locator<AnalyticsService>();
  // Dummy users
  final List<UserModel> _users = [
    UserModel.linkedInProfile(),
  ];

  UserModel? login(String email, String password) {
    try {
      // Track login attempt
      _analyticsService
          .trackEvent('login_attempt', parameters: {'email': email});

      // In a real app, we would validate with the API
      final user = _users.firstWhere(
        (u) => u.email == email && u.password == password,
      );
      // Save user email to local storage on successful login
      _storageService.saveString('last_logged_in_email', email);
      _analyticsService.trackLogin('email');

      return user;
    } catch (e) {
      _analyticsService
          .trackEvent('login_error', parameters: {'error': e.toString()});
      return null;
    }
  }

  UserModel signup(String email, String password, String name) {
    // Track signup
    _analyticsService.trackSignup('email');

    final user = UserModel(
      email: email,
      password: password,
      name: name,
      headline: 'New LinkedIn User',
      profileImage: 'https://randomuser.me/api/portraits/men/2.jpg',
      connections: 0,
    );
    _users.add(user);

    // Save user email to local storage
    _storageService.saveString('last_signed_up_email', email);

    return user;
  }
}
