import 'package:flutter/material.dart';

class LinkedInStaggeredAnimation extends StatefulWidget {
  final Widget child;
  final int index;

  const LinkedInStaggeredAnimation({
    super.key,
    required this.child,
    required this.index,
  });

  @override
  _LinkedInStaggeredAnimationState createState() =>
      _LinkedInStaggeredAnimationState();
}

class _LinkedInStaggeredAnimationState extends State<LinkedInStaggeredAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _opacityAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 700),
      vsync: this,
    );

    final delay = widget.index * 0.2;
    final begin = Offset(0, 0.1);

    _slideAnimation = Tween<Offset>(
      begin: begin,
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Interval(
        delay.clamp(
            0.0, 0.9), // Minimum 0, Maximum 0.9 to ensure it's always < 1.0
        1.0,
        curve: Curves.easeOutQuart,
      ),
    ));

    _opacityAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Interval(
        delay.clamp(0.0, 0.9),
        1.0,
        curve: Curves.easeOutQuart,
      ),
    ));

    // Start the animation after a slight initial delay
    Future.delayed(const Duration(milliseconds: 100), () {
      if (mounted) {
        _controller.forward();
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _opacityAnimation,
      child: SlideTransition(
        position: _slideAnimation,
        child: widget.child,
      ),
    );
  }
}
