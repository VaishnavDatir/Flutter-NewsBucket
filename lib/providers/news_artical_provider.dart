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
            description: element["description"] ?? "",
            newsUrl: element["url"] ?? "",
            imageUrl: element["urlToImage"] ?? "",
            publishedAt: element["publishedAt"] ?? "",
          ));
        });

        print(articalsDummy.length);
        _newsarticalpro = articalsDummy;
        print("Top Headlines fetched");
      }
      if (jsonBody == null) {
        print("JSON BODY for Top Headlines is Empty");
        return;
      }

      print("JSON BODY for Top Headlines FETCHED");
    } catch (error) {
      print("ERROR in fetching top Headlines: $error");
    }
  }
}
