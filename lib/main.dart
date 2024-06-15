import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:slide_show/screens/topicsScreen%20.dart';
import 'providers/slide_provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => SlideProvider(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Slide Show',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: TopicsScreen(),
    );
  }
}
