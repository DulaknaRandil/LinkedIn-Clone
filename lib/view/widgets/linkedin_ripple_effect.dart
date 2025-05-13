import 'package:flutter/material.dart';

class LinkedInRippleEffect extends StatefulWidget {
  final Widget child;
  final VoidCallback onTap;
  final Color rippleColor;

  const LinkedInRippleEffect({
    super.key,
    required this.child,
    required this.onTap,
    this.rippleColor = const Color(0xFF0077B5),
  });

  @override
  _LinkedInRippleEffectState createState() => _LinkedInRippleEffectState();
}

class _LinkedInRippleEffectState extends State<LinkedInRippleEffect>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  final double _rippleSize = 24.0;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );

    _animation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeOut,
      ),
    );

    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _controller.reset();
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
    return GestureDetector(
      onTap: () {
        _controller.forward(from: 0.0);
        widget.onTap();
      },
      child: Stack(
        alignment: Alignment.center,
        children: [
          widget.child,
          AnimatedBuilder(
            animation: _animation,
            builder: (_, __) {
              return Opacity(
                opacity: 1.0 - _animation.value,
                child: Transform.scale(
                  scale: _animation.value * 2 + 1,
                  child: Container(
                    width: _rippleSize,
                    height: _rippleSize,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: widget.rippleColor.withOpacity(0.2),
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
