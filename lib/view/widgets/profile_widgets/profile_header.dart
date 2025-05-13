import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import '../../../models/user_model.dart';
import '../network_image_mock.dart';

class ProfileHeader extends StatelessWidget {
  final UserModel user;
  final Color linkedInBlue;

  const ProfileHeader({
    super.key,
    required this.user,
    required this.linkedInBlue,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Banner and Profile Image
          Stack(
            clipBehavior: Clip.none,
            children: [
              // Banner Image
              Container(
                height: 150,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                ),
                child: Stack(
                  children: [
                    // Background image - using test-friendly approach
                    kIsWeb ||
                            !const bool.fromEnvironment('FLUTTER_TEST',
                                defaultValue: false)
                        ? Image.network(
                            user.bannerImage.isNotEmpty
                                ? user.bannerImage
                                : 'https://img.freepik.com/free-photo/abstract-blur-bokeh-background_1150-6153.jpg',
                            width: double.infinity,
                            height: 150,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return Container(
                                width: double.infinity,
                                height: 150,
                                color: Colors.grey[300],
                              );
                            },
                          )
                        : NetworkImageMock(
                            imageUrl: user.bannerImage,
                            width: double.infinity,
                            height: 150,
                          ),
                    // Gradient overlay for better text visibility
                    Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.transparent,
                            Colors.black.withOpacity(0.5),
                          ],
                        ),
                      ),
                    ), // Quote overlay - styled to match second screenshot
                    Positioned(
                      bottom: 10,
                      right: 15,
                      child: Row(
                        children: [
                          Text(
                            'All things are possible if you',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              shadows: [
                                Shadow(
                                  offset: const Offset(0, 1),
                                  blurRadius: 3.0,
                                  color: Colors.black.withOpacity(0.5),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 4),
                          Text(
                            'believe',
                            style: TextStyle(
                              color: Colors.white,
                              fontStyle: FontStyle.italic,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              shadows: [
                                Shadow(
                                  offset: const Offset(0, 1),
                                  blurRadius: 3.0,
                                  color: Colors.black.withOpacity(0.5),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              // Profile Image
              Positioned(
                bottom: -50,
                left: 16,
                child: Stack(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white, width: 4),
                      ),
                      child: kIsWeb ||
                              !const bool.fromEnvironment('FLUTTER_TEST',
                                  defaultValue: false)
                          ? CircleAvatar(
                              radius: 48,
                              backgroundImage: NetworkImage(user.profileImage),
                              onBackgroundImageError: (exception, stackTrace) {
                                // Handle error loading image
                                debugPrint(
                                    'Error loading profile image: $exception');
                              },
                            )
                          : CircleAvatar(
                              radius: 48,
                              backgroundColor: Colors.grey[300],
                              child: Icon(
                                Icons.person,
                                size: 48,
                                color: Colors.grey[600],
                              ),
                            ),
                    ), // Plus Icon - to match the second screenshot
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: Container(
                        padding: const EdgeInsets.all(2),
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                        ),
                        child: CircleAvatar(
                          radius: 16,
                          backgroundColor: linkedInBlue,
                          child: const Icon(
                            Icons.add,
                            color: Colors.white,
                            size: 18,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ), // Banner Edit Button
              Positioned(
                top: 10,
                right: 10,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.grey.shade300, width: 1),
                  ),
                  child: IconButton(
                    padding: const EdgeInsets.all(8),
                    constraints: const BoxConstraints(),
                    icon: Icon(
                      Icons.edit,
                      color: linkedInBlue,
                      size: 20,
                    ),
                    onPressed: () {},
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
