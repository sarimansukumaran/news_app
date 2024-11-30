import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:news_app/model/news_model.dart';

class SearchResultScreenController with ChangeNotifier {
  List<Article> articleList = [];
  int? totalResults;
  Future<void> getSearchContent(String searchKey) async {
    final url = Uri.parse(
        "https://newsapi.org/v2/everything?q=$searchKey&apiKey=6ac3d4bf055e4897937d82522b88fecb");
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        NewsModel newsModelObj = newsModelFromJson(response.body);
        articleList = newsModelObj.articles ?? [];
        totalResults = newsModelObj.totalResults ?? 0;
      }
    } catch (e) {
      print(e);
    }
    notifyListeners();
  }
}
