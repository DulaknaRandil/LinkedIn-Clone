import 'package:flutter/material.dart';
import '../models/user_model.dart';
import 'base_view_model.dart';

class ProfileViewModel extends BaseViewModel {
  // User data
  UserModel? user;
  String get error => errorMessage;

  // Experience data - in a real app this would come from a repository
  final List<Map<String, dynamic>> _experiences = [
    {
      'company': 'iLabs Technologies',
      'role': 'Flutter Developer',
      'duration': 'May 2023 - Present · 1 yr 1 mo',
      'location': 'Bangalore, Karnataka, India',
      'description':
          'Working on cutting-edge mobile applications using Flutter and Dart. Implementing MVVM architecture and state management solutions.',
      'logo':
          'https://media.licdn.com/dms/image/C560BAQHdAaarsO-eyA/company-logo_100_100/0/1630648892726?e=1702512000&v=beta&t=8l0n9X1yTzAw66K9DAfKoI9MudX5F_tijmPqG5xus4A',
    },
    {
      'company': 'TechInnovate Solutions',
      'role': 'Junior Mobile Developer',
      'duration': 'Jun 2022 - Apr 2023 · 11 mo',
      'location': 'Bangalore, Karnataka, India',
      'description':
          'Worked on mobile app development focusing on UI/UX implementation and integration with backend services.',
      'logo':
          'https://media.licdn.com/dms/image/C4D0BAQHiNSL4Or29cg/company-logo_100_100/0/1519856215226?e=1702512000&v=beta&t=KhXS2fNWSxLxCJ5w5YUYYsVTXl5K3JSlyBHmUI1yTbg',
    },
    {
      'company': 'CodeCraft Academy',
      'role': 'Mobile Development Intern',
      'duration': 'Jan 2022 - May 2022 · 5 mo',
      'location': 'Bangalore, Karnataka, India',
      'description':
          'Assisted in development of mobile applications and learned industry best practices.',
      'logo':
          'https://media.licdn.com/dms/image/C4D0BAQHiNSL4Or29cg/company-logo_100_100/0/1519856215226?e=1702512000&v=beta&t=KhXS2fNWSxLxCJ5w5YUYYsVTXl5K3JSlyBHmUI1yTbg',
    }
  ]; // Analytics data (would come from a repository in a real app)
  // Updated to match second screenshot
  int _profileViews = 111; // Updated to match second screenshot
  int _postImpressions = 500; // Updated to match second screenshot
  int _searchAppearances = 85; // Updated to match second screenshot
  bool _creatorMode = true;

  // Getters for analytics data
  int get profileViews => _profileViews;
  int get postImpressions => _postImpressions;
  int get searchAppearances => _searchAppearances;
  bool get creatorMode => _creatorMode;

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

  // Get experiences
  List<Map<String, dynamic>> getExperiences({int limit = 100}) {
    return _experiences.take(limit).toList();
  }

  // Get experience count
  int get experienceCount => _experiences.length;

  // Get user activities
  List<Map<String, dynamic>> get activities {
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

  // Add new experience (for demo purposes)
  void addExperience(Map<String, dynamic> experience) {
    _experiences.insert(0, experience);
    notifyListeners();

    // Track for analytics
    trackUserAction('experience_added', parameters: {
      'user_id': user?.email ?? 'unknown',
      'company': experience['company'],
    });
  }

  // Toggle creator mode
  void toggleCreatorMode() {
    _creatorMode = !_creatorMode;
    trackUserAction('creator_mode_toggled', parameters: {
      'user_id': user?.email ?? 'unknown',
      'enabled': _creatorMode.toString(),
    });
    notifyListeners();
  }

  // Refresh profile data
  void refreshProfileData() {
    setLoading(true);
    // Simulate API call to refresh profile data
    Future.delayed(const Duration(milliseconds: 800), () {
      // In a real app, we would fetch this data from a repository
      setLoading(false);
      notifyListeners();
    });
  }

  // Update profile stats (for demo purposes)
  void refreshProfileStats() {
    setLoading(true);
    // Simulate API call to refresh stats
    Future.delayed(const Duration(milliseconds: 800), () {
      // In a real app, we would fetch this data from a repository
      _profileViews += 5;
      _postImpressions += 12;
      _searchAppearances += 3;

      trackUserAction('profile_stats_refreshed', parameters: {
        'user_id': user?.email ?? 'unknown',
      });

      setLoading(false);
      notifyListeners();
    });
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
      // In a real app, this would create a post through a repository
      trackUserAction('post_created', parameters: {
        'user_id': user!.email,
        'content_length': content.length.toString(),
      });
      // Increment post impressions for the demo
      _postImpressions += 5;

      setLoading(false);
      notifyListeners();
    });
  }
}
