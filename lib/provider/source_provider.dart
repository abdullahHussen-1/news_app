import 'package:flutter/material.dart';
import 'package:news_app/model/SourceResponse.dart';

class SourceProvider extends ChangeNotifier {
  Source? source;

  void changeSource(Source newSource) {
    source = newSource;
    notifyListeners();
  }
}
