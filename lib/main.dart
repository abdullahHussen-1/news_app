import 'package:flutter/material.dart';
import 'package:news_app/provider/loading_news.dart';
import 'package:news_app/provider/news_language_provider.dart';
import 'package:news_app/provider/source_provider.dart';
import 'package:news_app/provider/theme_provider.dart';
import 'package:provider/provider.dart';

import 'my_app.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => NewsLanguageProvider()),
        ChangeNotifierProvider(create: (context) => ThemeProvider()),
        ChangeNotifierProvider(create: (context) => SourceProvider()),
        ChangeNotifierProvider(create: (context) => LoadingNewsProvider()),
      ],
      child: MyApp(),
    ),
  );
}
