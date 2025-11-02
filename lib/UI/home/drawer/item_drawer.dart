import 'package:flutter/material.dart';

import '../../../utils/app_colors.dart';
import '../../../utils/app_mediaQuery.dart';
import '../../../utils/app_style.dart';

class ItemDrawer extends StatelessWidget {
  ItemDrawer({super.key, required this.text, required this.image});

  String text;
  String image;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: AppMediaQuery.sizeWidth(context) * 0.05,
        vertical: AppMediaQuery.sizeHeight(context) * 0.02,
      ),
      child: Row(
        children: [
          Image.asset(image, color: AppColors.primaryLightMode),
          SizedBox(width: AppMediaQuery.sizeWidth(context) * 0.02),
          Text(text, style: AppStyle.bold20wight),
        ],
      ),
    );
  }
}
