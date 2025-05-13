import 'package:flutter/foundation.dart';

/// Service responsible for providing data to repositories
/// In a real app, this would fetch data from APIs or databases
class DataService {
  // Singleton pattern
  static final DataService _instance = DataService._internal();
  factory DataService() => _instance;
  DataService._internal();

  /// Get user experiences data
  Future<List<Map<String, dynamic>>> getExperiencesData() async {
    // Simulate network delay in non-test environment
    if (!const bool.fromEnvironment('FLUTTER_TEST', defaultValue: false)) {
      await Future.delayed(const Duration(milliseconds: 300));
    }

    return [
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
    ];
  }

  /// Get user activities data
  Future<List<Map<String, dynamic>>> getActivitiesData() async {
    // Simulate network delay in non-test environment
    if (!const bool.fromEnvironment('FLUTTER_TEST', defaultValue: false)) {
      await Future.delayed(const Duration(milliseconds: 300));
    }

    return [
      {
        'type': 'post',
        'title': 'Flutter Development Best Practices',
        'content':
            'Just published an article about MVVM architecture in Flutter and how it can improve code maintainability.'
      },
      {
        'type': 'share',
        'title': 'Clean Architecture in Mobile Development',
        'content':
            'Check out this great article about clean architecture in Flutter!'
      },
      {
        'type': 'comment',
        'title': 'Response to Flutter State Management',
        'content':
            'Provider combined with ChangeNotifier has become my go-to solution for most projects.'
      }
    ];
  }

  /// Get analytics data
  Future<Map<String, dynamic>> getAnalyticsData() async {
    // Simulate network delay in non-test environment
    if (!const bool.fromEnvironment('FLUTTER_TEST', defaultValue: false)) {
      await Future.delayed(const Duration(milliseconds: 300));
    }

    return {
      'profileViews': 111,
      'postImpressions': 500,
      'searchAppearances': 85,
      'creatorMode': true
    };
  }

  /// Update analytics with new data (simulated)
  Future<Map<String, dynamic>> refreshAnalytics(
      Map<String, dynamic> currentData) async {
    // Simulate network delay in non-test environment
    if (!const bool.fromEnvironment('FLUTTER_TEST', defaultValue: false)) {
      await Future.delayed(const Duration(milliseconds: 500));
    }

    return {
      'profileViews': currentData['profileViews'] + 5,
      'postImpressions': currentData['postImpressions'] + 12,
      'searchAppearances': currentData['searchAppearances'] + 3,
      'creatorMode': currentData['creatorMode']
    };
  }
}
