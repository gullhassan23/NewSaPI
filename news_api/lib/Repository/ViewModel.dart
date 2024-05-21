import 'package:news_api/Methods/NewsMethod.dart';
import 'package:news_api/Models/CategoriesNewsModel.dart';
import 'package:news_api/Models/NewsHeadlinesModel.dart';

class NewsViewModelRepository {
  final rep = NewsMethod();

  Future<NewsHeadlinesModel> fetchNewsData(String channelName) async {
    final response = await rep.fetchNewsData(channelName);
    return response;
  }

  Future<CategoriesNewsModel> fetchCategories(String category) async {
    final response = await rep.fetchCategories(category);
    return response;
  }
}

