import 'package:flutter/material.dart';
import 'package:news_app/controller/home_screen_controller.dart';

import 'package:news_app/utils/color_constants.dart';

import 'package:provider/provider.dart';

class TopHeadline_card extends StatefulWidget {
  TopHeadline_card({
    required this.imagerl,
    required this.title,
    required this.author,
    required this.publishedAt,
    required this.ontap,
    super.key,
  });
  String imagerl;
  String title;
  String author;
  String publishedAt;
  void Function()? ontap;

  @override
  State<TopHeadline_card> createState() => _TopHeadline_cardState();
}

class _TopHeadline_cardState extends State<TopHeadline_card> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await context.read<HomeScreenController>().getTopHeadlines();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      padding: EdgeInsets.all(10),
      margin: EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          // context.watch<HomeScreenController>().isImageLoading
          //     ? Center(child: CircularProgressIndicator())
          //     :
          InkWell(
            onTap: widget.ontap,
            child: Container(
              padding: const EdgeInsets.all(8.0),
              child: Image(
                height: 150,
                width: MediaQuery.of(context).size.width,
                image: NetworkImage(widget.imagerl),
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                },
              ),
            ),
          ),
          InkWell(
            onTap: widget.ontap,
            child: Text(
              widget.title,
              style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 17,
                  color: ColorConstants.mainWhite),
              maxLines: 3,
              textAlign: TextAlign.justify,
            ),
          ),
          Text(
            "By ${widget.author}  .  ${widget.publishedAt}",
            style: TextStyle(color: ColorConstants.grey),
          )
        ],
      ),
    );
  }
}
