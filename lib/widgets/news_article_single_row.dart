import 'package:flutter/material.dart';

import '../models/news_artical_modal.dart' as nam;

class NewsArticleSingleRowWidget extends StatelessWidget {
  final nam.NewsArticalModal newsArtical;

  NewsArticleSingleRowWidget({this.newsArtical});
  @override
  Widget build(BuildContext context) {
    return GestureDetector();
  }
}
