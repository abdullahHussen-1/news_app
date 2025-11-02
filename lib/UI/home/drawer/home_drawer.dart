import 'package:flutter/material.dart';
import 'package:news_app/UI/home/drawer/app_setting_widget.dart';
import 'package:news_app/UI/home/drawer/item_drawer.dart';
import 'package:news_app/provider/theme_provider.dart';
import 'package:news_app/utils/app_assets.dart';
import 'package:news_app/utils/app_colors.dart';
import 'package:news_app/utils/app_mediaQuery.dart';
import 'package:news_app/utils/app_style.dart';
import 'package:provider/provider.dart';

import '../../../api/api_constants.dart';
import '../../../provider/news_language_provider.dart';

typedef OnTapHomeClick = void Function();

class HomeDrawer extends StatelessWidget {
  OnTapHomeClick onTapHomeClick;

  HomeDrawer({super.key, required this.onTapHomeClick});

  @override
  Widget build(BuildContext context) {
    var themeProvider = Provider.of<ThemeProvider>(context);
    var languageNews = Provider.of<NewsLanguageProvider>(context);
    return Scaffold(
      backgroundColor: AppColors.primaryDarkMode,
      body: Column(
        children: [
          Container(
            alignment: Alignment.center,
            color: AppColors.primaryLightMode,
            height: AppMediaQuery.sizeHeight(context) * 0.19,
            width: AppMediaQuery.sizeWidth(context),
            child: Text("News App", style: AppStyle.bold24dark),
          ),
          InkWell(
            onTap: () {
              Navigator.pop(context);
              onTapHomeClick();
            },
            child: ItemDrawer(text: "Go To Home", image: AppAssets.homeDrawer),
          ),
          Divider(
            color: AppColors.primaryLightMode,
            endIndent: AppMediaQuery.sizeWidth(context) * 0.05,
            indent: AppMediaQuery.sizeWidth(context) * 0.05,
          ),
          ItemDrawer(text: "Them", image: AppAssets.iconTheme),
          PopupMenuButton<String>(
            color: AppColors.primaryDarkMode,
            child: AppSettingWidget(
              text: themeProvider.themeMode == ThemeMode.dark
                  ? "Dark"
                  : "Light",
            ),
            itemBuilder: (context) => [
              PopupMenuItem(
                value: 'Light',
                child: Text('Light', style: AppStyle.medium20whit),
              ),
              PopupMenuItem(
                value: 'Dark',
                child: Text('Dark', style: AppStyle.medium20whit),
              ),
            ],
            onSelected: (value) {
              if (value == 'Dark') {
                themeProvider.changeTheme(ThemeMode.dark);
              } else if (value == 'Light') {
                themeProvider.changeTheme(ThemeMode.light);
              }
            },
          ),
          SizedBox(height: AppMediaQuery.sizeHeight(context) * 0.02),

          Divider(
            color: AppColors.primaryLightMode,
            endIndent: AppMediaQuery.sizeWidth(context) * 0.05,
            indent: AppMediaQuery.sizeWidth(context) * 0.05,
          ),
          ItemDrawer(text: "Language News", image: AppAssets.iconLanguage),
          PopupMenuButton<String>(
            color: AppColors.primaryDarkMode,
            child: AppSettingWidget(text: languageNews.language),
            itemBuilder: (context) => [
              PopupMenuItem(
                value: 'All Language',
                child: Text('All Language', style: AppStyle.medium20whit),
              ),
              PopupMenuItem(
                value: 'English',
                child: Text('English', style: AppStyle.medium20whit),
              ),
              PopupMenuItem(
                value: 'Arabic',
                child: Text('Arabic', style: AppStyle.medium20whit),
              ),
            ],
            onSelected: (value) {
              if (value == 'All Language') {
                languageNews.changLanguageNews(ApiConstants.general);
              } else if (value == 'English') {
                languageNews.changLanguageNews(ApiConstants.english);
              } else if (value == 'Arabic') {
                languageNews.changLanguageNews(ApiConstants.arabic);
              }
            },
          ),
        ],
      ),
    );
  }
}
