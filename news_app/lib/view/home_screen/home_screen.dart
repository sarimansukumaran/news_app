import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:news_app/controller/home_screen_controller.dart';

import 'package:news_app/utils/app_utils.dart';
import 'package:news_app/utils/color_constants.dart';
import 'package:news_app/view/global_widget/topHeadline_card.dart';

import 'package:news_app/view/search_result_screen/search_result_screen.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await context.read<HomeScreenController>().getTopHeadlines();
    });
    super.initState();
  }

  TextEditingController searchController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    final String currentDate =
        DateFormat('dd MMMM, yyyy').format(DateTime.now());

    return Scaffold(
        appBar: build_appbar_section(currentDate),
        body: Consumer<HomeScreenController>(
          builder: (context, proObj, child) => Column(
            children: [
              SingleChildScrollView(
                controller: _scrollController,
                scrollDirection: Axis.horizontal,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    children: List.generate(
                      proObj.categoryList.length,
                      (index) => Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: InkWell(
                          onTap: () {
                            // _scrollToSelectedIndex(index);
                            context
                                .read<HomeScreenController>()
                                .onCategorySeleciton(index);
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 25),
                            height: 45,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                color: proObj.selectedCategoryIncdex == index
                                    ? Colors.black
                                    : Colors.grey.withOpacity(.3),
                                borderRadius: BorderRadius.circular(10)),
                            child: Text(
                              proObj.categoryList[index].toString(),
                              style: TextStyle(
                                  fontWeight: FontWeight.normal,
                                  color: proObj.selectedCategoryIncdex == index
                                      ? Colors.white
                                      : Colors.black),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 16,
              ),
              Expanded(
                child: ListView.separated(
                    itemBuilder: (context, index) {
                      String dateTimeString =
                          proObj.articleList[index].publishedAt.toString();
                      DateTime dateTime = DateTime.parse(dateTimeString);
                      return TopHeadline_card(
                        imagerl:
                            proObj.articleList[index].urlToImage.toString(),
                        title: proObj.articleList[index].title.toString(),
                        author: proObj.articleList[index].author.toString(),
                        publishedAt: DateFormat('dd-MM-yyyy').format(dateTime),
                        ontap: () async {
                          final url = proObj.articleList[index].url.toString();
                          await AppUtils.launchNewsUrl(url);
                        },
                      );
                    },
                    separatorBuilder: (context, index) => SizedBox(
                          height: 5,
                        ),
                    itemCount: proObj.articleList.length),
              ),
            ],
          ),
        ));
  }

  PreferredSize build_appbar_section(String currentDate) {
    return PreferredSize(
      preferredSize: Size.fromHeight(65),
      child: AppBar(
        backgroundColor: ColorConstants.primaryColor,
        title: Column(
          children: [
            Image(
              image: NetworkImage(
                  "https://upload.wikimedia.org/wikipedia/commons/thumb/2/2a/ABC_News_logo_2021.svg/512px-ABC_News_logo_2021.svg.png"),
              fit: BoxFit.fill,
              height: 40,
              width: 100,
            ),
            Text(
              currentDate,
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: Colors.white70,
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            onPressed: () {
              showSearchDialog(context);
            },
            icon: Icon(
              Icons.search_outlined,
              size: 28,
              color: ColorConstants.mainWhite,
            ),
          ),
          CircleAvatar(
            radius: 18,
            child: Icon(Icons.person),
          ),
          SizedBox(
            width: 10,
          )
        ],
      ),
    );
  }

  void showSearchDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          // shape: RoundedRectangleBorder(
          //   borderRadius: BorderRadius.circular(12),
          // ),
          child: Container(
            //color: ColorConstants.grey,
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            padding: EdgeInsets.all(10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Search',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    IconButton(
                      icon: Icon(Icons.close),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                ),
                SizedBox(height: 16),
                TextFormField(
                  decoration: InputDecoration(
                    hintText: 'Enter your search term',
                    border: OutlineInputBorder(),
                    suffixIcon: IconButton(
                        onPressed: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return SearchResultScreen(
                              searchKey: searchController.text,
                            );
                          }));
                        },
                        icon: Icon(Icons.arrow_forward)),
                  ),
                  controller: searchController,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
