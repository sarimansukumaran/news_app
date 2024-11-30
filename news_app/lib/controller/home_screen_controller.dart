import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:news_app/model/news_model.dart';

class HomeScreenController with ChangeNotifier {
  List<Article> articleList = [];

  List categoryList = [
    "USA TOP HEADLINES",
    "POLITICS",
    "EDUCATION",
    "WEATHER",
    "SPORTS"
  ];
  int selectedCategoryIncdex = 0;

  Future<void> getTopHeadlines() async {
    final url = Uri.parse(
        "https://newsapi.org/v2/top-headlines?country=us&apiKey=6ac3d4bf055e4897937d82522b88fecb");
    final categoryurl = Uri.parse(
        "https://newsapi.org/v2/everything?q=${categoryList[selectedCategoryIncdex]}&apiKey=6ac3d4bf055e4897937d82522b88fecb");
    try {
      final response =
          await http.get(selectedCategoryIncdex == 0 ? url : categoryurl);
      if (response.statusCode == 200) {
        NewsModel newsModelObj = newsModelFromJson(response.body);
        articleList = newsModelObj.articles ?? [];
      }
    } catch (e) {
      print(e);
    }

    notifyListeners();
  }

  onCategorySeleciton(int clickedIndex) async {
    if (selectedCategoryIncdex != clickedIndex) {
      selectedCategoryIncdex = clickedIndex;
      notifyListeners();
      await getTopHeadlines();
    }
  }
}
