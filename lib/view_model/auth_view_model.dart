import 'package:flutter/material.dart';
import '../models/user_model.dart';
import '../repository/auth_repository.dart';
import 'base_view_model.dart';

class AuthViewModel extends BaseViewModel {
  final AuthRepository _repo = AuthRepository();

  String email = '';
  String password = '';
  String name = '';
  UserModel? user;
  String get error => errorMessage;

  void setEmail(String val) {
    email = val;
    notifyListeners();
  }

  void setPassword(String val) {
    password = val;
    notifyListeners();
  }

  void setName(String val) {
    name = val;
    notifyListeners();
  }

  Future<bool> login() async {
    trackUserAction('login_attempt_start', parameters: {'email': email});

    if (email.isEmpty || password.isEmpty) {
      setError('Email and password are required');
      trackUserAction('login_validation_error',
          parameters: {'error': 'Empty fields'});
      return false;
    }

    await Future.delayed(const Duration(milliseconds: 800));

    final result = await handleApiCall(
      () async {
        final loggedInUser = _repo.login(email, password);
        if (loggedInUser == null) {
          throw Exception('Invalid credentials');
        }
        return loggedInUser;
      },
      actionName: 'login_attempt',
    );

    if (result != null) {
      user = result;
      trackUserAction('login_success', parameters: {'user_id': user!.email});
      clearError();
      return true;
    }

    return false;
  }

  Future<bool> signup() async {
    trackUserAction('signup_attempt_start',
        parameters: {'email': email, 'name': name});

    if (email.isEmpty || password.isEmpty || name.isEmpty) {
      setError('All fields are required');
      trackUserAction('signup_validation_error',
          parameters: {'error': 'Empty fields'});
      return false;
    }

    if (password.length < 6) {
      setError('Password must be at least 6 characters');
      trackUserAction('signup_validation_error',
          parameters: {'error': 'Password too short'});
      return false;
    }

    await Future.delayed(const Duration(milliseconds: 800));

    final result = await handleApiCall(
      () async => _repo.signup(email, password, name),
      actionName: 'signup_attempt',
    );

    if (result != null) {
      user = result;
      trackUserAction('signup_success', parameters: {'user_id': user!.email});
      clearError();
      return true;
    }

    return false;
  }
}
