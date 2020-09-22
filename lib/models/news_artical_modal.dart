import 'package:flutter/foundation.dart';

class NewsArticalModal with ChangeNotifier {
  final String title;
  final String sourceName;
  final String description;
  final String newsUrl;
  final String imageUrl;
  final String publishedAt;

  NewsArticalModal({
    @required this.title,
    @required this.sourceName,
    @required this.description,
    @required this.newsUrl,
    @required this.imageUrl,
    @required this.publishedAt,
  });
}
