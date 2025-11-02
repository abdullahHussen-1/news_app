import 'package:flutter/material.dart';
import 'package:news_app/UI/home/news/news_items.dart';
import 'package:news_app/UI/home/news/widget/bottom_sheet.dart';
import 'package:news_app/api/api_manager.dart';
import 'package:news_app/model/NewsResponse.dart';
import 'package:news_app/model/SourceResponse.dart';
import 'package:news_app/provider/loading_news.dart';
import 'package:provider/provider.dart';

import '../../../provider/source_provider.dart';
import '../../../utils/app_mediaQuery.dart';

class NewsDetails extends StatefulWidget {
  Source source;

  NewsDetails({super.key, required this.source});

  @override
  State<NewsDetails> createState() => _NewsDetailsState();
}

class _NewsDetailsState extends State<NewsDetails> {
  var newsList = [];
  ScrollController scrollController = ScrollController();
  bool isLoading = false;
  bool finish = false;

  @override
  void initState() {
    super.initState();
    var pageProvider = Provider.of<LoadingNewsProvider>(context, listen: false);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<SourceProvider>(
        context,
        listen: false,
      ).changeSource(widget.source);
      pageProvider.pageOne();
      setState(() {});
    });
    scrollController.addListener(() {
      if (scrollController.position.pixels >=
              scrollController.position.maxScrollExtent - 100 &&
          !isLoading &&
          !finish) {
        pageProvider.countPage();
        setState(() {});
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    var pageProvider = Provider.of<LoadingNewsProvider>(context);
    return FutureBuilder<NewsResponse>(
      key: ValueKey(pageProvider.page),
      future: ApiManager.getNews(widget.source.id ?? '', pageProvider.page),
      builder: (context, snapshot) {
        //todo loading
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "PAGE: ${pageProvider.page}",
                style: Theme.of(context).textTheme.headlineLarge,
              ),
              SizedBox(height: AppMediaQuery.sizeHeight(context) * 0.02),
              CircularProgressIndicator(
                backgroundColor: Theme.of(context).hintColor,
                color: Theme.of(context).scaffoldBackgroundColor,
              ),
            ],
          ); /*Center(
            child: CircularProgressIndicator(
              backgroundColor: Theme.of(context).hintColor,
              color: Theme.of(context).scaffoldBackgroundColor,
            ),
          );*/
          //todo error from client
        } else if (snapshot.hasError) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Something went wrong.",
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).hintColor,
                ),
                onPressed: () {
                  ApiManager.getNews(widget.source.id ?? '', pageProvider.page);
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
                    ApiManager.getNews(
                      widget.source.id ?? '',
                      pageProvider.page,
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
        if (snapshot.hasData && snapshot.data?.articles != null) {
          final newNews = snapshot.data!.articles ?? [];

          if (newNews.isEmpty) {
            finish = true;
          } else {
            newsList.insertAll(0, newNews);
          }
          isLoading = false;
        }

        return newsList.isEmpty
            ? Center(
                child: Text(
                  "No current news to display",
                  style: Theme.of(context).textTheme.headlineLarge,
                ),
              )
            : RefreshIndicator(
                onRefresh: () async {
                  pageProvider.pageOne();
                  finish = finish;
                  final newNews = await ApiManager.getNews(
                    widget.source.id ?? '',
                    pageProvider.page,
                  );
                  newsList.insertAll(0, newNews.articles ?? []);
                  setState(() {});
                },
                child: ListView.separated(
                  controller: scrollController,
                  padding: EdgeInsets.symmetric(
                    vertical: AppMediaQuery.sizeHeight(context) * 0.01,
                    horizontal: AppMediaQuery.sizeWidth(context) * 0.04,
                  ),
                  itemBuilder: (context, index) {
                    if (index < newsList.length) {
                      return InkWell(
                        onTap: () {
                          BottomSheetWidget.showBottomSheet(
                            newsList[index],
                            context,
                          );
                          //clickNews(newsList[index]);
                        },
                        child: NewsItems(news: newsList[index]),
                      );
                    }
                  },
                  separatorBuilder: (context, index) => SizedBox(height: 10),
                  itemCount: newsList.length + (isLoading ? 1 : 0),
                ),
              );
      },
    );
  }
}
