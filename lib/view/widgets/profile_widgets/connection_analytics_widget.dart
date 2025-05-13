import 'package:flutter/material.dart';
import '../../../models/user_model.dart';

class ConnectionAnalyticsWidget extends StatelessWidget {
  final UserModel user;
  final Color linkedInBlue;

  const ConnectionAnalyticsWidget({
    super.key,
    required this.user,
    required this.linkedInBlue,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 2,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '${user.followers.toString()} followers',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                '${user.connections} connections',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: linkedInBlue,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),

          // Talking about section
          const Text(
            'Talking about:',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 8),

          // Tags
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: user.talkingAbout.map((topic) {
              return Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  '#$topic',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: linkedInBlue,
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
