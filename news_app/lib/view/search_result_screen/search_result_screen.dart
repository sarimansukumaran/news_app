import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:news_app/controller/search_result_screen_controller.dart';
import 'package:news_app/utils/app_utils.dart';

import 'package:news_app/utils/color_constants.dart';
import 'package:news_app/view/global_widget/search_content_card.dart';

import 'package:provider/provider.dart';

class SearchResultScreen extends StatefulWidget {
  const SearchResultScreen({required this.searchKey, super.key});
  final String searchKey;
  @override
  State<SearchResultScreen> createState() => _SearchResultScreenState();
}

class _SearchResultScreenState extends State<SearchResultScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      context
          .read<SearchResultScreenController>()
          .getSearchContent(widget.searchKey);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: ColorConstants.primaryColor,
          title: Image(
            image: NetworkImage(
                "https://upload.wikimedia.org/wikipedia/commons/thumb/2/2a/ABC_News_logo_2021.svg/512px-ABC_News_logo_2021.svg.png"),
            fit: BoxFit.fill,
            height: 40,
            width: 100,
          ),
        ),
        body: Consumer<SearchResultScreenController>(
            builder: (context, providerObj, child) => providerObj
                        .totalResults ==
                    0
                ? Center(
                    child: Text(
                      "Sorry,no results",
                      style: TextStyle(color: ColorConstants.mainWhite),
                    ),
                  )
                : ListView.separated(
                    itemBuilder: (context, index) {
                      String dateTimeString =
                          providerObj.articleList[index].publishedAt.toString();
                      DateTime dateTime = DateTime.parse(dateTimeString);
                      return SearchContentCard(
                        widget: widget,
                        imageurl: providerObj.articleList[index].urlToImage
                            .toString(),
                        title: providerObj.articleList[index].title.toString(),
                        discription: providerObj.articleList[index].description
                            .toString(),
                        author:
                            providerObj.articleList[index].author.toString(),
                        publishedAt: DateFormat('dd-MM-yyyy').format(dateTime),
                        ontap: () {
                          AppUtils.launchNewsUrl(
                              providerObj.articleList[index].url.toString());
                        },
                      );
                    },
                    separatorBuilder: (context, index) => SizedBox(
                          height: 10,
                        ),
                    itemCount: providerObj.articleList.length)));
  }
}
