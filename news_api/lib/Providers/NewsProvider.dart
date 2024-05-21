// import 'package:flutter/material.dart';
// import 'package:news_api/Methods/NewsMethod.dart';

// class NewsProvider with ChangeNotifier {
//   Future<void> fetchNewSdata(String newsChannel) async {
//     await NewsMethod().fetchNewsData(newsChannel);
//     notifyListeners();
//   }

//   Future<void> fetchNewSCategory(String category) async {
//     await NewsMethod().fetchCategories(category);
//     notifyListeners();
//   }
// }

import 'package:flutter/material.dart';
import 'package:news_api/Methods/NewsMethod.dart';
import 'package:news_api/Models/CategoriesNewsModel.dart';
import 'package:news_api/Models/NewsHeadlinesModel.dart';

class NewsProvider with ChangeNotifier {
  final NewsMethod _newsMethod = NewsMethod();

  NewsHeadlinesModel? _newsHeadlines;
  CategoriesNewsModel? _categoriesNews;
  bool _isLoading = false;
  String _error = '';

  NewsHeadlinesModel? get newsHeadlines => _newsHeadlines;
  CategoriesNewsModel? get categoriesNews => _categoriesNews;
  bool get isLoading => _isLoading;
  String get error => _error;

  Future<void> fetchNewsData(String newsChannel) async {
    _isLoading = true;
    notifyListeners();

    try {
      _newsHeadlines = await _newsMethod.fetchNewsData(newsChannel);
      _error = '';
    } catch (e) {
      _error = e.toString();
      _newsHeadlines = null;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> fetchCategories(String category) async {
    _isLoading = true;
    notifyListeners();

    try {
      _categoriesNews = await _newsMethod.fetchCategories(category);
      _error = '';
    } catch (e) {
      _error = e.toString();
      _categoriesNews = null;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
