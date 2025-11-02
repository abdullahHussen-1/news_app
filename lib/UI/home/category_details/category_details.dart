import 'package:flutter/material.dart';
import 'package:news_app/UI/home/category_details/widget/source_tap_widget.dart';
import 'package:news_app/api/api_manager.dart';
import 'package:news_app/model/SourceResponse.dart';

import '../../../utils/app_mediaQuery.dart';

class CategoryDetails extends StatefulWidget {
  String categoryId;

  CategoryDetails({super.key, required this.categoryId});

  @override
  State<CategoryDetails> createState() => _CategoryDetailsState();
}

class _CategoryDetailsState extends State<CategoryDetails> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<SourceResponse>(
      future: ApiManager.getSources(
        context: context,
        categoryId: widget.categoryId,
      ),
      builder: (context, snapshot) {
        //todo loading
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(
              backgroundColor: Theme.of(context).hintColor,
              color: Theme.of(context).scaffoldBackgroundColor,
            ),
          );
          //todo error from client
        } else if (snapshot.hasError) {
          return Column(
            children: [
              Text("Something went wrong."),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).hintColor,
                ),
                onPressed: () {
                  ApiManager.getSources(
                    context: context,
                    categoryId: widget.categoryId,
                  );
                  setState(() {});
                },
                child: Text(
                  "Try Again",
                  style: Theme.of(context).textTheme.labelSmall,
                ),
              ),
            ],
          );
          //todo server=>response=>success,error
        } else if (snapshot.data?.status == 'error') {
          return Padding(
            padding: EdgeInsets.symmetric(
              horizontal: AppMediaQuery.sizeWidth(context) * 0.04,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  snapshot.data!.message!,
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                SizedBox(height: AppMediaQuery.sizeHeight(context) * 0.02),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).hintColor,
                  ),
                  onPressed: () {
                    ApiManager.getSources(
                      context: context,
                      categoryId: widget.categoryId,
                    );
                    setState(() {});
                  },
                  child: Text(
                    "Try Again",
                    style: Theme.of(context).textTheme.labelSmall,
                  ),
                ),
              ],
            ),
          );
        }
        var sourceList = snapshot.data?.sources ?? [];

        return sourceList.isEmpty
            ? Center(
                child: Text(
                  "Not News Found",
                  style: Theme.of(context).textTheme.headlineLarge,
                ),
              )
            : SourceTapWidget(sourceList: sourceList);
      },
    );
  }
}
