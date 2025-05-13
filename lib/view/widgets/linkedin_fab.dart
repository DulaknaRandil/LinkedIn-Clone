import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class LinkedInFab extends StatefulWidget {
  final VoidCallback onPressed;
  final IconData icon;
  final String? tooltip;

  const LinkedInFab({
    super.key,
    required this.onPressed,
    this.icon = Icons.add,
    this.tooltip,
  });

  @override
  State<LinkedInFab> createState() => _LinkedInFabState();
}

class _LinkedInFabState extends State<LinkedInFab>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;
  bool _isPressed = false;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );

    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: 0.9,
    ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut,
      ),
    );

    // Add a small pulse animation when idle
    _startPulseAnimation();
  }

  void _startPulseAnimation() {
    Future.delayed(const Duration(seconds: 3), () {
      if (mounted && !_isPressed) {
        _animationController.forward().then((_) {
          _animationController.reverse().then((_) {
            _startPulseAnimation();
          });
        });
      }
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _scaleAnimation,
      builder: (context, child) {
        return Transform.scale(
          scale: _scaleAnimation.value,
          child: FloatingActionButton(
            onPressed: () {
              setState(() {
                _isPressed = true;
              });
              HapticFeedback.mediumImpact();
              _animationController.forward().then((_) {
                _animationController.reverse().then((_) {
                  widget.onPressed();
                  Future.delayed(const Duration(milliseconds: 500), () {
                    if (mounted) {
                      setState(() {
                        _isPressed = false;
                      });
                      _startPulseAnimation();
                    }
                  });
                });
              });
            },
            tooltip: widget.tooltip,
            elevation: 4.0,
            backgroundColor: const Color(0xFF0077B5),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(40.0),
            ),
            child: Icon(
              widget.icon,
              color: Colors.white,
              size: 28.0,
            ),
          ),
        );
      },
    );
  }
}
