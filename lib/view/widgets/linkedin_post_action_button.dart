import 'package:flutter/material.dart';

class LinkedInPostActionButton extends StatefulWidget {
  final IconData icon;

  final VoidCallback? onTap;

  const LinkedInPostActionButton({
    super.key,
    required this.icon,
    this.onTap,
  });

  @override
  State<LinkedInPostActionButton> createState() =>
      _LinkedInPostActionButtonState();
}

class _LinkedInPostActionButtonState extends State<LinkedInPostActionButton> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        setState(() => _isPressed = !_isPressed);
        if (widget.onTap != null) {
          widget.onTap!();
        }
      },
      borderRadius: BorderRadius.circular(4),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 10.0),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              widget.icon,
              size: 24.0,
              color: _isPressed
                  ? const Color(0xFF0A66C2)
                  : const Color(0xFFB2D4F0),
            ),
          ],
        ),
      ),
    );
  }
}
