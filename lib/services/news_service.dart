import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';
import 'package:market_news_app/models/news_model.dart';
import 'package:market_news_app/services/notification_service.dart';

class NewsService {
  final _url =
      "https://nw.nuvamawealth.com/edelmw-content/content/liveNews/general";
  final _token =
      "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJhcHAiOjEsImZmIjoiVyIsImJkIjoid2ViLXBjIiwibmJmIjoxNTc5MjQxODMyLCJzcmMiOiJlbXRtdyIsImF2IjoiMS4wLjAuNCIsImFwcGlkIjoiNGZlNjhiNzUzNjc4NGUzNDA3YzNlY2YxOWJlN2M0YWQiLCJpc3MiOiJlbXQiLCJleHAiOjE2MTA3NzgxMzIsImlhdCI6MTU3OTI0MjEzMn0.IR-PKf1Jjr69bsERFmMeuZrZ2RafBDiTGgKA6Ygofdo";
  final _data = jsonEncode({
    "exclCategory": ["Block_Details", "Special Coverage"],
    "validRequest": false,
    "inclCategory": [],
    "page": 0,
    "group": "NG",
    "searchText": "",
    "dateTime": "",
  });
  final _dio = Dio();

  Map<String, NewsModel> newsModelMap = {};

  List<NewsModel> get newsModelList =>
      newsModelMap.values.toList()
        ..sort((a, b) => b.dateTime.compareTo(a.dateTime));

  ValueNotifier<bool> newsServiceValueNotifier = ValueNotifier(false);

  Future<void> getNews() async {
    final res = await _dio.post(
      _url,
      data: _data,
      options: Options(headers: {"Appidkey": _token}),
    );
    checkNewsData(res.data);
  }

  void checkNewsData(Map<String, dynamic> map) async {
    final newsModelList = List.from(
      map['data']['listResponse']['content'],
    ).map((e) => NewsModel.fromMap(e)).toList();
    if (newsModelList.isEmpty) return;
    newsModelList.sort((a, b) => b.dateTime.compareTo(a.dateTime));
    final len = newsModelList.length;
    bool isAnyNewNewsAvailable = false;
    for (var i = 0; i < len; i++) {
      final newsModel = newsModelList[i];
      if (newsModelMap.containsKey(newsModel.id)) continue;
      newsModelMap.putIfAbsent(newsModel.id, () => newsModel);
      isAnyNewNewsAvailable = true;
      await notificationService.showNotification(newsModel);
    }
    if (isAnyNewNewsAvailable) {
      newsServiceValueNotifier.value = !newsServiceValueNotifier.value;
    }
  }
}

NewsService newsService = NewsService();
