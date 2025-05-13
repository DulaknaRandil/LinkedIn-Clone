import 'package:flutter/material.dart';
import '../widgets/linkedin_story_circle.dart';
import '../../services/analytics_service.dart';
import '../../services/service_locator.dart';

class LinkedInStoriesSection extends StatelessWidget {
  LinkedInStoriesSection({Key? key}) : super(key: key);

  final AnalyticsService _analytics = locator<AnalyticsService>();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color.fromARGB(250, 250, 255, 255),
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Row(
          children: [
            LinkedInStoryCircle(
              imageUrl: 'https://randomuser.me/api/portraits/men/32.jpg',
              isYou: true,
              onTap: () => _analytics.trackEvent('your_story_tap'),
            ),
            LinkedInStoryCircle(
              imageUrl: 'https://randomuser.me/api/portraits/men/33.jpg',
              name: 'David',
              onTap: () => _analytics
                  .trackEvent('story_tap', parameters: {'user': 'David'}),
            ),
            LinkedInStoryCircle(
              imageUrl: 'https://randomuser.me/api/portraits/women/44.jpg',
              name: 'Sarah',
              onTap: () => _analytics
                  .trackEvent('story_tap', parameters: {'user': 'Sarah'}),
            ),
            LinkedInStoryCircle(
              imageUrl: 'https://randomuser.me/api/portraits/men/45.jpg',
              name: 'Michael',
              onTap: () => _analytics
                  .trackEvent('story_tap', parameters: {'user': 'Michael'}),
            ),
            LinkedInStoryCircle(
              imageUrl: 'https://randomuser.me/api/portraits/women/46.jpg',
              name: 'Emma',
              onTap: () => _analytics
                  .trackEvent('story_tap', parameters: {'user': 'Emma'}),
            ),
            LinkedInStoryCircle(
              imageUrl: 'https://randomuser.me/api/portraits/men/47.jpg',
              name: 'John',
              onTap: () => _analytics
                  .trackEvent('story_tap', parameters: {'user': 'John'}),
            ),
          ],
        ),
      ),
    );
  }
}
