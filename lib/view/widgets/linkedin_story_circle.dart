import 'package:flutter/material.dart';

class LinkedInStoryCircle extends StatefulWidget {
  final String imageUrl;
  final bool isYou;
  final VoidCallback? onTap;
  final String? name;

  const LinkedInStoryCircle({
    super.key,
    required this.imageUrl,
    this.isYou = false,
    this.onTap,
    this.name,
  });

  @override
  State<LinkedInStoryCircle> createState() => _LinkedInStoryCircleState();
}

class _LinkedInStoryCircleState extends State<LinkedInStoryCircle>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );

    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.95).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      onTapDown: (_) => _controller.forward(),
      onTapUp: (_) => _controller.reverse(),
      onTapCancel: () => _controller.reverse(),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ScaleTransition(
            scale: _scaleAnimation,
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 8.0),
              width: 65,
              height: 65,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: widget.isYou
                    ? null
                    : LinearGradient(
                        colors: [
                          const Color(0xFF0077B5), // LinkedIn darker blue
                          const Color(0xFF0A66C2), // LinkedIn blue
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                border: widget.isYou
                    ? Border.all(color: Colors.grey.shade300, width: 1.5)
                    : null,
              ),
              padding: const EdgeInsets.all(2.5),
              child: widget.isYou
                  ? Stack(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.white, width: 2.0),
                          ),
                          child: CircleAvatar(
                            radius: 29,
                            backgroundColor: Colors.grey[200],
                            backgroundImage: NetworkImage(widget.imageUrl),
                          ),
                        ),
                        Positioned(
                          right: 0,
                          bottom: 0,
                          child: Container(
                            width: 22,
                            height: 22,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Color(0xFF0A66C2), // LinkedIn blue
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black12,
                                  spreadRadius: 1,
                                  blurRadius: 1,
                                  offset: Offset(0, 1),
                                ),
                              ],
                            ),
                            child: const Icon(
                              Icons.add,
                              color: Colors.white,
                              size: 14,
                            ),
                          ),
                        )
                      ],
                    )
                  : Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white, width: 2.0),
                      ),
                      child: CircleAvatar(
                        radius: 29,
                        backgroundColor: Colors.grey[200],
                        backgroundImage: NetworkImage(widget.imageUrl),
                      ),
                    ),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            widget.isYou ? 'Your story' : widget.name ?? '',
            style: TextStyle(
              fontSize: 12,
              color: Colors.black87,
              fontWeight: FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }
}
