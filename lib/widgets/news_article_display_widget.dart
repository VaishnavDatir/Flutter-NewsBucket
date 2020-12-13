import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../screens/news_display.dart';

import '../widgets/image_not_ava.dart';
import '../widgets/hero_fadeinimage_widget.dart';

import '../models/news_artical_modal.dart' as nam;

class NewsArticleDisplayWidget extends StatelessWidget {
  final nam.NewsArticalModal newsArtical;

  NewsArticleDisplayWidget({this.newsArtical});
  @override
  Widget build(BuildContext context) {
    return Container(
      // elevation: 2,
      // shape: RoundedRectangleBorder(
      //   borderRadius: BorderRadius.circular(7),
      // ),
      margin: const EdgeInsets.symmetric(horizontal: 4, vertical: 3),
      child: InkWell(
        borderRadius: BorderRadius.circular(7),
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => NewsDisplayScreen(
                ndNewsArtical: newsArtical,
              ),
            ),
          );
        },
        child: Padding(
          padding: const EdgeInsets.only(
              left: 8.0, right: 8.0, top: 8.0, bottom: 5.0),
          child: Container(
            child: Column(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(7)),
                  child: newsArtical.imageUrl.isEmpty
                      ? ImageNotAvaWidget(isBig: true)
                      : Container(
                          height: 200,
                          width: MediaQuery.of(context).size.width,
                          child: HeroAndFadeInImage(
                            newsArticalTitle: newsArtical.title,
                            newsArticalImageURL: newsArtical.imageUrl,
                          ),
                        ),
                ),
                Expanded(
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 4, vertical: 6),
                    child: Text(newsArtical.title,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 3,
                        style: GoogleFonts.roboto(
                            fontSize: 18,
                            // color: Colors.black,
                            fontWeight: FontWeight.w600)),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
