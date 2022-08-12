import 'package:flutter/cupertino.dart';
import 'package:news_app/src/resources/resources.dart';
import 'package:news_app/src/utils/utils.dart';
import '../presentation.dart';
import 'package:rxdart/rxdart.dart';
import 'dart:convert';

class ListNewsViewModel extends BaseViewModel {
  final BehaviorSubject<List<NewsModel>> listNews = BehaviorSubject();
  final TextEditingController searchController = TextEditingController();
  List<NewsModel> originalNews = [];

  init() {
    getListNews();
  }

  getListNews() async {
    List<NewsModel> result = await newsRepository.getListNews();
    if (result.isEmpty) {
      List<String> localNews = AppPrefs.localNews;

      if (localNews.isNotEmpty) {
        localNews.forEach((news) {
          result.add(NewsModel.fromJson(jsonDecode(news)));
        });
      }
    }
    listNews.add(result);
    originalNews.addAll(result);
  }

  onSearch(String keyword, {bool isSubmit = false}) {
    if (isSubmit) FocusScope.of(context).requestFocus(FocusNode());

    if (keyword.isEmpty)
      listNews.add(originalNews);
    else {
      List<NewsModel> temp = [];
      originalNews.forEach((news) {
        if (news.title!.toLowerCase().contains(keyword.toLowerCase())) temp.add(news);
      });
      listNews.add(temp);
    }
  }

  @override
  void dispose() {
    super.dispose();
    searchController.dispose();
    listNews.close();
  }
}
