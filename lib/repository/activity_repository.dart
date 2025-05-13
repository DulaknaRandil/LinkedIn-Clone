import 'package:flutter/foundation.dart';
import '../services/data_service.dart';

/// Repository responsible for managing activity data
class ActivityRepository {
  // Data service for fetching activity data
  final DataService _dataService = DataService();

  // Cache of activities data
  List<Map<String, dynamic>>? _activitiesCache;

  /// Get a list of user activities
  Future<List<Map<String, dynamic>>> getActivities() async {
    if (_activitiesCache == null) {
      _activitiesCache = await _dataService.getActivitiesData();
    }
    return List.from(_activitiesCache!);
  }

  /// Get activities synchronously (from cache only)
  List<Map<String, dynamic>> getActivitiesSync() {
    return _activitiesCache != null ? List.from(_activitiesCache!) : [];
  }

  /// Add a new activity
  Future<void> addActivity(Map<String, dynamic> activity) async {
    if (_activitiesCache == null) {
      _activitiesCache = await _dataService.getActivitiesData();
    }
    _activitiesCache!.insert(0, activity);
    debugPrint('Activity added: ${activity['title']}');

    // In a real app, we would make an API call here
    // For demonstration purposes, we're just updating the cache
  }

  /// Get the total count of activities
  Future<int> getActivityCount() async {
    if (_activitiesCache == null) {
      _activitiesCache = await _dataService.getActivitiesData();
    }
    return _activitiesCache!.length;
  }

  /// Get activity count synchronously (from cache only)
  int getActivityCountSync() {
    return _activitiesCache?.length ?? 0;
  }
}
