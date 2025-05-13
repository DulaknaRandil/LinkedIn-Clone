import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../view_model/profile_view_model.dart';

class DashboardCard extends StatelessWidget {
  final Color linkedInBlue;

  const DashboardCard({
    super.key,
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
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 1,
            blurRadius: 3,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Dashboard Header
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Your Dashboard',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.grey[100],
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      children: [
                        Text(
                          'Private to you',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey[600],
                          ),
                        ),
                        const SizedBox(width: 4),
                        Icon(
                          Icons.star,
                          color: Colors.amber[700],
                          size: 16,
                        ),
                        const SizedBox(width: 2),
                        Text(
                          'ALL-STAR',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey[800],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(
                  height:
                      8), // Showing loading indicator when stats are refreshing
              if (profileViewModel.isLoading)
                const Center(child: CircularProgressIndicator()),
            ],
          ),
          const SizedBox(height: 16),
          // Stats Row - matches screenshot numbers
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.grey[300]!),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  spreadRadius: 1,
                  blurRadius: 3,
                  offset: const Offset(0, 1),
                ),
              ],
            ),
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Who viewed your profile
                _buildStatItem(profileViewModel.profileViews.toString(),
                    'Who viewed your profile'),

                // Divider
                Container(
                  height: 50,
                  width: 1,
                  color: Colors.grey[300],
                ),

                // Post Views
                _buildStatItem(profileViewModel.postImpressions.toString(),
                    'Post impressions'),

                // Divider
                Container(
                  height: 50,
                  width: 1,
                  color: Colors.grey[300],
                ),

                // Search appearances
                _buildStatItem(profileViewModel.searchAppearances.toString(),
                    ' Search appearances'),
              ],
            ),
          ),
          const SizedBox(height: 24),
          const Divider(thickness: 1.2),
          const SizedBox(height: 16),

          // Creator Mode
          Row(
            children: [
              Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: linkedInBlue,
                ),
                padding: const EdgeInsets.all(6),
                child: const Text(
                  'in',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Creator mode: On',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        Switch(
                          value: profileViewModel.creatorMode,
                          activeColor: linkedInBlue,
                          onChanged: (bool value) {
                            profileViewModel.toggleCreatorMode();
                          },
                        ),
                      ],
                    ),
                    Text(
                      'Get discovered, showcase content on your profile',
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatItem(String value, String label) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              value,
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: linkedInBlue,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey[700],
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
