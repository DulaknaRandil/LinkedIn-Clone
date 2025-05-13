import 'package:flutter/material.dart';

class NetworkImageMock extends StatelessWidget {
  final String imageUrl;
  final double width;
  final double height;
  final BoxFit fit;

  const NetworkImageMock({
    Key? key,
    required this.imageUrl,
    required this.width,
    required this.height,
    this.fit = BoxFit.cover,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // In a real widget, this would be Image.network(), but for tests
    // we return a simple container with a color
    return Container(
      width: width,
      height: height,
      color: Colors.grey[300], // Use a placeholder color
      child: Center(
        child: Icon(
          Icons.image,
          color: Colors.grey[600],
          size: width * 0.3,
        ),
      ),
    );
  }
}
