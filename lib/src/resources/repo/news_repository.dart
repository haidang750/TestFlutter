import 'dart:convert';
import 'package:http/http.dart' show Client, Response;
import 'package:news_app/src/resources/resources.dart';

import '../services/wifi_service.dart';

class NewsRepository {
  final newsApiProvider = NewsApiProvider();

  Future<List<NewsModel>> getListNews() => newsApiProvider.getListNews();
}

class NewsApiProvider {
  final String url =
      "https://newsapi.org/v2/everything?q=apple&from=2022-08-09&to=2022-08-09&sortBy=popularity&apiKey=a9818c7a3ed3433fbecc7820f3ec65bb";

  Future<List<NewsModel>> getListNews() async {
    bool isDisconnect = await WifiService.isDisconnect();
    if (isDisconnect) return [];

    Response response = await Client().get(Uri.parse(url));

    if (response.statusCode == 200) {
      if (json.decode(response.body)["status"] == "ok") {
        return NewsModel.listFromJson(json.decode(response.body)["articles"]);
      } else
        return [];
    } else {
      throw Exception("Network Error!");
    }
  }
}
