import 'package:flutter/material.dart';
import 'package:ilabs_assignment/models/user_model.dart';
import 'package:ilabs_assignment/view_model/base_view_model.dart';

// This is a test helper file only used for tests
// It provides a testable version of ProfileViewModel that implements
// the same interface but uses synchronous methods for testing

import 'package:ilabs_assignment/view_model/profile_view_model.dart';

class TestableProfileViewModel extends BaseViewModel
    implements ProfileViewModel {
  // Mock data for testing
  UserModel? user;
  String _errorMessage = '';
  String get error => errorMessage;
  // Mock analytics data - implementing getters for ProfileViewModel
  @override
  int get profileViews => 111;

  @override
  int get postImpressions => 500;

  @override
  int get searchAppearances => 85;

  @override
  bool get creatorMode => _creatorMode;

  // Internal tracking for creatorMode toggle
  bool _creatorMode = true;
  // Mock experiences
  final List<Map<String, dynamic>> _experiences = [
    {
      'company': 'iLabs Technologies',
      'role': 'Flutter Developer',
      'duration': 'May 2023 - Present · 1 yr 1 mo',
      'location': 'Bangalore, Karnataka, India',
      'description':
          'Working on cutting-edge mobile applications using Flutter and Dart.',
      'logo': 'https://example.com/logo.png',
    },
    {
      'company': 'TechInnovate Solutions',
      'role': 'Junior Mobile Developer',
      'duration': 'Jun 2022 - Apr 2023 · 11 mo',
      'location': 'Bangalore, Karnataka, India',
      'description':
          'Worked on mobile app development focusing on UI/UX implementation.',
      'logo': 'https://example.com/logo2.png',
    },
    {
      'company': 'CodeCraft Academy',
      'role': 'Mobile Development Intern',
      'duration': 'Jan 2022 - May 2022 · 5 mo',
      'location': 'Bangalore, Karnataka, India',
      'description': 'Assisted in development of mobile applications.',
      'logo': 'https://example.com/logo3.png',
    }
  ];

  // Get experiences (implementing ProfileViewModel method)
  @override
  List<Map<String, dynamic>> getExperiences({int limit = 100}) {
    return _experiences.take(limit).toList();
  }

  @override
  Future<int> get experienceCount async => _experiences.length;

  // Mock activities
  final List<Map<String, dynamic>> _activities = [
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
  ]; // For tests - synchronous implementation for testing
  @override
  Future<List<Map<String, dynamic>>> get activities =>
      Future.value(_activities);
  // Required ProfileViewModel methods
  @override
  void setUser(UserModel u) {
    user = u;
    notifyListeners();
  }

  @override
  int getFollowersCount() {
    return user?.followers ?? 4413;
  }

  @override
  String getConnectionsText() {
    if (user == null) return "0 connections";
    return user!.connections > 500
        ? '500+ connections'
        : '${user!.connections} connections';
  }

  @override
  Future<void> toggleCreatorMode() async {
    _creatorMode = !_creatorMode; // Invert the value for tests
    notifyListeners();
    return Future.value();
  }

  @override
  Future<void> refreshProfileData() async {
    setLoading(true);
    // Simulate a network delay for tests
    await Future.delayed(const Duration(milliseconds: 50));
    setLoading(false);
    notifyListeners();
  }

  @override
  Future<void> refreshProfileStats() async {
    setLoading(true);
    await Future.delayed(const Duration(milliseconds: 50));
    setLoading(false);
    notifyListeners();
  }

  @override
  Future<void> loadExperiences() async {
    setLoading(true);
    await Future.delayed(const Duration(milliseconds: 50));
    setLoading(false);
    notifyListeners();
  }

  // Helper method for tests
  void setError(String error) {
    _errorMessage = error;
    notifyListeners();
  }

  @override
  Future<bool> addExperience(Map<String, dynamic> experience) async {
    _experiences.add(experience);
    notifyListeners();
    return true;
  }

  @override
  void createPost(String postContent) {
    _activities.add({
      'type': 'post',
      'title': 'New Post',
      'content': postContent,
    });
    notifyListeners();
  }

  @override
  Future<bool> updateProfile({String? headline, String? profileImage}) async {
    if (user != null) {
      // Update user with the provided profile data
      // This is a simple implementation for testing
      user = UserModel(
        email: user!.email,
        password: user!.password,
        name: user!.name,
        headline: headline ?? user!.headline,
        company: user!.company,
        location: user!.location,
        profileImage: profileImage ?? user!.profileImage,
        bannerImage: user!.bannerImage,
        connections: user!.connections,
        followers: user!.followers,
        talkingAbout: user!.talkingAbout,
      );
      notifyListeners();
    }
    return true;
  }
}
