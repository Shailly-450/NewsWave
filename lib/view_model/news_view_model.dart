import 'package:news_wave/models/category_news_model.dart';
import 'package:news_wave/models/news_channel_headlines_model.dart';
import 'package:news_wave/repository/news_repository.dart';

class NewsViewModel{
  final _rep = NewsRepository();
  Future<NewsChannelsHeadlinesModel> fetchNewsChannelHeadlinesApi(String channelName) async{
    final respose = _rep.fetchNewsChannelHeadlinesApi(channelName);
    return respose;
  }
  Future<CategoriesNewsModel> fetchCategoriesNewsApi(String category) async{
    final respose = _rep.fetchCategoriesNewsApi(category);
    return respose;
  }
}