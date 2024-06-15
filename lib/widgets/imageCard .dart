import 'package:flutter/material.dart';

// Stateless widget for displaying image
class ImageCard extends StatelessWidget {
  final String imagePath;
  final Animation<double> animation;

  const ImageCard({Key? key, required this.imagePath, required this.animation})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shadowColor: Colors.grey.shade800,
      elevation: 10,
      margin: EdgeInsets.all(5),
      child: Container(
        height: 200,
        width: double.maxFinite,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: AnimatedBuilder(
            animation: animation,
            builder: (context, child) {
              return ScaleTransition(
                scale: animation,
                child: child,
              );
            },
            child: Image.asset(imagePath),
          ),
        ),
      ),
    );
  }
}
