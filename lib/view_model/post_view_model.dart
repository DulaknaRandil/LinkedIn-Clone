import 'package:flutter/material.dart';
import '../models/post_model.dart';
import '../repository/post_repository.dart';
import 'base_view_model.dart';

class PostViewModel extends BaseViewModel {
  final PostRepository _repo = PostRepository();

  // Individual post related properties
  PostModel? _selectedPost;
  PostModel? get selectedPost => _selectedPost;

  // Like post functionality
  bool isLiked = false;

  // Set the selected post for detail view
  void setSelectedPost(PostModel post) {
    _selectedPost = post;
    trackUserAction('post_selected', parameters: {'post_id': post.id});
    notifyListeners();
  }

  // Toggle like on a post
  void toggleLike(String postId) {
    isLiked = !isLiked;
    trackUserAction('post_like_toggled',
        parameters: {'post_id': postId, 'liked': isLiked});
    notifyListeners();
  }

  // Comment on a post
  Future<bool> addComment(String postId, String commentText) async {
    if (commentText.isEmpty) {
      setError('Comment text cannot be empty');
      return false;
    }

    final result = await handleApiCall(
      () async {
        // Simulate API call to add comment
        await Future.delayed(const Duration(milliseconds: 500));

        // In a real app, this would come from the API
        return true;
      },
      actionName: 'post_comment_added',
    );

    return result ?? false;
  }

  // Share a post
  Future<bool> sharePost(String postId) async {
    final result = await handleApiCall(
      () async {
        // Simulate API call to share post
        await Future.delayed(const Duration(milliseconds: 500));

        // In a real app, this would come from the API
        return true;
      },
      actionName: 'post_shared',
    );

    return result ?? false;
  }

  // Save post
  Future<bool> savePost(String postId) async {
    final result = await handleApiCall(
      () async {
        // Simulate API call to save post
        await Future.delayed(const Duration(milliseconds: 500));

        // In a real app, this would come from the API
        return true;
      },
      actionName: 'post_saved',
    );

    return result ?? false;
  }
}
