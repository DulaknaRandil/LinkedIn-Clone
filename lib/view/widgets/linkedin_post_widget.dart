import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:provider/provider.dart';
import '../widgets/linkedin_post_action_button.dart';
import '../../view_model/post_view_model.dart';
import '../../models/post_model.dart';

class LinkedInPostWidget extends StatelessWidget {
  final dynamic post;

  LinkedInPostWidget({
    Key? key,
    required this.post,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (post == null) {
      return const SizedBox.shrink();
    }

    bool isTonyPost = post.authorName == "Tony Antonio";
    bool isAndyPost = post.authorName == "Andy Ortega";

    return Container(
      color: Colors.white,
      margin: const EdgeInsets.only(bottom: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Post header
          _buildPostHeader(isTonyPost, isAndyPost),

          // Post content
          _buildPostContent(isTonyPost),

          // Post image
          _buildPostImage(),

          // Add more vertical space between image and stats
          const SizedBox(height: 8),

          // Engagement stats
          _buildEngagementStats(),

          // Divider
          const Divider(
            height: 0,
            thickness: 0.5,
            color: Color(0xFFE0E0E0),
          ),

          // Action buttons
          _buildActionButtons(context),
        ],
      ),
    );
  }

  Widget _buildPostHeader(bool isTonyPost, bool isAndyPost) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(12, 12, 8, 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 24,
            backgroundImage: NetworkImage(post.authorImage),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  post.authorName,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                    color: Color.fromRGBO(54, 105, 115, 1),
                  ),
                ),
                Text(
                  post.authorTitle,
                  style: const TextStyle(
                    color: Color.fromRGBO(54, 105, 115, 1),
                    fontSize: 14,
                  ),
                ),
                Row(
                  children: [
                    Text(
                      isTonyPost ? "2nd" : (isAndyPost ? "3d" : "1w"),
                      style: const TextStyle(
                        color: Color.fromRGBO(54, 105, 115, 1),
                        fontSize: 14,
                      ),
                    ),
                    if (isTonyPost)
                      const Text(
                        " • Edited",
                        style: TextStyle(
                          color: Color.fromRGBO(54, 105, 115, 1),
                          fontSize: 14,
                        ),
                      ),
                  ],
                ),
              ],
            ),
          ),
          IconButton(
            icon: const Icon(
              Icons.more_vert,
              size: 20,
            ),
            onPressed: () {},
            color: const Color.fromRGBO(54, 105, 115, 1),
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(),
            visualDensity: VisualDensity.compact,
          ),
        ],
      ),
    );
  }

  Widget _buildPostContent(bool isTonyPost) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(12, 4, 12, 10),
      child: isTonyPost
          ? RichText(
              text: const TextSpan(
                style: TextStyle(
                  fontSize: 15.0,
                  color: Color.fromRGBO(54, 105, 115, 1),
                  height: 1.3,
                ),
                children: [
                  TextSpan(
                    text:
                        'Creating opportunity for every member of the global workforce drives everything we do at Link... ',
                  ),
                  TextSpan(
                    text: 'see more',
                    style: TextStyle(
                      color: Color.fromARGB(255, 84, 151, 251),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            )
          : Text(
              post.content,
              style: const TextStyle(
                  fontSize: 13.5, color: Color.fromRGBO(54, 105, 115, 1)),
            ),
    );
  }

  Widget _buildPostImage() {
    if (post.postImage.isEmpty) {
      return const SizedBox.shrink();
    }

    return Padding(
      padding: const EdgeInsets.only(left: 20),
      child: Container(
        width: 350,
        constraints: const BoxConstraints(
          minHeight: 100,
          maxHeight: 250,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(40.0),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(40.0),
          child: Image.network(
            post.postImage,
            width: double.infinity,
            fit: BoxFit.contain,
          ),
        ),
      ),
    );
  }

  Widget _buildEngagementStats() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(12, 8, 12, 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              SizedBox(
                width: 45,
                height: 16,
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    for (int i = 0; i < 3; i++)
                      Positioned(
                        left: i * 12.0,
                        child: Container(
                          width: 16,
                          height: 16,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.white, width: 1.0),
                          ),
                          child: CircleAvatar(
                            radius: 7,
                            backgroundImage: NetworkImage(
                              "https://randomuser.me/api/portraits/men/${35 + i}.jpg",
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              if (post.likedBy != null)
                const Text(
                  "Liked by Budi and 97 others",
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w400,
                    color: Color.fromRGBO(54, 105, 115, 1),
                  ),
                ),
              if (post.likedBy == null)
                Text(
                  "${post.likes}",
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                    color: Color.fromRGBO(54, 105, 115, 1),
                  ),
                ),
            ],
          ),
          const Text(
            "77 comments",
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w400,
              color: Color.fromRGBO(54, 105, 115, 1),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButtons(BuildContext context) {
    final postViewModel = Provider.of<PostViewModel>(context, listen: false);

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.75,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                LinkedInPostActionButton(
                  icon: Icons.thumb_up_outlined,
                  onTap: () {
                    postViewModel.toggleLike(post.id);
                  },
                ),
                LinkedInPostActionButton(
                  icon: LucideIcons.messageCircleMore,
                  onTap: () => postViewModel.addComment(post.id, ''),
                ),
                LinkedInPostActionButton(
                  icon: HugeIcons.strokeRoundedLinkForward,
                  onTap: () => postViewModel.sharePost(post.id),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: LinkedInPostActionButton(
              icon: Icons.bookmark_border,
              onTap: () => postViewModel.savePost(post.id),
            ),
          ),
        ],
      ),
    );
  }
}
