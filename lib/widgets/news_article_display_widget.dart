import 'package:NewsBucket/screens/news_view.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../models/news_artical_modal.dart' as nam;

class NewsArticleDisplayWidget extends StatelessWidget {
  final nam.NewsArticalModal newsArtical;

  NewsArticleDisplayWidget({this.newsArtical});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushNamed(NewsView.routeName,
            arguments: {"newsUrl": newsArtical.newsUrl});
        // print(newsArtical.newsUrl.toString());
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
                  ? Container(
                      height: 200,
                      width: double.infinity,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          RichText(
                            text: TextSpan(
                              text: 'News',
                              style: GoogleFonts.ubuntu(
                                  fontSize: 27, color: Colors.black),
                              children: <TextSpan>[
                                TextSpan(
                                    text: 'Bucket',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.blue[900])),
                              ],
                            ),
                          ),
                          Text("Image Not Availabe",
                              style: GoogleFonts.ubuntu(
                                  fontSize: 20, color: Colors.black))
                        ],
                      ),
                    )
                  : Container(
                      height: 200,
                      width: double.infinity,
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
                        fontSize: 15, color: Colors.grey[700]),
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
