import 'package:flutter/material.dart';
import '../services/analytics_service.dart';
import '../services/service_locator.dart';

class BaseViewModel extends ChangeNotifier {
  final analytics = locator<AnalyticsService>();
  bool _isLoading = false;
  String _errorMessage = '';

  bool get isLoading => _isLoading;
  String get errorMessage => _errorMessage;

  // Helper methods for common view model tasks
  void setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }

  void setError(String error) {
    _errorMessage = error;
    notifyListeners();
  }

  void clearError() {
    _errorMessage = '';
    notifyListeners();
  }

  // Method to track navigation events
  void trackNavigation(String destination) {
    analytics.trackEvent('navigation', parameters: {'to': destination});
  }

  // Method to track user actions
  void trackUserAction(String action, {Map<String, dynamic>? parameters}) {
    analytics.trackEvent(action, parameters: parameters);
  }

  // Helper to handle API calls with loading state and error handling
  Future<T?> handleApiCall<T>(Future<T> Function() apiCall,
      {String? actionName}) async {
    try {
      setLoading(true);
      clearError();
      final result = await apiCall();
      if (actionName != null) {
        trackUserAction(actionName, parameters: {'success': true});
      }
      return result;
    } catch (e) {
      setError(e.toString());
      if (actionName != null) {
        trackUserAction(actionName,
            parameters: {'success': false, 'error': e.toString()});
      }
      return null;
    } finally {
      setLoading(false);
    }
  }
}
