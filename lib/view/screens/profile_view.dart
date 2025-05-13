import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../view_model/auth_view_model.dart';
import '../../view_model/profile_view_model.dart';
import '../widgets/profile_widgets/profile_header.dart';
import '../widgets/profile_widgets/profile_info.dart';
import '../widgets/profile_widgets/dashboard_card.dart';
import '../widgets/profile_widgets/open_to_work_card.dart';
import '../widgets/profile_widgets/activity_card.dart';
import '../widgets/profile_widgets/connection_analytics_widget.dart';
import '../widgets/loading_overlay.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<AuthViewModel>(context).user;
    final profileViewModel = Provider.of<ProfileViewModel>(context);

    if (user == null) {
      return const Scaffold(
        body: Center(child: Text('No user found.')),
      );
    }

    // Set user in profile view model if not already set
    if (profileViewModel.user == null) {
      profileViewModel.setUser(user);
    }

    // LinkedIn blue color - consistent across the app
    const linkedInBlue = Color(0xFF0077B5);
    return LoadingOverlay(
      isLoading: profileViewModel.isLoading,
      message: 'Loading profile...',
      child: Scaffold(
        backgroundColor: Colors.grey[100],
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 1,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            color: Colors.black87,
            onPressed: () => Navigator.pop(context),
          ),
          titleSpacing: 0,
          title: Container(
            height: 36,
            margin: const EdgeInsets.only(right: 8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
              color: Colors.grey[200],
            ),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search',
                hintStyle: TextStyle(
                  fontSize: 14,
                  color: Colors.grey[700],
                ),
                prefixIcon: Padding(
                  padding: const EdgeInsets.only(left: 10.0, right: 4.0),
                  child: Icon(Icons.search, color: Colors.grey[700], size: 20),
                ),
                prefixIconConstraints:
                    const BoxConstraints(minWidth: 32, maxHeight: 32),
                border: InputBorder.none,
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 14, horizontal: 2),
              ),
            ),
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.settings, color: Colors.black87),
              onPressed: () {},
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              // Profile Header with Banner and Profile Picture
              Container(
                height: 415,
                child: Stack(
                  children: [
                    // Header positioned at the top (default stack positioning)

                    // Profile Information Section
                    Positioned(
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: ProfileInfo(
                        user: user,
                        linkedInBlue: linkedInBlue,
                      ),
                    ),

                    Positioned(
                      top: 0,
                      left: 0,
                      right: 0,
                      child: ProfileHeader(
                        user: user,
                        linkedInBlue: linkedInBlue,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 12),

              // Open to Work Section
              OpenToWorkCard(
                linkedInBlue: linkedInBlue,
              ),

              const SizedBox(height: 12),

              // Dashboard Section with Analytics
              DashboardCard(
                linkedInBlue: linkedInBlue,
              ),

              const SizedBox(height: 12),
              // Activity Section
              ActivityCard(
                user: user,
                linkedInBlue: linkedInBlue,
              ),
              const SizedBox(height: 12),
            ],
          ),
        ),
      ),
    );
  }
}
