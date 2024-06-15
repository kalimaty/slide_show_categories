import 'package:flutter/material.dart';
import 'dart:async';

import 'package:slide_show/screens/endScreen.dart';
import 'package:slide_show/widgets/imageCard%20.dart';

class ImageSlideshow extends StatefulWidget {
  final List<String> imagePaths;
  final List<String> imageNames;

  ImageSlideshow({required this.imagePaths, required this.imageNames});

  @override
  _ImageSlideshowState createState() => _ImageSlideshowState();
}

class _ImageSlideshowState extends State<ImageSlideshow>
    with SingleTickerProviderStateMixin {
  int _currentIndex = 0;
  Timer? _timer;
  late AnimationController _animationController;
  late Animation<double> _animation;
  bool _showCard = false;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    )..repeat(reverse: true);
    _animation = Tween<double>(begin: 1.0, end: 1.2).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.elasticInOut,
      ),
    );
    Future.delayed(Duration(milliseconds: 500), () {
      setState(() {
        _showCard = true;
      });
    });
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _delayedStartSlideShow();
    });
    // _startSlideShow();
  }

  @override
  void didUpdateWidget(covariant ImageSlideshow oldWidget) {
    super.didUpdateWidget(oldWidget);
    _delayedStartSlideShow();
  }

  @override
  void dispose() {
    _timer?.cancel();
    _animationController.stop();
    super.dispose();
  }

  Future<void> _delayedStartSlideShow() async {
    await Future.delayed(Duration(seconds: 2));
    _startSlideShow();
  }

  void _startSlideShow() {
    _timer = Timer.periodic(Duration(seconds: 5), (timer) {
      if (_currentIndex < widget.imagePaths.length - 1) {
        setState(() {
          _currentIndex++;
        });
      } else {
        _timer?.cancel();
        _animationController.stop();
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => EndScreen()),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Image Slideshow'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            // Image.asset(widget.imagePaths[_currentIndex]),
            // Text(
            //   widget.imageNames[_currentIndex],
            //   style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
            // ),

            SizedBox(height: 20),
            SizedBox(
              height: 300, // تعيين حجم محدد للحاوية
              child: Stack(
                children: [
                  AnimatedPositioned(
                    duration: Duration(milliseconds: 500),
                    curve: Curves.easeInOut,
                    top: _showCard ? 15 : -400,
                    left: 20,
                    right: 20,
                    child: AnimatedSwitcher(
                      duration: Duration(milliseconds: 500),
                      transitionBuilder:
                          (Widget child, Animation<double> animation) {
                        return FadeTransition(
                          opacity: animation,
                          child: ScaleTransition(
                            scale: animation,
                            child: child,
                          ),
                        );
                      },
                      child: ImageCard(
                        key: ValueKey<String>(widget.imagePaths[_currentIndex]),
                        imagePath: widget.imagePaths[_currentIndex],
                        animation: _animation,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Text(
              widget.imageNames[_currentIndex],
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
