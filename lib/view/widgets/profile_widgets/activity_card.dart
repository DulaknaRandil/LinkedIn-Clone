import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../models/user_model.dart';
import '../../../view_model/profile_view_model.dart';

class ActivityCard extends StatelessWidget {
  final UserModel user;
  final Color linkedInBlue;

  const ActivityCard({
    super.key,
    required this.user,
    required this.linkedInBlue,
  });
  @override
  Widget build(BuildContext context) {
    final profileViewModel = Provider.of<ProfileViewModel>(context);

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey[300]!),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 2,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Activity',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextButton(
                onPressed: () {},
                style: TextButton.styleFrom(
                  foregroundColor: linkedInBlue,
                ),
                child: const Text(
                  'See all',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            '${profileViewModel.getFollowersCount()} followers',
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[600],
            ),
          ),
          const SizedBox(height: 16),
          // Sample Post
          const Text(
            'You haven\'t posted lately',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Recent posts you share or comment on will be displayed here',
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[600],
            ),
          ),
          const SizedBox(height: 16), // Create Post Button
          SizedBox(
            width: double.infinity,
            child: profileViewModel.isLoading
                ? const Center(child: CircularProgressIndicator())
                : OutlinedButton(
                    onPressed: () {
                      // Show create post dialog to demonstrate MVVM interaction
                      _showCreatePostDialog(context, profileViewModel);
                    },
                    style: OutlinedButton.styleFrom(
                      foregroundColor: linkedInBlue,
                      side: BorderSide(color: linkedInBlue),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 12),
                    ),
                    child: const Text(
                      'Create a post',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
          ),
        ],
      ),
    );
  }

  // Helper method to show create post dialog - demonstrates MVVM interaction
  void _showCreatePostDialog(BuildContext context, ProfileViewModel viewModel) {
    final TextEditingController postController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Create a post'),
        content: TextField(
          controller: postController,
          maxLines: 4,
          decoration: const InputDecoration(
            hintText: 'What would you like to talk about?',
            border: OutlineInputBorder(),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              'Cancel',
              style: TextStyle(color: Colors.grey[700]),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              if (postController.text.trim().isNotEmpty) {
                viewModel.createPost(postController.text);
                Navigator.pop(context);

                // Show success message
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Post created successfully!'),
                    backgroundColor: Color(0xFF0077B5),
                  ),
                );
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: linkedInBlue,
              foregroundColor: Colors.white,
            ),
            child: const Text('Post'),
          ),
        ],
      ),
    );
  }
}
