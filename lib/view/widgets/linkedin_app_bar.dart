import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';

class LinkedInAppBar extends StatelessWidget implements PreferredSizeWidget {
  final VoidCallback onProfileTap;
  final VoidCallback onSearchTap;
  final VoidCallback onMessageTap;

  const LinkedInAppBar({
    super.key,
    required this.onProfileTap,
    required this.onSearchTap,
    required this.onMessageTap,
  });

  @override
  Size get preferredSize =>
      const Size.fromHeight(104); // Increased height to include search bar

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color.fromARGB(250, 250, 255, 255),
      child: SafeArea(
        child: Column(
          children: [
            // Main app bar content
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: Row(
                children: [
                  // Profile picture
                  GestureDetector(
                    onTap: onProfileTap,
                    child: Hero(
                      tag: 'profile-image',
                      child: CircleAvatar(
                        radius: 16,
                        backgroundImage: const NetworkImage(
                          'https://randomuser.me/api/portraits/men/32.jpg',
                        ),
                      ),
                    ),
                  ),

                  const Spacer(), // LinkedIn logo
                  Row(
                    children: [
                      const SizedBox(width: 4),
                      Text(
                        'Linked',
                        style: TextStyle(
                          color: const Color(
                              0xFF0077B5), // Exact LinkedIn brand blue
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 2.0, vertical: 1.0),
                        decoration: const BoxDecoration(
                          color: Color(
                              0xFF0077B5), // Exact LinkedIn brand blue for the logo
                          borderRadius: BorderRadius.all(Radius.circular(2)),
                        ),
                        child: const Text(
                          'in',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ],
                  ),

                  const Spacer(),

                  // Notification icon
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      IconButton(
                        icon: Icon(
                          HugeIcons.strokeRoundedNotification02,
                          color: Color(0xFF0077B5).withAlpha(120),
                          size: 24,
                        ),
                        onPressed: onMessageTap,
                        padding: EdgeInsets.zero,
                        constraints: BoxConstraints(),
                      ),
                      Positioned(
                        top: 2,
                        right: 2,
                        child: Container(
                          width: 8,
                          height: 8,
                          decoration: const BoxDecoration(
                            color: Color(
                                0xFFFF7A59), // LinkedIn notification color
                            shape: BoxShape.circle,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Search bar
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: Container(
                height: 36,
                decoration: BoxDecoration(
                  color: Color.fromARGB(60, 214, 200, 200),
                  borderRadius: BorderRadius.circular(4.0),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Row(
                  children: [
                    Icon(
                      HugeIcons.strokeRoundedSearch01,
                      color: Color.fromRGBO(54, 105, 115, 1),
                      size: 22,
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        "Try \"Android Dev\"",
                        style: TextStyle(
                          color: Color.fromRGBO(54, 105, 115, 1),
                          fontSize: 16,
                        ),
                      ),
                    ),
                    Icon(
                      Icons.qr_code_scanner_outlined,
                      color: Color.fromRGBO(54, 105, 115, 1),
                      size: 22,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
