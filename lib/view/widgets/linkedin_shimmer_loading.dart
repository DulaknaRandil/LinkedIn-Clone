import 'package:flutter/material.dart';

class LinkedInShimmerLoading extends StatefulWidget {
  final double width;
  final double height;
  final ShapeBorder shapeBorder;

  const LinkedInShimmerLoading({
    super.key,
    this.width = double.infinity,
    required this.height,
    this.shapeBorder = const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(4)),
    ),
  });

  @override
  _LinkedInShimmerLoadingState createState() => _LinkedInShimmerLoadingState();
}

class _LinkedInShimmerLoadingState extends State<LinkedInShimmerLoading>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    )..repeat();

    _animation = Tween<double>(begin: -2.0, end: 2.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOutSine,
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Container(
          width: widget.width,
          height: widget.height,
          decoration: ShapeDecoration(
            shape: widget.shapeBorder,
            gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: const [
                Color(0xFFE0E0E0),
                Color(0xFFEAEAEA),
                Color(0xFFE0E0E0),
              ],
              stops: [
                0.0,
                (_animation.value + 2) / 4,
                1.0,
              ],
            ),
          ),
        );
      },
    );
  }
}

class LinkedInPostLoading extends StatelessWidget {
  const LinkedInPostLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const LinkedInShimmerLoading(
                width: 40,
                height: 40,
                shapeBorder: CircleBorder(),
              ),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  LinkedInShimmerLoading(
                    width: MediaQuery.of(context).size.width * 0.4,
                    height: 14,
                  ),
                  const SizedBox(height: 6),
                  LinkedInShimmerLoading(
                    width: MediaQuery.of(context).size.width * 0.3,
                    height: 12,
                  ),
                  const SizedBox(height: 6),
                  LinkedInShimmerLoading(
                    width: MediaQuery.of(context).size.width * 0.15,
                    height: 10,
                  ),
                ],
              ),
              const Spacer(),
              const LinkedInShimmerLoading(
                width: 20,
                height: 20,
                shapeBorder: CircleBorder(),
              ),
            ],
          ),
          const SizedBox(height: 16),
          LinkedInShimmerLoading(
            width: MediaQuery.of(context).size.width * 0.95,
            height: 16,
          ),
          const SizedBox(height: 8),
          LinkedInShimmerLoading(
            width: MediaQuery.of(context).size.width * 0.9,
            height: 16,
          ),
          const SizedBox(height: 8),
          LinkedInShimmerLoading(
            width: MediaQuery.of(context).size.width * 0.7,
            height: 16,
          ),
          const SizedBox(height: 16),
          const LinkedInShimmerLoading(
            height: 200,
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              LinkedInShimmerLoading(
                width: MediaQuery.of(context).size.width * 0.2,
                height: 10,
              ),
              LinkedInShimmerLoading(
                width: MediaQuery.of(context).size.width * 0.15,
                height: 10,
              ),
            ],
          ),
          const SizedBox(height: 12),
          const Divider(),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              for (int i = 0; i < 4; i++)
                LinkedInShimmerLoading(
                  width: MediaQuery.of(context).size.width * 0.18,
                  height: 24,
                ),
            ],
          ),
        ],
      ),
    );
  }
}
