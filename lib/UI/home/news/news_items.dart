import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:news_app/model/NewsResponse.dart';
import 'package:news_app/utils/app_mediaQuery.dart';
import 'package:news_app/utils/app_style.dart';

class NewsItems extends StatelessWidget {
  News news;

  NewsItems({super.key, required this.news});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: AppMediaQuery.sizeWidth(context) * 0.02,
        vertical: AppMediaQuery.sizeHeight(context) * 0.02,
      ),
      decoration: BoxDecoration(
        border: Border.all(color: Theme.of(context).hintColor, width: 2),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadiusGeometry.circular(8),
            child: CachedNetworkImage(
              imageUrl: news.urlToImage ?? '',
              placeholder: (context, url) => CircularProgressIndicator(
                backgroundColor: Theme.of(context).hintColor,
                color: Theme.of(context).scaffoldBackgroundColor,
              ),
              errorWidget: (context, url, error) => Icon(
                Icons.error,
                color: Theme.of(context).hintColor,
                size: 40,
              ),
            ),
          ),
          SizedBox(height: AppMediaQuery.sizeHeight(context) * 0.03),
          Text(news.title ?? '', style: Theme.of(context).textTheme.labelLarge),
          SizedBox(height: AppMediaQuery.sizeHeight(context) * 0.03),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  "By: ${news!.author ?? ''}",
                  style: AppStyle.medium12gray,
                ),
              ),
              Text(
                " ${timeSincePublished(news.publishedAt ?? 'Unknown time')}",
                style: AppStyle.medium12gray,
              ),
            ],
          ),
        ],
      ),
    );
  }

  String? timeSincePublished(String publishedAt) {
    try {
      String publishedAtNotT = publishedAt.replaceAll(" ", "T");
      DateTime publishedAtTime = DateTime.parse(publishedAtNotT);
      DateTime now = DateTime.now();
      Duration time = now.difference(publishedAtTime);
      if (time.inSeconds < 60) {
        return "${time.inSeconds} seconds ago";
      } else if (time.inMinutes < 60) {
        return "${time.inMinutes} minutes ago";
      } else if (time.inHours < 24) {
        return "${time.inHours} hours ago";
      } else if (time.inDays < 30) {
        return "${time.inDays} days ago";
      } else if (time.inDays < 365) {
        return "${(time.inDays / 30).floor()} month ago";
      } else if (time.inDays > 365) {
        return "${(time.inDays / 365).floor()} year ago";
      }
    } catch (e) {
      return "Invalid date";
    }
    return null;
  }
}
