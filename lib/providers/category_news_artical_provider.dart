import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import 'dart:convert';

import '../mconstants.dart';
import '../models/news_artical_modal.dart';

class CategoryNewsArticalProvider with ChangeNotifier {
  List<NewsArticalModal> _categorynewsarticalpro = [];
  List<NewsArticalModal> get categorynewsarticalpro {
    return [..._categorynewsarticalpro];
  }

  Future<void> fetchCategoryNews(String categoryName) async {
    try {
      final url =
          "https://newsapi.org/v2/top-headlines?country=in&category=${categoryName.toLowerCase()}&apiKey=${MConstant.mAPIKey}";

      final response = await http.get(url);
      final jsonBody = json.decode(response.body);

      if (jsonBody["status"] == "error") {
        print("JSON Status Error Message :${jsonBody["code"]}");
      } else if (jsonBody["status"] == "ok") {
        final categoryarticals = jsonBody["articles"] as List<dynamic>;

        List<NewsArticalModal> categoryarticalsDummy = [];
        categoryarticals.forEach((element) {
          categoryarticalsDummy.add(NewsArticalModal(
            title: element["title"] ?? "",
            sourceName: element["source"]["name"] ?? "",
            description: element["description"] ?? "",
            newsUrl: element["url"] ?? "",
            imageUrl: element["urlToImage"] ?? "",
            publishedAt: element["publishedAt"] ?? "",
          ));
        });

        //print(categoryarticalsDummy.length);
        _categorynewsarticalpro = categoryarticalsDummy;
        print("$categoryName Headlines fetched");
      }
      if (jsonBody["artical"] != null) {
        print("JSON BODY for $categoryName is Empty");
        return;
      }

      print("JSON BODY of $categoryName FETCHED");
    } catch (error) {
      print("ERROR in fetching $categoryName: $error");
    }
  }
}
