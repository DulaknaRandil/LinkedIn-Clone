import 'package:flutter/material.dart';
import '../widgets/animated_like_button.dart';

class LinkedInPostCard extends StatelessWidget {
  final String authorName;
  final String authorTitle;
  final String authorImage;
  final String timeAgo;
  final String content;
  final String postImage;
  final int likes;
  final int comments;
  final bool isEdited;
  final String? likedBy;
  final int othersLiked;
  final VoidCallback onLike;
  final VoidCallback onComment;
  final VoidCallback onShare;
  final VoidCallback onSave;

  const LinkedInPostCard({
    super.key,
    required this.authorName,
    required this.authorTitle,
    required this.authorImage,
    required this.timeAgo,
    required this.content,
    required this.postImage,
    required this.likes,
    required this.comments,
    this.isEdited = false,
    this.likedBy,
    this.othersLiked = 0,
    required this.onLike,
    required this.onComment,
    required this.onShare,
    required this.onSave,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      margin: const EdgeInsets.only(bottom: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Post header
          Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  radius: 20,
                  backgroundImage: NetworkImage(authorImage),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        authorName,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      Text(
                        authorTitle,
                        style: TextStyle(
                          color: Colors.grey[700],
                          fontSize: 14,
                        ),
                      ),
                      Row(
                        children: [
                          Text(
                            timeAgo,
                            style: TextStyle(
                              color: Colors.grey[700],
                              fontSize: 12,
                            ),
                          ),
                          if (isEdited)
                            Text(
                              " • Edited",
                              style: TextStyle(
                                color: Colors.grey[700],
                                fontSize: 12,
                              ),
                            ),
                        ],
                      ),
                    ],
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.more_vert),
                  onPressed: () {},
                  color: Colors.grey[700],
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                  visualDensity: VisualDensity.compact,
                ),
              ],
            ),
          ),

          // Post content
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
            child: Text(
              content,
              style: const TextStyle(fontSize: 14),
            ),
          ),

          // Post image
          if (postImage.isNotEmpty)
            Image.network(
              postImage,
              width: double.infinity,
              height: 250,
              fit: BoxFit.cover,
            ),

          // Engagement stats
          Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              children: [
                Row(
                  children: [
                    for (int i = 0; i < 3; i++)
                      Container(
                        width: 18,
                        height: 18,
                        margin: EdgeInsets.only(right: i == 2 ? 4 : 0),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.white, width: 1),
                        ),
                        child: CircleAvatar(
                          radius: 8,
                          backgroundImage: NetworkImage(
                            "https://randomuser.me/api/portraits/men/${35 + i}.jpg",
                          ),
                        ),
                      ),
                  ],
                ),
                if (likedBy != null)
                  Text(
                    "Liked by $likedBy and $othersLiked others",
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey[700],
                    ),
                  ),
                if (likedBy == null)
                  Text(
                    "$likes",
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey[700],
                    ),
                  ),
                const Spacer(),
                Text(
                  "$comments comments",
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey[700],
                  ),
                ),
              ],
            ),
          ),

          // Divider
          Divider(height: 0, thickness: 0.5, color: Colors.grey[300]),

          // Action buttons
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildPostActionButton(
                  icon: AnimatedLikeButton(onTap: onLike),
                  label: 'Like',
                  onTap: onLike,
                ),
                _buildPostActionButton(
                  icon: Icon(Icons.mode_comment_outlined,
                      size: 18, color: Colors.grey[700]),
                  label: 'Comment',
                  onTap: onComment,
                ),
                _buildPostActionButton(
                  icon: Icon(Icons.repeat, size: 18, color: Colors.grey[700]),
                  label: 'Share',
                  onTap: onShare,
                ),
                _buildPostActionButton(
                  icon: Icon(Icons.bookmark_border,
                      size: 18, color: Colors.grey[700]),
                  label: 'Save',
                  onTap: onSave,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPostActionButton({
    required Widget icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return TextButton(
      onPressed: onTap,
      style: TextButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 8),
        minimumSize: Size.zero,
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
      ),
      child: Row(
        children: [
          icon,
          const SizedBox(width: 4),
          Text(
            label,
            style: TextStyle(fontSize: 12, color: Colors.grey[700]),
          ),
        ],
      ),
    );
  }
}
