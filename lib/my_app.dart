import 'package:flutter/material.dart';
import 'package:news_app/UI/home/home_screen.dart';
import 'package:news_app/UI/home/news/widget/web_view_screen.dart';
import 'package:news_app/UI/home/search/search.dart';
import 'package:news_app/provider/theme_provider.dart';
import 'package:news_app/utils/app_route.dart';
import 'package:news_app/utils/app_them.dart';
import 'package:provider/provider.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    var themeProvider = Provider.of<ThemeProvider>(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: AppRoute.homeScreen,
      routes: {
        AppRoute.homeScreen: (context) => HomeScreen(),
        AppRoute.searchRoute: (context) => Search(),
        AppRoute.webViewScreenRoute: (context) => WebViewScreen(),
      },
      themeMode: themeProvider.themeMode,
      darkTheme: AppThem.darkMode,
      theme: AppThem.lightMode,
    );
  }
}
