import 'package:flutter/material.dart';
import 'package:news_app/UI/home/category_fragment/category_fragment.dart';
import 'package:news_app/UI/home/drawer/home_drawer.dart';
import 'package:news_app/model/category.dart';
import 'package:news_app/utils/app_route.dart';

import 'category_details/category_details.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          selectedCategory == null ? "Home" : selectedCategory!.title,
          style: Theme.of(context).textTheme.bodySmall,
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, AppRoute.searchRoute);
            },
            icon: Icon(
              Icons.search,
              size: 35,
              color: Theme.of(context).hintColor,
            ),
          ),
        ],
      ),
      drawer: Drawer(child: HomeDrawer(onTapHomeClick: onTapHomeClick)),

      body: selectedCategory == null
          ? CategoryFragment(onTapCategoryItemClick: onCategoryItemClick)
          : CategoryDetails(categoryId: selectedCategory!.id),
    );
  }

  Category? selectedCategory;

  void onCategoryItemClick(Category newCategory) {
    selectedCategory = newCategory;

    setState(() {});
  }

  void onTapHomeClick() {
    selectedCategory = null;
    setState(() {});
  }
}
