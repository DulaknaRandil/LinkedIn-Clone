import 'package:flutter/material.dart';

class LinkedInRefreshIndicator extends StatelessWidget {
  final Widget child;
  final Future<void> Function() onRefresh;

  const LinkedInRefreshIndicator({
    super.key,
    required this.child,
    required this.onRefresh,
  });

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: onRefresh,
      backgroundColor: Colors.white,
      color: const Color(0xFF0077B5),
      displacement: 40,
      edgeOffset: 0,
      triggerMode: RefreshIndicatorTriggerMode.onEdge,
      strokeWidth: 3,
      child: child,
    );
  }
}

class LinkedInProgressIndicator extends StatefulWidget {
  final double size;
  final Color color;

  const LinkedInProgressIndicator({
    super.key,
    this.size = 40.0,
    this.color = const Color(0xFF0077B5),
  });

  @override
  _LinkedInProgressIndicatorState createState() =>
      _LinkedInProgressIndicatorState();
}

class _LinkedInProgressIndicatorState extends State<LinkedInProgressIndicator>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.size,
      height: widget.size,
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return CustomPaint(
            painter: _LinkedInLoaderPainter(
              animation: _controller.value,
              color: widget.color,
            ),
          );
        },
      ),
    );
  }
}

class _LinkedInLoaderPainter extends CustomPainter {
  final double animation;
  final Color color;

  _LinkedInLoaderPainter({
    required this.animation,
    required this.color,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = color
      ..strokeWidth = 3.0
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;

    final double radius = size.width / 2;
    final Offset center = Offset(size.width / 2, size.height / 2);

    // Draw LinkedIn logo style spinner
    const double startAngle = -0.5 * 3.14;
    const double sweepAngle = 1.75 * 3.14;

    // Animate the sweep angle
    final double currentSweepAngle = sweepAngle * animation;
    final double startAngleOffset = sweepAngle * (1 - animation);

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius - 4),
      startAngle + startAngleOffset,
      currentSweepAngle,
      false,
      paint,
    );
  }

  @override
  bool shouldRepaint(_LinkedInLoaderPainter oldDelegate) {
    return animation != oldDelegate.animation || color != oldDelegate.color;
  }
}
