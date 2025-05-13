import 'package:flutter/foundation.dart';
import '../services/data_service.dart';

/// Repository responsible for managing experience data
class ExperienceRepository {
  // Data service for fetching experience data
  final DataService _dataService = DataService();

  // Cache of experiences data
  List<Map<String, dynamic>>? _experiencesCache;

  /// Get a list of experiences
  /// [limit] Optional parameter to limit the number of experiences returned
  Future<List<Map<String, dynamic>>> getExperiences({int limit = 100}) async {
    if (_experiencesCache == null) {
      _experiencesCache = await _dataService.getExperiencesData();
    }
    return _experiencesCache!.take(limit).toList();
  }

  /// Get a list of experiences synchronously (from cache only)
  /// This is used when we need immediate access without awaiting
  List<Map<String, dynamic>> getExperiencesSync({int limit = 100}) {
    return _experiencesCache?.take(limit).toList() ?? [];
  }

  /// Get the total count of experiences
  Future<int> getExperienceCount() async {
    if (_experiencesCache == null) {
      _experiencesCache = await _dataService.getExperiencesData();
    }
    return _experiencesCache!.length;
  }

  /// Get experience count synchronously (from cache only)
  int getExperienceCountSync() {
    return _experiencesCache?.length ?? 0;
  }

  /// Add a new experience
  Future<void> addExperience(Map<String, dynamic> experience) async {
    // In a real app, we'd make an API call here
    // For now, we'll just add it to our cache
    if (_experiencesCache == null) {
      _experiencesCache = await _dataService.getExperiencesData();
    }
    _experiencesCache!.insert(0, experience);

    // Log the action for debugging
    debugPrint(
        'Added new experience: ${experience['role']} at ${experience['company']}');
  }
}
