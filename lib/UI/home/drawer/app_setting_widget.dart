import 'package:flutter/material.dart';

import '../../../utils/app_colors.dart';
import '../../../utils/app_mediaQuery.dart';
import '../../../utils/app_style.dart';

class AppSettingWidget extends StatelessWidget {
  String text;

  AppSettingWidget({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: AppMediaQuery.sizeWidth(context) * 0.88,
      margin: EdgeInsets.symmetric(
        horizontal: AppMediaQuery.sizeWidth(context) * 0.05,
      ),
      padding: EdgeInsets.symmetric(
        horizontal: AppMediaQuery.sizeWidth(context) * 0.04,
        vertical: AppMediaQuery.sizeHeight(context) * 0.01,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadiusGeometry.circular(16),
        border: Border.all(width: 1, color: AppColors.primaryLightMode),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(text, style: AppStyle.medium20whit),
          Icon(
            Icons.arrow_drop_down,
            size: 45,
            color: AppColors.primaryLightMode,
          ),
        ],
      ),
    );
  }
}
