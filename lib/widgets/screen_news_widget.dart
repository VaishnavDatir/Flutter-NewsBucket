import 'package:flutter/material.dart';

import 'package:carousel_slider/carousel_slider.dart';

import '../widgets/heading_div_widget.dart';
import '../widgets/news_article_display_widget.dart';
import '../widgets/news_article_single_row.dart';
import '../widgets/connectivity_error.dart';
import '../animation/slide_animation_widget.dart';

import '../providers/news_artical_provider.dart' as nap;

class ScreenNewsWidget extends StatelessWidget {
  final nap.NewsArticalProvider data;
  final List<String> headings;
  ScreenNewsWidget({this.data, this.headings});
  @override
  Widget build(BuildContext context) {
    if (data.newsarticalpro.isEmpty) {
      return Center(child: ConnectivityError());
    } else {
      final List _mainScreenWidgets = [
        SizedBox(height: 10),
        HeadingAndDivider(heading: headings[0]),
        CarouselSlider(
          items: [
            NewsArticleDisplayWidget(newsArtical: data.newsarticalpro[0]),
            NewsArticleDisplayWidget(newsArtical: data.newsarticalpro[1]),
            NewsArticleDisplayWidget(newsArtical: data.newsarticalpro[2]),
            NewsArticleDisplayWidget(newsArtical: data.newsarticalpro[3])
          ],
          options: CarouselOptions(
              autoPlay: true,
              height: 300,
              viewportFraction: 1,
              enlargeCenterPage: true,
              enableInfiniteScroll: false),
        ),
        SizedBox(height: 5),
        HeadingAndDivider(heading: headings[1]),
        ListView.separated(
            separatorBuilder: (context, index) => Divider(
                  indent: 132,
                ),
            physics: ClampingScrollPhysics(),
            shrinkWrap: true,
            itemCount: data.newsarticalpro.length - 4,
            itemBuilder: (ctx, index) => SlideAnimationWidget(
                  index: index,
                  itemCount: data.newsarticalpro.length - 4,
                  widgetToAnimate: NewsArticleSingleRowWidget(
                    newsArticalSingleRow: data.newsarticalpro[index + 4],
                  ),
                )),
      ];
      return ListView.builder(
        physics: ClampingScrollPhysics(),
        shrinkWrap: true,
        itemCount: _mainScreenWidgets.length,
        itemBuilder: (context, index) => SlideAnimationWidget(
          index: index,
          itemCount: _mainScreenWidgets.length,
          widgetToAnimate: _mainScreenWidgets[index],
        ),
      );
    }
  }
}
