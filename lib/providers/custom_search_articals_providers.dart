import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../models/news_artical_modal.dart';

class CustomSearchNewsArticalsProviders with ChangeNotifier {
  List<NewsArticalModal> _customSearchNewsPro = [];
  List<NewsArticalModal> get customSearchNewsPro {
    return [..._customSearchNewsPro];
  }

  Future<void> fetchCustomSearchNews(String searchString) async {
    try {
      final url =
          "https://newsapi.org/v2/everything?q=${searchString.toLowerCase()}&language=en&sortBy=popularity,publishedAt&apiKey=186a96a01cdd4e88b16ad04df6be8e33";
      final response = await http.get(url);
      final jsonBody = json.decode(response.body);

      if (jsonBody["status"] == "error") {
        print("JSON Status Error Message :${jsonBody["code"]}");
      } else if (jsonBody["status"] == "ok") {
        final categoryarticals = jsonBody["articles"] as List<dynamic>;

        List<NewsArticalModal> customSearchArticalsDummy = [];
        categoryarticals.forEach((element) {
          customSearchArticalsDummy.add(NewsArticalModal(
            title: element["title"] ?? "",
            sourceName: element["source"]["name"] ?? "",
            description: element["description"] ?? "",
            newsUrl: element["url"] ?? "",
            imageUrl: element["urlToImage"] ?? "",
            publishedAt: element["publishedAt"] ?? "",
          ));
        });

        _customSearchNewsPro = customSearchArticalsDummy;
        print("Custom Search Headlines fetched");

        if (jsonBody["artical"] != null) {
          print("JSON BODY Custom Search is Empty");
          return;
        }

        print("JSON BODY for Custom Search FETCHED");
      }
    } catch (error) {
      print("ERROR in Custom Search: $error");
    }
  }
}
