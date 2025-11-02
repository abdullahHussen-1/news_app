import 'package:flutter/material.dart';
import 'package:news_app/model/NewsResponse.dart';
import 'package:news_app/utils/app_mediaQuery.dart';
import 'package:provider/provider.dart';

import '../../../api/api_manager.dart';
import '../../../provider/source_provider.dart';
import '../news/news_items.dart';
import '../news/widget/bottom_sheet.dart';

class SearchItem extends StatefulWidget {
  SearchItem({super.key, required this.search});

  String search = '';

  @override
  State<SearchItem> createState() => _SearchItemState();
}
//microsoft

class _SearchItemState extends State<SearchItem> {
  @override
  Widget build(BuildContext context) {
    var sourceProvider = Provider.of<SourceProvider>(context);
    return FutureBuilder<NewsResponse>(
      future: ApiManager.getNewsSearch(
        sourceProvider.source!.id ?? '',
        widget.search,
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
                  ApiManager.getNewsSearch(
                    sourceProvider.source!.id ?? '',
                    widget.search,
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
                    ApiManager.getNewsSearch(
                      sourceProvider.source!.id ?? '',
                      widget.search,
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
        var newsList = snapshot.data?.articles ?? [];
        return newsList.isEmpty
            ? Center(
                child: Text(
                  "No current news to display",
                  style: Theme.of(context).textTheme.headlineLarge,
                ),
              )
            : ListView.separated(
                padding: EdgeInsets.symmetric(
                  vertical: AppMediaQuery.sizeHeight(context) * 0.01,
                  horizontal: AppMediaQuery.sizeWidth(context) * 0.04,
                ),
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      BottomSheetWidget.showBottomSheet(
                        newsList[index],
                        context,
                      );
                    },
                    child: NewsItems(news: newsList[index]),
                  );
                },
                separatorBuilder: (context, index) => SizedBox(height: 10),
                itemCount: newsList.length,
              );
      },
    );
  }
}
