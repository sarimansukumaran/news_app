import 'package:flutter/material.dart';
import 'package:news_app/utils/color_constants.dart';
import 'package:news_app/view/search_result_screen/search_result_screen.dart';

class SearchContentCard extends StatelessWidget {
  const SearchContentCard(
      {super.key,
      required this.widget,
      required this.imageurl,
      required this.title,
      required this.discription,
      required this.author,
      required this.publishedAt,
      required this.ontap});

  final SearchResultScreen widget;
  final String imageurl;
  final String title;
  final String discription;
  final String author;
  final String publishedAt;
  final void Function()? ontap;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 320,
      padding: EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InkWell(
            onTap: ontap,
            child: Container(
              padding: const EdgeInsets.all(8.0),
              child: Image(
                height: 150,
                width: MediaQuery.of(context).size.width,
                image: NetworkImage(imageurl),
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
            onTap: ontap,
            child: Text(
              title,
              style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 16,
                  color: ColorConstants.mainWhite),
              maxLines: 4,
              textAlign: TextAlign.justify,
            ),
          ),
          InkWell(
            onTap: ontap,
            child: Text(
              discription,
              style: TextStyle(
                  fontWeight: FontWeight.w200,
                  fontSize: 13,
                  color: ColorConstants.mainWhite),
              maxLines: 5,
              textAlign: TextAlign.justify,
            ),
          ),
          Text(
            "By ${author}  .  ${publishedAt}",
            style: TextStyle(color: ColorConstants.grey),
          )
        ],
      ),
    );
  }
}
