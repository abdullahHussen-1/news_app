import 'package:flutter/material.dart';
import 'package:news_app/model/category.dart';
import 'package:news_app/utils/app_colors.dart';
import 'package:news_app/utils/app_mediaQuery.dart';

class CategoryItem extends StatelessWidget {
  Category category;
  bool isRight;

  CategoryItem({super.key, required this.category, required this.isRight});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: isRight ? Alignment.topRight : Alignment.topLeft,
      height: AppMediaQuery.sizeHeight(context) * 0.25,
      decoration: BoxDecoration(
        borderRadius: BorderRadiusGeometry.circular(24),
        image: DecorationImage(
          image: AssetImage(category.image),
          fit: BoxFit.fill,
        ),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: AppMediaQuery.sizeWidth(context) * 0.02,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,

          children: [
            Text(category.title, style: Theme.of(context).textTheme.bodyMedium),
            Container(
              padding: EdgeInsetsDirectional.only(
                start: isRight ? AppMediaQuery.sizeWidth(context) * 0.02 : 0.0,
                end: isRight ? 0.0 : AppMediaQuery.sizeWidth(context) * 0.02,
              ),
              width: AppMediaQuery.sizeWidth(context) * 0.40,
              decoration: BoxDecoration(
                borderRadius: BorderRadiusGeometry.circular(84),
                color: AppColors.gray,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                textDirection: isRight ? TextDirection.ltr : TextDirection.rtl,
                children: [
                  Text(
                    "View All",
                    style: Theme.of(context).textTheme.headlineLarge,
                  ),
                  CircleAvatar(
                    backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                    child: Center(
                      child: Icon(
                        isRight
                            ? Icons.arrow_forward_ios
                            : Icons.arrow_back_ios,
                        color: Theme.of(context).hintColor,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
