import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../screens/news_display.dart';

import '../widgets/image_not_ava.dart';

import '../models/news_artical_modal.dart' as nam;

class NewsArticleDisplayWidget extends StatelessWidget {
  final nam.NewsArticalModal newsArtical;

  NewsArticleDisplayWidget({this.newsArtical});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        /*  Navigator.of(context).pushNamed(NewsView.routeName,
            arguments: {"newsUrl": newsArtical.newsUrl}); */ //To OPEN WEBSITE
        // print(newsArtical.newsUrl.toString());
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => NewsDisplayScreen(
              ndNewsArtical: newsArtical,
            ),
          ),
        );
      },
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        margin: EdgeInsets.symmetric(horizontal: 4, vertical: 5),
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: const Radius.circular(10),
                topRight: const Radius.circular(10),
                bottomRight: const Radius.circular(1),
                bottomLeft: const Radius.circular(1),
              ),
              child: newsArtical.imageUrl.isEmpty
                  ? ImageNotAvaWidget()
                  : Container(
                      height: 200,
                      width: double.infinity,
                      child: Hero(
                        tag: newsArtical.title,
                        child: FadeInImage(
                          placeholder:
                              AssetImage("dev_assets/NewsBucketLogo.png"),
                          fit: BoxFit.cover,
                          image: NetworkImage(
                            newsArtical.imageUrl,
                          ),
                        ),
                      ),
                    ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 4, vertical: 6),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(newsArtical.title,
                      style: GoogleFonts.poppins(
                          fontSize: 17,
                          color: Colors.black,
                          fontWeight: FontWeight.w600)),
                  Text(
                    newsArtical.description,
                    style: GoogleFonts.montserrat(
                        fontSize: 15, color: Colors.grey[900]),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
