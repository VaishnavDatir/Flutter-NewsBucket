import 'package:NewsBucket/providers/category_news_artical_provider.dart';
import 'package:NewsBucket/widgets/news_article_display_widget.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../widgets/apptitle.dart';
import '../widgets/loading_screen_widget.dart';

class CategoryNews extends StatelessWidget {
  static const routeName = '/CategoryNews';

  @override
  Widget build(BuildContext context) {
    final routeArgs =
        ModalRoute.of(context).settings.arguments as Map<String, String>;
    final categoryTitle = routeArgs["caterogyName"];
    return Scaffold(
        body: SafeArea(
      child: RefreshIndicator(
        onRefresh: () {
          return Provider.of<CategoryNewsArticalProvider>(context,
                  listen: false)
              .fetchCategoryNews(categoryTitle);
        },
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              elevation: 1,
              expandedHeight: 100,
              pinned: true,
              // snap: true,
              // floating: true,
              title: AppTitle(),
              flexibleSpace: FlexibleSpaceBar(
                background: Container(
                  margin: const EdgeInsets.only(top: 55),
                  child: FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Text(
                      " $categoryTitle Headlines",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.workSans(
                          color: Colors.black,
                          fontSize: 26,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Container(
                child: FutureBuilder(
                  future: Provider.of<CategoryNewsArticalProvider>(context)
                      .fetchCategoryNews(categoryTitle),
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
                        return Consumer<CategoryNewsArticalProvider>(
                            builder: (ctx, data, child) {
                          return ListView.builder(
                              itemCount: data.categorynewsarticalpro.length,
                              physics: ClampingScrollPhysics(),
                              shrinkWrap: true,
                              itemBuilder: (ctx, index) =>
                                  NewsArticleDisplayWidget(
                                    newsArtical:
                                        data.categorynewsarticalpro[index],
                                  ));
                        });
                      }
                    }
                  },
                ),
              ),
            )
          ],
        ),
      ),
    ));
  }
}
