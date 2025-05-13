import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import '../../view_model/home_view_model.dart';
import '../../services/analytics_service.dart';
import '../../services/service_locator.dart';
import '../../routing/navigation_service.dart';
import '../widgets/linkedin_staggered_animation.dart';
import '../widgets/linkedin_shimmer_loading.dart';
import '../widgets/linkedin_refresh_indicator.dart';
import '../widgets/linkedin_app_bar.dart';
import '../widgets/linkedin_stories_section.dart';
import '../widgets/linkedin_bottom_navigation_with_fab.dart';
import '../widgets/linkedin_post_widget.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});
  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  int _currentIndex = 0;
  final AnalyticsService _analytics = locator<AnalyticsService>();

  @override
  void initState() {
    super.initState();
    // Use addPostFrameCallback to avoid calling setState during build
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<HomeViewModel>(context, listen: false).fetchPosts();
    });
    _analytics.trackScreenView('Home');
  }

  @override
  Widget build(BuildContext context) {
    final homeVm = Provider.of<HomeViewModel>(context);
    return Scaffold(
      backgroundColor: const Color.fromARGB(
          250, 250, 255, 255), // Light blue background color
      appBar: LinkedInAppBar(
        onProfileTap: () {
          _analytics.trackEvent('profile_tap');
          NavigationService().toProfile();
        },
        onSearchTap: () {
          _analytics.trackEvent('search_tap');
          // Navigate to search page
        },
        onMessageTap: () {
          _analytics.trackEvent('messages_tap');
          // Navigate to messages page
        },
      ),
      body: Column(
        children: [
          // Story circles at the top
          LinkedInStoriesSection(),

          // Posts (Scrollable content)
          Expanded(
            child: homeVm.isLoading
                ? ListView.builder(
                    padding: const EdgeInsets.only(top: 8),
                    itemCount: 3,
                    itemBuilder: (context, index) =>
                        const LinkedInPostLoading(),
                  )
                : homeVm.error.isNotEmpty
                    ? Center(child: Text(homeVm.error))
                    : LinkedInRefreshIndicator(
                        onRefresh: () {
                          _analytics.trackEvent('pull_to_refresh');
                          return Provider.of<HomeViewModel>(context,
                                  listen: false)
                              .fetchPosts();
                        },
                        child: ListView.builder(
                          padding: const EdgeInsets.only(top: 8),
                          physics: const AlwaysScrollableScrollPhysics(),
                          itemCount: homeVm.posts.length,
                          itemBuilder: (context, index) {
                            final post = homeVm.posts[index];
                            return LinkedInStaggeredAnimation(
                              index: index,
                              child: LinkedInPostWidget(post: post),
                            );
                          },
                        ),
                      ),
          ),
        ],
      ),
      bottomNavigationBar: LinkedInBottomNavigationWithFab(
        selectedIndex: _currentIndex,
        onItemTapped: (index) {
          if (index == 2) return;

          setState(() {
            _currentIndex = index;
          });

          _analytics.trackEvent(
            'navigation_tap',
            parameters: {
              'screen': [
                'Home',
                'My Network',
                'Post',
                'Notifications',
                'Jobs'
              ][index]
            },
          );
        },
      ),
      floatingActionButton: Transform.translate(
        offset: const Offset(0, -2), // Move FAB up slightly
        child: Container(
          width: 56,
          height: 56,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(
                20), // Squared corners with slight rounding
            color: const Color(0xFF0077B5), // LinkedIn blue
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                spreadRadius: 1,
                blurRadius: 4,
                offset: const Offset(0, 1),
              ),
            ],
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: () {
                HapticFeedback.mediumImpact();
                setState(() {
                  _currentIndex = 2; // Set current index to 2 for "Post"
                });
                _analytics.trackEvent('fab_post_tap');
              },
              borderRadius: BorderRadius.circular(4),
              child: const Icon(
                Icons.add,
                color: Colors.white,
                size: 28,
              ),
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      extendBody: true, // Makes the body extend under the bottom app bar
    );
  }
}
