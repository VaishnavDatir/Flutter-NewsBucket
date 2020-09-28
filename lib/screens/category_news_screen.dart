import 'package:NewsBucket/providers/category_news_artical_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:carousel_slider/carousel_slider.dart';

import '../widgets/apptitle.dart';
import '../widgets/loading_screen_widget.dart';
import '../widgets/news_article_single_row.dart';
import '../widgets/heading_div_widget.dart';
import '../widgets/news_article_display_widget.dart';
import '../widgets/connectivity_error.dart';

class CategoryNews extends StatelessWidget {
  static const routeName = '/CategoryNews';

  @override
  Widget build(BuildContext context) {
    final routeArgs =
        ModalRoute.of(context).settings.arguments as Map<String, String>;
    final categoryTitle = routeArgs["caterogyName"];
    return Scaffold(
      appBar: AppBar(
        title: AppTitle(),
      ),
      body: RefreshIndicator(
        onRefresh: () {
          return Provider.of<CategoryNewsArticalProvider>(context,
                  listen: false)
              .fetchCategoryNews(categoryTitle);
        },
        child: FutureBuilder(
          future: Provider.of<CategoryNewsArticalProvider>(context)
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
                return Consumer<CategoryNewsArticalProvider>(
                    builder: (ctx, data, child) {
                  return SingleChildScrollView(
                    child: data.categorynewsarticalpro.isEmpty
                        ? Center(child: ConnectivityError())
                        : Column(
                            children: [
                              HeadingAndDivider(
                                  heading: "Trending $categoryTitle News"),
                              CarouselSlider(
                                items: [
                                  NewsArticleDisplayWidget(
                                      newsArtical:
                                          data.categorynewsarticalpro[0]),
                                  NewsArticleDisplayWidget(
                                      newsArtical:
                                          data.categorynewsarticalpro[1]),
                                  NewsArticleDisplayWidget(
                                      newsArtical:
                                          data.categorynewsarticalpro[2]),
                                  NewsArticleDisplayWidget(
                                      newsArtical:
                                          data.categorynewsarticalpro[3])
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
                                  itemCount:
                                      data.categorynewsarticalpro.length - 4,
                                  physics: ClampingScrollPhysics(),
                                  shrinkWrap: true,
                                  itemBuilder: (ctx, index) =>
                                      NewsArticleSingleRowWidget(
                                        newsArticalSingleRow: data
                                            .categorynewsarticalpro[index + 4],
                                      )),
                            ],
                          ),
                  );
                });
              }
            }
          },
        ),
      ),
    );
  }
}
