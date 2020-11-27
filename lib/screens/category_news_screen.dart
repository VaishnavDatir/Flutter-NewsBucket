import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:carousel_slider/carousel_slider.dart';

import '../widgets/apptitle.dart';
import '../widgets/loading_screen_widget.dart';
import '../widgets/news_article_single_row.dart';
import '../widgets/heading_div_widget.dart';
import '../widgets/news_article_display_widget.dart';
import '../widgets/connectivity_error.dart';

import '../animation/slide_animation_widget.dart';

import '../providers/news_artical_provider.dart';

class CategoryNews extends StatelessWidget {
  static const routeName = '/CategoryNews';

  @override
  Widget build(BuildContext context) {
    GlobalKey<ScaffoldState> _scafoldKey = new GlobalKey();
    final routeArgs =
        ModalRoute.of(context).settings.arguments as Map<String, String>;
    final categoryTitle = routeArgs["caterogyName"];
    return Scaffold(
      key: _scafoldKey,
      appBar: AppBar(
        title: AppTitle(),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          await Provider.of<NewsArticalProvider>(context, listen: false)
              .fetchCategoryNews(categoryTitle);
          return _scafoldKey.currentState.showSnackBar(SnackBar(
            content: Text("Your viewing latest $categoryTitle news"),
            duration: Duration(seconds: 2),
            elevation: 6.0,
            behavior: SnackBarBehavior.floating,
          ));
        },
        child: FutureBuilder(
          future: Provider.of<NewsArticalProvider>(context)
              .fetchCategoryNews(categoryTitle),
          builder: (ctx, dataSnapShot) {
            if (dataSnapShot.connectionState == ConnectionState.waiting) {
              return LoadingScreenWidget();
            } else {
              if (dataSnapShot.error != null) {
                //Do Error handling stuff
                return Center(
                    child: const Text(
                        "Error While Fetching Data\n Check Network Connection"));
              } else {
                return Consumer<NewsArticalProvider>(
                    builder: (ctx, data, child) {
                  if (data.newsarticalpro.isEmpty)
                    return Center(child: ConnectivityError());
                  else {
                    final List _categoryNewsWidgets = [
                      HeadingAndDivider(
                          heading: "Trending $categoryTitle News"),
                      CarouselSlider(
                        items: [
                          NewsArticleDisplayWidget(
                              newsArtical: data.newsarticalpro[0]),
                          NewsArticleDisplayWidget(
                              newsArtical: data.newsarticalpro[1]),
                          NewsArticleDisplayWidget(
                              newsArtical: data.newsarticalpro[2]),
                          NewsArticleDisplayWidget(
                              newsArtical: data.newsarticalpro[3])
                        ],
                        options: CarouselOptions(
                            autoPlay: true,
                            height: 300,
                            viewportFraction: 0.9,
                            enlargeCenterPage: false,
                            enableInfiniteScroll: false),
                      ),
                      SizedBox(height: 10),
                      HeadingAndDivider(
                          heading: "Top $categoryTitle News in India"),
                      ListView.builder(
                          itemCount: data.newsarticalpro.length - 4,
                          physics: ClampingScrollPhysics(),
                          shrinkWrap: true,
                          itemBuilder: (ctx, index) =>
                              NewsArticleSingleRowWidget(
                                newsArticalSingleRow:
                                    data.newsarticalpro[index + 4],
                              )),
                    ];
                    return ListView.builder(
                      physics: ClampingScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: _categoryNewsWidgets.length,
                      itemBuilder: (context, index) => SlideAnimationWidget(
                        index: index,
                        itemCount: _categoryNewsWidgets.length,
                        widgetToAnimate: _categoryNewsWidgets[index],
                      ),
                    );
                  }
                });
              }
            }
          },
        ),
      ),
    );
  }
}
