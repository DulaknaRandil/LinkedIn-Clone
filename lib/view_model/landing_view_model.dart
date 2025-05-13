import 'package:flutter/material.dart';
import '../routing/navigation_service.dart';
import 'base_view_model.dart';

class LandingViewModel extends BaseViewModel {
  // Handle app initialization logic
  Future<void> initializeApp() async {
    trackUserAction('app_initialized');
    // Perform any initialization tasks here
    // E.g., check authentication status, load preferences, etc.
  }

  // Navigate to welcome screen
  void navigateToWelcome() {
    trackNavigation('welcome');
    NavigationService().toWelcome();
  }
}
