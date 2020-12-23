import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/apptitle.dart';
import '../widgets/loading_screen_widget.dart';
import '../widgets/screen_news_widget.dart';

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
      appBar: AppBar(title: AppTitle()),
      body: RefreshIndicator(
        onRefresh: () async {
          await Provider.of<NewsArticalProvider>(context)
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
                  return ScreenNewsWidget(
                    data: data,
                    headings: [
                      "Trending $categoryTitle News",
                      "Top $categoryTitle News"
                    ],
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
