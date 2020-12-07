import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../screens/news_display.dart';
import '../widgets/image_not_ava.dart';
import '../widgets/hero_fadeinimage_widget.dart';

import '../models/news_artical_modal.dart' as nam;

class NewsArticleSingleRowWidget extends StatelessWidget {
  final nam.NewsArticalModal newsArticalSingleRow;

  NewsArticleSingleRowWidget({this.newsArticalSingleRow});
  @override
  Widget build(BuildContext context) {
    return Container(
        // elevation: 0,
        // shape: RoundedRectangleBorder(
        //   borderRadius: BorderRadius.circular(10.0),
        // ),
        margin: const EdgeInsets.symmetric(horizontal: 4, vertical: 3),
        child: InkWell(
          // borderRadius: BorderRadius.circular(10.0),
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => NewsDisplayScreen(
                  ndNewsArtical: newsArticalSingleRow,
                ),
              ),
            );
          },
          child: Container(
            height: 100,
            child: Row(
              children: [
                newsArticalSingleRow.imageUrl.isEmpty
                    ? ImageNotAvaWidget(isBig: false)
                    : Container(
                        height: 100,
                        width: 125,
                        child: HeroAndFadeInImage(
                            newsArticalTitle: newsArticalSingleRow.title,
                            newsArticalImageURL:
                                newsArticalSingleRow.imageUrl)),
                Expanded(
                    child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 5),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        newsArticalSingleRow.title,
                        softWrap: true,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 3,
                        style: GoogleFonts.roboto(
                            fontSize: 16,
                            // color: Colors.black,
                            fontWeight: FontWeight.w600),
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: Text(
                          "Know More >",
                          style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w500,
                              color: Colors.blue[800]),
                        ),
                      )
                    ],
                  ),
                ))
              ],
            ),
          ),
        ));
  }
}
