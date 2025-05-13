import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // For HapticFeedback
import 'package:hugeicons/hugeicons.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'notification_badge.dart';

class LinkedInBottomNavigationWithFab extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onItemTapped;

  final List<Map<String, dynamic>> navItemsData = [
    {
      'icon': HugeIcons.strokeRoundedHome11,
      'selectedIcon': HugeIcons.strokeRoundedHome11,
      'index': 0
    },
    {
      'icon': LucideIcons.usersRound,
      'selectedIcon': LucideIcons.usersRound400,
      'index': 1
    },
    // Index 2 is reserved for the FloatingActionButton
    {
      'icon': HugeIcons.strokeRoundedMessage02,
      'selectedIcon': HugeIcons.strokeRoundedMessage02,
      'index': 3,
      'showBadge': true,
      'badgeCount': 2
    },
    {
      'icon': HugeIcons.strokeRoundedBriefcase01,
      'selectedIcon': HugeIcons.strokeRoundedBriefcase01,
      'index': 4
    },
  ];

  LinkedInBottomNavigationWithFab({
    Key? key,
    required this.selectedIndex,
    required this.onItemTapped,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Color linkedInBlue =
        const Color(0xFF0077B5); // Exact LinkedIn brand blue

    return BottomAppBar(
      shape: const AutomaticNotchedShape(
        RoundedRectangleBorder(),
        RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
      ), // Creates a squared notch for the squared FAB
      notchMargin: 8.0, // Margin around the FAB
      color: const Color.fromARGB(255, 247, 246, 246),
      elevation: 6.0,
      child: Container(
        height: 50,
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            _buildNavItem(
              context,
              itemData: navItemsData[0],
              isSelected: selectedIndex == navItemsData[0]['index'],
              activeColor: linkedInBlue,
            ),
            _buildNavItem(
              context,
              itemData: navItemsData[1],
              isSelected: selectedIndex == navItemsData[1]['index'],
              activeColor: linkedInBlue,
            ),
            // Empty space for FAB
            SizedBox(width: 60),
            _buildNavItem(
              context,
              itemData: navItemsData[2], // Notifications
              isSelected: selectedIndex == navItemsData[2]['index'],
              activeColor: linkedInBlue,
            ),
            _buildNavItem(
              context,
              itemData: navItemsData[3], // Jobs
              isSelected: selectedIndex == navItemsData[3]['index'],
              activeColor: linkedInBlue,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNavItem(
    BuildContext context, {
    required Map<String, dynamic> itemData,
    required bool isSelected,
    required Color activeColor,
  }) {
    final IconData icon = itemData['icon'] as IconData;
    final IconData selectedIcon = itemData['selectedIcon'] as IconData;
    final int itemIndex = itemData['index'] as int;
    final bool showBadge = itemData['showBadge'] ?? false;
    final int badgeCount = itemData['badgeCount'] ?? 0;

    return InkWell(
      onTap: () {
        HapticFeedback.lightImpact(); // Subtle haptic feedback
        onItemTapped(itemIndex);
      },
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            width: 45,
            height: 50,
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Icon(
              isSelected ? selectedIcon : icon,
              color: isSelected ? activeColor : Colors.grey[700],
              size: 26,
            ),
          ),
          if (showBadge)
            Positioned(
              top: 5,
              right: 0,
              child: NotificationBadge(count: badgeCount),
            ),
        ],
      ),
    );
  }
}
