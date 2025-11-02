import 'package:flutter/material.dart';

class LoadingNewsProvider extends ChangeNotifier {
  String page = '1';
  int pageCount = 1;

  void countPage() {
    pageCount++;
    page = pageCount.toString();
    notifyListeners();
  }

  void pageOne() {
    pageCount = 1;
    page = '1';
    notifyListeners();
  }
}
