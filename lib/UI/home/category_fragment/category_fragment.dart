import 'package:flutter/material.dart';
import 'package:news_app/UI/home/category_fragment/category_item.dart';
import 'package:news_app/model/category.dart';
import 'package:news_app/provider/theme_provider.dart';
import 'package:news_app/utils/app_mediaQuery.dart';
import 'package:provider/provider.dart';

typedef OnTapCategoryItemClick = void Function(Category);

class CategoryFragment extends StatelessWidget {
  OnTapCategoryItemClick onTapCategoryItemClick;

  CategoryFragment({super.key, required this.onTapCategoryItemClick});

  List<Category> categoryList = [];

  @override
  Widget build(BuildContext context) {
    var themeProvider = Provider.of<ThemeProvider>(context);
    categoryList = Category.getCategoryList(
      themeProvider.themeMode != ThemeMode.dark,
    );
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: AppMediaQuery.sizeWidth(context) * 0.04,
        vertical: AppMediaQuery.sizeHeight(context) * 0.01,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Good Morning\nHere is Some News For You",
            style: Theme.of(context).textTheme.headlineLarge,
          ),
          Expanded(
            child: ListView.separated(
              padding: EdgeInsets.only(
                top: AppMediaQuery.sizeHeight(context) * 0.02,
              ),
              itemBuilder: (context, index) => InkWell(
                onTap: () {
                  onTapCategoryItemClick(categoryList[index]);
                },
                child: CategoryItem(
                  category: categoryList[index],
                  isRight: index % 2 == 0,
                ),
              ),
              separatorBuilder: (context, index) =>
                  SizedBox(height: AppMediaQuery.sizeHeight(context) * 0.02),
              itemCount: categoryList.length,
            ),
          ),
        ],
      ),
    );
  }
}
