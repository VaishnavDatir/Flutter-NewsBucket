import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../mconstants.dart';

import '../models/news_artical_modal.dart';

class NewsArticalProvider with ChangeNotifier {
  List<NewsArticalModal> _newsarticalpro = [];
  List<NewsArticalModal> get newsarticalpro {
    return [..._newsarticalpro];
  }

  Future<void> fetchTopHeadlines() async {
    try {
      final url =
          "https://newsapi.org/v2/top-headlines?country=in&apiKey=${MConstant.mAPIKey}";

      await _fetchNewsArticals(url);
      print("JSON BODY of Top Headlines fetched");
    } catch (error) {
      print("ERROR in fetching top Headlines: $error");
    }
  }

  Future<void> fetchCategoryNews(String categoryName) async {
    try {
      final url =
          "https://newsapi.org/v2/top-headlines?country=in&category=${categoryName.toLowerCase()}&apiKey=${MConstant.mAPIKey}";

      await _fetchNewsArticals(url);
      print("JSON BODY of $categoryName FETCHED");
    } catch (error) {
      print("ERROR in fetching $categoryName: $error");
    }
  }

  Future<void> fetchCustomSearchNews(String searchString) async {
    try {
      final url =
          "https://newsapi.org/v2/everything?q=${searchString.toLowerCase()}&language=en&sortBy=publishedAt,popularity,relevancy&apiKey=186a96a01cdd4e88b16ad04df6be8e33";

      await _fetchNewsArticals(url);
      print("Custom Search Headlines fetched");
    } catch (error) {
      print("ERROR in Custom Search: $error");
    }
  }

  Future _fetchNewsArticals(String url) async {
    final response = await http.get(url);
    final jsonBody = json.decode(response.body);

    if (jsonBody["status"] == "error") {
      print("JSON Status Error Message :${jsonBody["code"]}");
    } else if (jsonBody["status"] == "ok") {
      final articals = jsonBody["articles"] as List<dynamic>;

      List<NewsArticalModal> articalsDummy = [];
      articals.forEach((element) {
        articalsDummy.add(NewsArticalModal(
          title: element["title"] ?? "",
          sourceName: element["source"]["name"] ?? "",
          autherName: element["author"] ?? "",
          description: element["description"] ?? "",
          newsUrl: element["url"] ?? "",
          imageUrl: element["urlToImage"] ?? "",
          publishedAt: DateTime.parse(element["publishedAt"]) ?? null,
        ));
      });
      // print(articalsDummy.length);
      _newsarticalpro = articalsDummy;
    }
  }
}
