import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:slide_show/models/topicModel.dart';
import 'package:slide_show/screens/history_widget.dart';
import 'package:slide_show/screens/imageSlideshow%20.dart';

import '../providers/slide_provider.dart';

class TopicScreen extends StatelessWidget {
  final Topic topic;

  TopicScreen({required this.topic});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(topic.title),
      ),
      body: Column(
        children: [
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ImageSlideshow(
                    imagePaths: topic.imagePaths,
                    imageNames: topic.imageNames,
                  ),
                ),
              );
            },
            child: Text('Start Slideshow'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => HistoryWidget(topic: topic),
                ),
              );
            },
            child: Text('View History'),
          ),
        ],
      ),
    );
  }
}

class TopicsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final book = Provider.of<SlideProvider>(context).book;

    return Scaffold(
      appBar: AppBar(
        title: Text('Book Topics'),
      ),
      body: ListView.builder(
        itemCount: book.topics.length,
        itemBuilder: (context, index) {
          final topic = book.topics[index];
          return ListTile(
            title: Text(topic.title),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => TopicScreen(topic: topic),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
