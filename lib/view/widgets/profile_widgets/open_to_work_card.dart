import 'package:flutter/material.dart';

class OpenToWorkCard extends StatelessWidget {
  final Color linkedInBlue;

  const OpenToWorkCard({
    super.key,
    required this.linkedInBlue,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8),
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
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: Colors.green[50],
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Icon(
                  Icons.work,
                  size: 18,
                  color: Colors.green[700],
                ),
              ),
              const SizedBox(width: 10),
              const Expanded(
                child: Text(
                  'Open to work',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.grey[400]!),
                ),
                child: IconButton(
                  icon: Icon(
                    Icons.edit,
                    size: 16,
                    color: Colors.grey[700],
                  ),
                  onPressed: () {},
                  constraints: const BoxConstraints(
                    minHeight: 32,
                    minWidth: 32,
                  ),
                  padding: EdgeInsets.zero,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12), // Job Types
          Text(
            'iOS Developer roles',
            style: TextStyle(
              fontSize: 15,
              color: Colors.grey[800],
            ),
          ),
          const SizedBox(height: 12),
          // See Details Link
          Row(
            children: [
              Icon(
                Icons.visibility,
                size: 16,
                color: Colors.grey[700],
              ),
              const SizedBox(width: 4),
              Text(
                'Visible to: All LinkedIn members',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey[700],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          // See Details Link
          Text(
            'See all details',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: linkedInBlue,
            ),
          ),
        ],
      ),
    );
  }
}
