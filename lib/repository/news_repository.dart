import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:news_wave/models/news_channel_headlines_model.dart';

import '../models/category_news_model.dart';

class NewsRepository {
  Future<NewsChannelsHeadlinesModel> fetchNewsChannelHeadlinesApi(String channelName) async{
    String url = 'https://newsapi.org/v2/top-headlines?sources=${channelName}&apiKey=8806273cd69e481388bd7a97469ab603';
    print(url);
    final response = await http.get(Uri.parse(url));
    if(kDebugMode){
      print(response.body);
    }
    if(response.statusCode == 200){
      final body = jsonDecode(response.body);
      return NewsChannelsHeadlinesModel.fromJson(body);
    }
    throw Exception('Error 404');
  }
  Future<CategoriesNewsModel> fetchCategoriesNewsApi(String category) async{
    String url = 'https://newsapi.org/v2/everything?q=${category}&apiKey=8806273cd69e481388bd7a97469ab603';
    final response = await http.get(Uri.parse(url));
    if(kDebugMode){
      print(response.body);
    }
    if(response.statusCode == 200){
      final body = jsonDecode(response.body);
      return CategoriesNewsModel.fromJson(body);
    }
    throw Exception('Error 404');
  }
}