import 'package:flutter/material.dart';
import '../models/post_model.dart';
import '../repository/post_repository.dart';
import 'base_view_model.dart';

class HomeViewModel extends BaseViewModel {
  final PostRepository _repo = PostRepository();

  List<PostModel> posts = [];
  String get error => errorMessage;
  Future<void> fetchPosts() async {
    final result = await handleApiCall(
      () => _repo.getPosts(),
      actionName: 'posts_fetched',
    );

    if (result != null) {
      posts = result;
      trackUserAction('posts_fetched', parameters: {'count': posts.length});
    }
  }

  void likePost(String postId) {
    // In a real app, this would call the repository to like a post
    analytics.trackPostEngagement(postId, 'like');
    notifyListeners();
  }

  void commentOnPost(String postId, String comment) {
    // In a real app, this would call the repository to add a comment
    analytics.trackPostEngagement(postId, 'comment');
    notifyListeners();
  }

  void sharePost(String postId) {
    // In a real app, this would call the repository to share a post
    analytics.trackPostEngagement(postId, 'share');
    notifyListeners();
  }

  void savePost(String postId) {
    // In a real app, this would call the repository to save a post
    analytics.trackPostEngagement(postId, 'save');
    notifyListeners();
  }
}
