import 'package:NewsBucket/mconstants.dart';
import 'package:flutter/material.dart';

import '../screens/news_display.dart';

import '../widgets/image_not_ava.dart';

import '../models/news_artical_modal.dart' as nam;

class NewsArticleDisplayWidget extends StatelessWidget {
  final nam.NewsArticalModal newsArtical;

  NewsArticleDisplayWidget({this.newsArtical});
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      margin: const EdgeInsets.symmetric(horizontal: 4, vertical: 5),
      child: InkWell(
        borderRadius: BorderRadius.circular(10.0),
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => NewsDisplayScreen(
                ndNewsArtical: newsArtical,
              ),
            ),
          );
        },
        child: Container(
          height: 300,
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
                    ? ImageNotAvaWidget(
                        isBig: true,
                      )
                    : Container(
                        height: 200,
                        width: MediaQuery.of(context).size.width,
                        child: Hero(
                          tag: newsArtical.title,
                          child: FadeInImage(
                            placeholder: const AssetImage(
                                "dev_assets/NewsBucketLogo.png"),
                            fit: BoxFit.cover,
                            image: NetworkImage(
                              newsArtical.imageUrl,
                            ),
                          ),
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
                      style: MConstant.fontPoppins(16, FontWeight.w600)),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
