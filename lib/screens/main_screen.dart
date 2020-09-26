import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:carousel_slider/carousel_slider.dart';

import '../providers/categoryProvider.dart';
import '../providers/news_artical_provider.dart';
import '../providers/custom_search_articals_providers.dart';

import '../widgets/category_title_display.dart';
import '../widgets/news_article_display_widget.dart';
import '../widgets/apptitle.dart';
import '../widgets/loading_screen_widget.dart';
import '../widgets/news_article_single_row.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  DateTime dateTime = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: RefreshIndicator(
      onRefresh: () {
        setState(() {
          dateTime = DateTime.now();
        });

        return Provider.of<NewsArticalProvider>(context, listen: false)
            .fetchTopHeadlines();
      },
      child: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              elevation: 1,
              expandedHeight: 150,
              pinned: true,
              // snap: true,
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
                  margin: const EdgeInsets.only(top: 60),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 6, vertical: 0),
                  height: 80,
                  child: ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(6)),
                    child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: Categories_Data.length,
                        itemBuilder: (ctx, index) => CategoryTitleDisplayWidget(
                            cTitle: Categories_Data[index].categoryTitle,
                            cImgUrl: Categories_Data[index].categoryImgUrl)),
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
                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8.0),
                                      child: Text(
                                        "Top headlines in India",
                                        style: GoogleFonts.roboto(
                                            fontSize: 22,
                                            color: Colors.black,
                                            fontWeight: FontWeight.w600),
                                      ),
                                    ),
                                    Divider(
                                      height: 4,
                                      endIndent: 10,
                                      indent: 10,
                                      color: Colors.blue[900],
                                    ),
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
                                            newsArtical: data.newsarticalpro[3])
                                      ],
                                      options: CarouselOptions(
                                          autoPlay: true,
                                          height: 300,
                                          viewportFraction: 0.9,
                                          enlargeCenterPage: false,
                                          enableInfiniteScroll: false),
                                    ),
                                    ListView.builder(
                                        physics: ClampingScrollPhysics(),
                                        shrinkWrap: true,
                                        itemCount:
                                            data.newsarticalpro.length - 4,
                                        itemBuilder: (ctx, index) =>
                                            NewsArticleSingleRowWidget(
                                              newsArticalSingleRow: data
                                                  .newsarticalpro[index + 4],
                                            )),
                                    Container(
                                      width: double.infinity,
                                      margin: EdgeInsets.symmetric(
                                          horizontal: 2, vertical: 5),
                                      padding: EdgeInsets.all(3),
                                      child: Text(
                                          "Updated at ${DateFormat("dd/MM/yyyy hh:mm a").format(dateTime)}",
                                          textAlign: TextAlign.right,
                                          style: GoogleFonts.rubik(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w600,
                                            color: Colors.blue[900],
                                          )),
                                    ),
                                  ],
                                );
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
    //throw UnimplementedError();
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
    // throw UnimplementedError();

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
    // throw UnimplementedError();
    /*  return Navigator.of(context)
        .pushNamed(CustomSearchNewsScreen.routeName, arguments: {
      "searchQuery": query,
    }); */
    return QuerySearch(query: query);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    //Show when someone searches for something
    // final suggestionList = recentSearch;

    // return ListView.builder(
    //     itemCount: suggestionList.length,
    //     itemBuilder: (ctx, index) => ListTile(
    //           leading: Icon(Icons.history),
    //           title: Text(suggestionList[index]),
    //         ));
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
        future: Provider.of<CustomSearchNewsArticalsProviders>(context)
            .fetchCustomSearchNews(query),
        builder: (ctx, dataSnapShot) {
          if (dataSnapShot.connectionState == ConnectionState.waiting) {
            return Container(
              height: MediaQuery.of(context).size.height,
              width: double.infinity,
              child: Center(
                child: SizedBox(
                    width: 100,
                    height: 100,
                    child: CircularProgressIndicator()),
              ),
            );
          } else {
            if (dataSnapShot.error != null) {
              //Do Error handling stuff
              return Center(
                  child: const Text(
                      "Error While Fetching Data\n Check Network Connection"));
            } else {
              return Consumer<CustomSearchNewsArticalsProviders>(
                  builder: (ctx, data, child) {
                return data.customSearchNewsPro.isEmpty
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
                        itemCount: data.customSearchNewsPro.length,
                        physics: ClampingScrollPhysics(),
                        shrinkWrap: true,
                        itemBuilder: (ctx, index) => NewsArticleDisplayWidget(
                              newsArtical: data.customSearchNewsPro[index],
                            ));
              });
            }
          }
        },
      ),
    );
  }
}
