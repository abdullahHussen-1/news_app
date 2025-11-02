import 'package:flutter/material.dart';
import 'package:news_app/UI/home/search/search_item.dart';
import 'package:news_app/UI/home/search/widet/search_text_form_field.dart';

import '../../../utils/app_mediaQuery.dart';

class Search extends StatefulWidget {
  Search({super.key});

  String textSearch = '';

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(
                vertical: AppMediaQuery.sizeHeight(context) * 0.01,
                horizontal: AppMediaQuery.sizeWidth(context) * 0.04,
              ),
              child: SearchTextFormField(
                text: "Search",
                borderSideColor: Theme.of(context).hintColor,
                hintStyleText: Theme.of(context).textTheme.bodyLarge,
                suffixIcon: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(Icons.clear, color: Theme.of(context).hintColor),
                ),
                onChange: (text) {
                  //print(text);
                  widget.textSearch = text;
                  setState(() {});
                },
              ),
            ),
            Expanded(child: SearchItem(search: widget.textSearch)),
          ],
        ),
      ),
    );
  }
}
