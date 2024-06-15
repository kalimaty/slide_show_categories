import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:slide_show/models/topicModel.dart';

enum TtsState { playing, stopped }

class SlideProvider with ChangeNotifier {
  SlideProvider() {
    _initTts();
    _initializeBook();
  }

  String currentWord = '';
  final FlutterTts flutterTts = FlutterTts();
  TtsState ttsState = TtsState.stopped;
  late Book book;

  Future<void> _initTts() async {
    await flutterTts.awaitSpeakCompletion(true);

    flutterTts.setStartHandler(() {
      ttsState = TtsState.playing;
      notifyListeners();
    });

    flutterTts.setCompletionHandler(() {
      ttsState = TtsState.stopped;
      notifyListeners();
    });

    flutterTts.setErrorHandler((msg) {
      ttsState = TtsState.stopped;
      notifyListeners();
    });

    notifyListeners();
  }

  void _initializeBook() {
    book = Book(topics: [
      Topic(
        title: 'Fruits',
        imagePaths: [
          "assets/images/apples.png",
          "assets/images/dog.png",
          "assets/images/key.png",
          "assets/images/bear.png",
          // "assets/images/banana.png",
          // "assets/images/pineapple.png",
        ],
        imageNames: [
          "Apples",
          "dog",
          "key",
          "bear",
          // "banana",
          // "pineapple",
          // Add more image names
        ],
      ),
      Topic(
        title: 'Animals',
        imagePaths: [
          "assets/images/Wolf.png",
          "assets/images/bear.png",
          "assets/images/Tiger.png",
          "assets/images/dog.png",
          "assets/images/Giraffe.png",
          "assets/images/Squirrel.png",
        ],
        imageNames: [
          "Wolf",
          "bear",
          "Tiger",
          "dog",
          "Giraffe",
          "Squirrel",
          // Add more image names
        ],
      ),
      // Add more topics
    ]);
  }

  Future<void> speak(String word) async {
    if (ttsState == TtsState.stopped) {
      currentWord = word;
      await flutterTts.speak(word);
    } else if (ttsState == TtsState.playing && currentWord == word) {
      await flutterTts.stop();
    } else if (ttsState == TtsState.playing && currentWord != word) {
      await flutterTts.stop();
      currentWord = word;
      await flutterTts.speak(word);
    }
    notifyListeners();
  }

  bool isPlaying(String word) {
    return ttsState == TtsState.playing && currentWord == word;
  }

  Future<void> stopCurrentPlaying() async {
    if (ttsState == TtsState.playing) {
      await flutterTts.stop();
      ttsState = TtsState.stopped;
      currentWord = '';
      notifyListeners();
    }
  }
}
