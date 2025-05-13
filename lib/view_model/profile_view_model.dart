import 'package:flutter/material.dart';
import '../models/user_model.dart';
import '../repository/experience_repository.dart';
import '../repository/activity_repository.dart';
import '../repository/profile_analytics_repository.dart';
import 'base_view_model.dart';

class ProfileViewModel extends BaseViewModel {
  // User data
  UserModel? user;
  String get error => errorMessage;

  // Repositories
  final ExperienceRepository _experienceRepository = ExperienceRepository();
  final ActivityRepository _activityRepository = ActivityRepository();
  final ProfileAnalyticsRepository _analyticsRepository =
      ProfileAnalyticsRepository(); // Getters for analytics data (using sync methods for UI binding)
  int get profileViews => _analyticsRepository.getProfileViewsSync();
  int get postImpressions => _analyticsRepository.getPostImpressionsSync();
  int get searchAppearances => _analyticsRepository.getSearchAppearancesSync();
  bool get creatorMode => _analyticsRepository.getCreatorModeSync();

  // Set the user data and notify listeners
  void setUser(UserModel u) {
    user = u;
    trackUserAction('profile_viewed', parameters: {'user_id': u.email});
    notifyListeners();
  }

  // Get followers count
  int getFollowersCount() {
    if (user == null) return 0;
    return user!.followers > 0
        ? user!.followers
        : 4413; // Default to match the screenshot
  }

  // Get formatted connections count
  String getConnectionsText() {
    if (user == null) return "0 connections";
    return user!.connections > 500
        ? '500+ connections'
        : '${user!.connections} connections';
  }

  // Get experiences (uses sync method for immediate UI binding)
  List<Map<String, dynamic>> getExperiences({int limit = 100}) {
    return _experienceRepository.getExperiencesSync(limit: limit);
  }

  // Load experiences asynchronously and update UI when complete
  Future<void> loadExperiences() async {
    try {
      setLoading(true);
      await _experienceRepository.getExperiences();
      setLoading(false);
      notifyListeners();
    } catch (e) {
      setError('Failed to load experiences: $e');
      setLoading(false);
    }
  }

  // Get experience count
  Future<int> get experienceCount => _experienceRepository.getExperienceCount();

  // Get user activities
  Future<List<Map<String, dynamic>>> get activities {
    return _activityRepository.getActivities();
  }

  // Add new experience (for demo purposes)
  void addExperience(Map<String, dynamic> experience) {
    _experienceRepository.addExperience(experience);
    notifyListeners();

    // Track for analytics
    trackUserAction('experience_added', parameters: {
      'user_id': user?.email ?? 'unknown',
      'company': experience['company'],
    });
  }

  // Toggle creator mode
  Future<void> toggleCreatorMode() async {
    setLoading(true);

    try {
      await _analyticsRepository.toggleCreatorMode();
      trackUserAction('creator_mode_toggled', parameters: {
        'user_id': user?.email ?? 'unknown',
        'enabled': creatorMode.toString(),
      });
    } catch (e) {
      setError('Failed to toggle creator mode: $e');
    } finally {
      setLoading(false);
      notifyListeners();
    }
  }

  // Refresh profile data - loads all data from repositories
  Future<void> refreshProfileData() async {
    setLoading(true);

    try {
      // Load data from all repositories in parallel for better performance
      await Future.wait([
        _experienceRepository.getExperiences(),
        _activityRepository.getActivities(),
        _analyticsRepository.refreshAnalytics(),
      ]);

      trackUserAction('profile_data_refreshed');
    } catch (e) {
      setError('Failed to refresh profile data: $e');
    } finally {
      setLoading(false);
      notifyListeners();
    }
  }

  // Update profile stats (for demo purposes)
  void refreshProfileStats() async {
    setLoading(true);

    try {
      // Call repository to refresh analytics data
      await _analyticsRepository.refreshAnalytics();

      trackUserAction('profile_stats_refreshed', parameters: {
        'user_id': user?.email ?? 'unknown',
      });
    } finally {
      setLoading(false);
      notifyListeners();
    }
  }

  // Method to update user profile
  Future<bool> updateProfile({String? headline, String? profileImage}) async {
    if (user == null) return false;

    setLoading(true);

    try {
      // Simulate API call
      await Future.delayed(const Duration(milliseconds: 800));
      // In a real app, this would update the user data through a repository

      if (headline != null) {
        // For demo, we'll just pretend it's updated
        // In a real app, we'd update the user model and persist changes
      }

      if (profileImage != null) {
        // For demo, we'll just pretend it's updated
        // In a real app, we'd update the user model and persist changes
      }

      trackUserAction('profile_updated', parameters: {
        'user_id': user!.email,
        'fields_updated': [
          if (headline != null) 'headline',
          if (profileImage != null) 'profile_image',
        ].join(','),
      });

      setLoading(false);
      notifyListeners();
      return true;
    } catch (e) {
      setError('Failed to update profile: ${e.toString()}');
      setLoading(false);
      return false;
    }
  }

  // Method to create a new post (just for UI demo)
  void createPost(String content) {
    if (user == null) return;

    setLoading(true);

    // Simulate API call
    Future.delayed(const Duration(milliseconds: 1000), () {
      // Create new activity
      _activityRepository.addActivity(
          {'type': 'post', 'title': 'New Post', 'content': content});

      // Increment post impressions for the demo
      _analyticsRepository.incrementPostImpressions(5);

      trackUserAction('post_created', parameters: {
        'user_id': user!.email,
        'content_length': content.length.toString(),
      });

      setLoading(false);
      notifyListeners();
    });
  }
}
