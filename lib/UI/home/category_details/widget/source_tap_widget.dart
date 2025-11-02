import 'package:flutter/material.dart';
import 'package:news_app/UI/home/category_details/widget/source_name.dart';
import 'package:news_app/UI/home/news/news_details.dart';
import 'package:news_app/model/SourceResponse.dart';
import 'package:news_app/utils/app_colors.dart';

class SourceTapWidget extends StatefulWidget {
  List<Source> sourceList;

  SourceTapWidget({super.key, required this.sourceList});

  @override
  State<SourceTapWidget> createState() => _SourceTapWidgetState();
}

class _SourceTapWidgetState extends State<SourceTapWidget> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: widget.sourceList.length,
      child: Column(
        children: [
          TabBar(
            tabAlignment: TabAlignment.start,
            isScrollable: true,
            indicatorColor: Theme.of(context).hintColor,
            dividerColor: AppColors.transparent,
            onTap: (index) {
              selectedIndex = index;

              setState(() {});
            },
            tabs: widget.sourceList.map((source) {
              return SourceName(
                source: source,
                isSelected: selectedIndex == widget.sourceList.indexOf(source),
              );
            }).toList(),
          ),
          Expanded(
            child: NewsDetails(source: widget.sourceList[selectedIndex]),
          ),
        ],
      ),
    );
  }
}
