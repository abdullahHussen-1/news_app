import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:news_app/api/api_constants.dart';
import 'package:news_app/api/end_points.dart';
import 'package:news_app/model/NewsResponse.dart';
import 'package:news_app/model/SourceResponse.dart';
import 'package:provider/provider.dart';

import '../provider/news_language_provider.dart';

class ApiManager {
  static Future<SourceResponse> getSources({
    required BuildContext context,
    required String categoryId,
  }) async {
    var languageProvider = Provider.of<NewsLanguageProvider>(context);
    Uri url = Uri.https(ApiConstants.baseUrl, EndPoints.sourceApi, {
      'apiKey': ApiConstants.apiKey,
      'language': languageProvider.languageCheck,
      'category': categoryId,
    });
    try {
      var response = await http.get(url);
      //todo return String
      var responseBody = response.body;
      //todo from String to json
      var responseBodyJson = jsonDecode(responseBody);
      //todo from json to object
      return SourceResponse.fromJson(responseBodyJson);
    } catch (e) {
      rethrow;
    }
  }

  //https://newsapi.org/v2/everything?q=bitcoin&apiKey=97d869551635409fbfb8b9c53618f909
  static Future<NewsResponse> getNews(String sourceId, String page) async {
    Uri url = Uri.https(ApiConstants.baseUrl, EndPoints.newsApi, {
      'apiKey': ApiConstants.apiKey,
      'sources': sourceId,
      'page': page,
    });
    try {
      var response = await http.get(url);
      var responseBody = response.body;
      var responseBodyJson = jsonDecode(responseBody);
      return NewsResponse.fromJson(responseBodyJson);
    } catch (e) {
      rethrow;
    }
  }

  static Future<NewsResponse> getNewsSearch(
    String sourceId,
    String search,
  ) async {
    Uri url = Uri.https(ApiConstants.baseUrl, EndPoints.newsApi, {
      'apiKey': ApiConstants.apiKey,
      'sources': sourceId,
      'q': search,
    });
    try {
      var response = await http.get(url);
      var responseBody = response.body;
      var responseBodyJson = jsonDecode(responseBody);
      return NewsResponse.fromJson(responseBodyJson);
    } catch (e) {
      rethrow;
    }
  }
}
