class Topic {
  final String title;
  final List<String> imagePaths;
  final List<String> imageNames;

  Topic(
      {required this.title,
      required this.imagePaths,
      required this.imageNames});
}

class Book {
  final List<Topic> topics;

  Book({required this.topics});
}
