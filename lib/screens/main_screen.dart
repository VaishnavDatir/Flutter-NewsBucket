import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:carousel_slider/carousel_slider.dart';

import '../providers/categoryProvider.dart';
import '../providers/news_artical_provider.dart';

import '../widgets/category_title_display.dart';
import '../widgets/news_article_display_widget.dart';
import '../widgets/apptitle.dart';
import '../widgets/loading_screen_widget.dart';
import '../widgets/news_article_single_row.dart';
import '../widgets/update_date_time_widget.dart';
import '../widgets/heading_div_widget.dart';
import '../widgets/appdrawer.dart';
import '../widgets/connectivity_error.dart';

import '../animation/slide_animation_widget.dart';

class MainScreen extends StatefulWidget {
  final bool darkThemeEnabled;

  MainScreen({this.darkThemeEnabled});

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  GlobalKey<ScaffoldState> _scafoldKey = new GlobalKey();
  DateTime dateTime = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scafoldKey,
        drawer: AppDrawer(darkThemeEnabled: widget.darkThemeEnabled),
        body: RefreshIndicator(
          onRefresh: () async {
            setState(() {
              dateTime = DateTime.now();
            });

            await Provider.of<NewsArticalProvider>(context, listen: false)
                .fetchTopHeadlines();
            return _scafoldKey.currentState.showSnackBar(SnackBar(
              content: Text("Your viewing latest news"),
              duration: Duration(seconds: 2),
              elevation: 6.0,
              behavior: SnackBarBehavior.floating,
            ));
          },
          child: SafeArea(
            child: CustomScrollView(
              slivers: [
                SliverAppBar(
                  elevation: 1,
                  expandedHeight: 135,
                  pinned: true,
                  //  snap: true,
                  // floating: true,
                  title: AppTitle(),
                  actions: [
                    IconButton(
                        icon: Icon(Icons.search),
                        onPressed: () {
                          showSearch(context: context, delegate: DataSearch());
                        }),
                  ],
                  flexibleSpace: FlexibleSpaceBar(
                    background: Container(
                      margin: const EdgeInsets.only(top: 55, bottom: 3),
                      // padding: const EdgeInsets.symmetric(horizontal: 5),
                      // height: 41,
                      child: Center(
                        child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: Categories_Data.length,
                            shrinkWrap: true,
                            itemBuilder: (ctx, index) =>
                                CategoryTitleDisplayWidget(
                                    cTitle:
                                        Categories_Data[index].categoryTitle,
                                    cImgUrl:
                                        Categories_Data[index].categoryImgUrl)),
                      ),
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: Column(
                    children: [
                      FutureBuilder(
                          future: Provider.of<NewsArticalProvider>(context,
                                  listen: false)
                              .fetchTopHeadlines(),
                          builder: (ctx, dataSnapShot) {
                            if (dataSnapShot.connectionState ==
                                ConnectionState.waiting) {
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
                                    if (data.newsarticalpro.isEmpty) {
                                      return ConnectivityError();
                                    } else {
                                      final List _mainScreenWidgets = [
                                        SizedBox(height: 10),
                                        HeadingAndDivider(
                                            heading: "Trending in India"),
                                        CarouselSlider(
                                          items: [
                                            NewsArticleDisplayWidget(
                                                newsArtical:
                                                    data.newsarticalpro[0]),
                                            NewsArticleDisplayWidget(
                                                newsArtical:
                                                    data.newsarticalpro[1]),
                                            NewsArticleDisplayWidget(
                                                newsArtical:
                                                    data.newsarticalpro[2]),
                                            NewsArticleDisplayWidget(
                                                newsArtical:
                                                    data.newsarticalpro[3])
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
                                            heading: "Top headlines in India"),
                                        ListView.builder(
                                            physics: ClampingScrollPhysics(),
                                            shrinkWrap: true,
                                            itemCount:
                                                data.newsarticalpro.length - 4,
                                            itemBuilder: (ctx, index) =>
                                                SlideAnimationWidget(
                                                  index: index,
                                                  itemCount: data.newsarticalpro
                                                          .length -
                                                      4,
                                                  widgetToAnimate:
                                                      NewsArticleSingleRowWidget(
                                                    newsArticalSingleRow:
                                                        data.newsarticalpro[
                                                            index + 4],
                                                  ),
                                                )),
                                        UpdateDateAndTime(dateTime: dateTime),
                                      ];
                                      return ListView.builder(
                                        physics: ClampingScrollPhysics(),
                                        shrinkWrap: true,
                                        itemCount: _mainScreenWidgets.length,
                                        itemBuilder: (context, index) =>
                                            SlideAnimationWidget(
                                          index: index,
                                          itemCount: _mainScreenWidgets.length,
                                          widgetToAnimate:
                                              _mainScreenWidgets[index],
                                        ),
                                      );
                                    }
                                  },
                                );
                              }
                            }
                          }),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}

class DataSearch extends SearchDelegate<String> {
  @override
  List<Widget> buildActions(BuildContext context) {
    // Actions for appbar
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = "";
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    // Leading icon on the left of the app bar
    return IconButton(
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // show some result based on the selection
    return query.isEmpty
        ? buildSuggestions(context)
        : QuerySearch(query: query);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    //Show when someone searches for something

    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          FittedBox(
            fit: BoxFit.scaleDown,
            child: Icon(
              Icons.search,
              size: 70,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                "Search your topic",
                style: GoogleFonts.poppins(fontSize: 24),
              ))
        ],
      ),
    );
  }
}

class QuerySearch extends StatelessWidget {
  const QuerySearch({
    Key key,
    @required this.query,
  }) : super(key: key);

  final String query;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: FutureBuilder(
        future: Provider.of<NewsArticalProvider>(context)
            .fetchCustomSearchNews(query),
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
              return Consumer<NewsArticalProvider>(builder: (ctx, data, child) {
                return data.newsarticalpro.isEmpty
                    ? Container(
                        margin: EdgeInsets.symmetric(horizontal: 10),
                        height: MediaQuery.of(context).size.height,
                        width: MediaQuery.of(context).size.width,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            FittedBox(
                              fit: BoxFit.scaleDown,
                              child: Icon(
                                Icons.error_outline,
                                size: 70,
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            FittedBox(
                                fit: BoxFit.scaleDown,
                                child: Text(
                                  "Nothing found related to \n'$query'",
                                  style: GoogleFonts.poppins(fontSize: 24),
                                ))
                          ],
                        ),
                      )
                    : ListView.builder(
                        itemCount: data.newsarticalpro.length,
                        physics: ClampingScrollPhysics(),
                        shrinkWrap: true,
                        itemBuilder: (ctx, index) => SlideAnimationWidget(
                          index: index,
                          itemCount: data.newsarticalpro.length,
                          widgetToAnimate: NewsArticleSingleRowWidget(
                            newsArticalSingleRow: data.newsarticalpro[index],
                          ),
                        ),
                      );
              });
            }
          }
        },
      ),
    );
  }
}
