import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:news_app/src/resources/resources.dart';
import 'package:news_app/src/utils/utils.dart';
import '../presentation.dart';

class NewsDetailViewModel extends BaseViewModel {
  init() {}

  saveNewsToLocal(NewsModel news) {
    List<String> localNews = [];
    localNews.addAll(AppPrefs.localNews);
    localNews.add(jsonEncode(news.toJson()));
    AppPrefs.localNews = localNews;

    Fluttertoast.showToast(
        msg: 'Lưu tin thành công: ${AppPrefs.localNews.length}',
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.black.withOpacity(0.85),
        textColor: Colors.white);
  }
}
