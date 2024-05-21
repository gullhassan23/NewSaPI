import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:news_api/Models/CategoriesNewsModel.dart';
import 'package:news_api/Models/NewsHeadlinesModel.dart';

class NewsMethod {
  Future<NewsHeadlinesModel> fetchNewsData(String newsChannel) async {
    String url =
        "https://newsapi.org/v2/top-headlines?sources=${newsChannel}&apiKey=dfebaebcc95b48768fe8dea992bfb0e3";

    final response = await http.get(Uri.parse(url));
    print(response.body);
    if (response.statusCode == 200) {
      final body = jsonDecode(response.body);
      return NewsHeadlinesModel.fromJson(body);
    }
    throw Exception("Error");
  }

  Future<CategoriesNewsModel> fetchCategories(String category) async {
    String url =
        "https://newsapi.org/v2/everything?q=${category}&apiKey=dfebaebcc95b48768fe8dea992bfb0e3";

    final response = await http.get(Uri.parse(url));
    print(response.body);
    if (response.statusCode == 200) {
      final body = jsonDecode(response.body);
      return CategoriesNewsModel.fromJson(body);
    }
    throw Exception("Error");
  }
}
