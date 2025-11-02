import 'package:flutter/material.dart';

import '../api/api_constants.dart';

class NewsLanguageProvider extends ChangeNotifier {
  String languageCheck = '';
  String language = 'All Language';

  void changLanguageNews(String newLanguage) {
    if (newLanguage == ApiConstants.general) {
      language = 'All Language';
      languageCheck = newLanguage;
    } else if (newLanguage == ApiConstants.english) {
      language = 'English';
      languageCheck = newLanguage;
    } else if (newLanguage == ApiConstants.arabic) {
      language = 'Arabic';
      languageCheck = newLanguage;
    }
    notifyListeners();
  }
}
