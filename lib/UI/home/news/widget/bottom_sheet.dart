import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:news_app/utils/app_route.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../model/NewsResponse.dart';
import '../../../../utils/app_colors.dart';
import '../../../../utils/app_mediaQuery.dart';
import '../../../../utils/dialog_utils.dart';

class BottomSheetWidget {
  ///pack  url_launcher
  static void openLink(String uriString, BuildContext context) async {
    final Uri uri = Uri.parse(uriString);

    try {
      await launchUrl(uri);
    } catch (e) {
      DialogUtils.shoeMassage(
        context: context,
        massage: e.toString(),
        title: "Error Link",
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text(
              "OK",
              style: Theme.of(
                context,
              ).textTheme.displayLarge!.copyWith(fontSize: 24),
            ),
          ),
        ],
      );
    }
  }

  static void showBottomSheet(News news, BuildContext context) {
    showModalBottomSheet(
      backgroundColor: AppColors.transparent,
      context: context,
      builder: (context) {
        return Container(
          padding: EdgeInsets.symmetric(
            horizontal: AppMediaQuery.sizeWidth(context) * 0.02,
            vertical: AppMediaQuery.sizeHeight(context) * 0.01,
          ),
          margin: EdgeInsets.only(
            bottom: AppMediaQuery.sizeHeight(context) * 0.01,
            right: AppMediaQuery.sizeWidth(context) * 0.04,
            left: AppMediaQuery.sizeWidth(context) * 0.04,
          ),
          decoration: BoxDecoration(
            color: Theme.of(context).hintColor,
            borderRadius: BorderRadiusGeometry.circular(16),
          ),
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadiusGeometry.circular(8),
                        child: CachedNetworkImage(
                          imageUrl: news.urlToImage ?? '',
                          placeholder: (context, url) =>
                              CircularProgressIndicator(
                                backgroundColor: Theme.of(context).hintColor,
                                color: Theme.of(
                                  context,
                                ).scaffoldBackgroundColor,
                              ),
                          errorWidget: (context, url, error) => Icon(
                            Icons.error,
                            color: Theme.of(context).hintColor,
                            size: 40,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: AppMediaQuery.sizeHeight(context) * 0.01,
                      ),
                      Text(
                        news.description ?? '',
                        style: Theme.of(context).textTheme.displayLarge,
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: AppMediaQuery.sizeHeight(context) * 0.02),
              InkWell(
                onTap: () {
                  //openLink(news.url ?? '' /*"htt://www.argaam.co"*/, context);
                  String decodeLink = Uri.decodeFull(news.url ?? '');
                  Navigator.pushNamed(
                    context,
                    AppRoute.webViewScreenRoute,
                    arguments: decodeLink,
                  );
                  //openLinkWebView(context).loadRequest(Uri.parse(decodeLink));
                },
                child: Container(
                  alignment: Alignment.center,
                  width: AppMediaQuery.sizeWidth(context),
                  padding: EdgeInsets.symmetric(
                    horizontal: AppMediaQuery.sizeWidth(context) * 0.04,
                    vertical: AppMediaQuery.sizeHeight(context) * 0.02,
                  ),
                  decoration: BoxDecoration(
                    color: Theme.of(context).scaffoldBackgroundColor,
                    borderRadius: BorderRadiusGeometry.circular(8),
                  ),
                  child: Text(
                    "View Full Articel",
                    style: Theme.of(context).textTheme.labelLarge,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
