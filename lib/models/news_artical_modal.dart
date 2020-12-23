import 'package:flutter/foundation.dart';

class NewsArticalModal with ChangeNotifier {
  final String title;
  final String sourceName;
  final String autherName;
  final String description;
  final String newsUrl;
  final String imageUrl;

  NewsArticalModal({
    @required this.title,
    @required this.sourceName,
    @required this.autherName,
    @required this.description,
    @required this.newsUrl,
    @required this.imageUrl,
  });
}
