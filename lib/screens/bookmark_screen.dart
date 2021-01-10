import 'package:NewsBucket/widgets/news_article_single_row.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/news_artical_provider.dart';

import '../widgets/apptitle.dart';
import '../widgets/loading_screen_widget.dart';

class BookMarkScreen extends StatefulWidget {
  static const routeName = '/BookMarkScreen';

  @override
  _BookMarkScreenState createState() => _BookMarkScreenState();
}

class _BookMarkScreenState extends State<BookMarkScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: AppTitle(),
      ),
      body: FutureBuilder(
        future: Provider.of<NewsArticalProvider>(context).fetchandSet(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return LoadingScreenWidget();
          } else {
            if (snapshot.error != null) {
              //Do Error handling stuff
              return Center(
                  child: const Text(
                      "There was an error while getting your saved news.\nPlease try again later"));
            } else {
              return Consumer<NewsArticalProvider>(
                  builder: (context, value, child) {
                if (value.newsarticalpro.isEmpty) {
                  return Container(
                    margin: EdgeInsets.only(top: 20),
                    child: Center(
                      child: Column(
                        children: [
                          const Icon(
                            Icons.info_outline,
                            size: 65,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          const Text(
                            "There are no bookmarked news",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                    ),
                  );
                } else {
                  return ListView.separated(
                    separatorBuilder: (context, index) => Divider(
                      indent: 132,
                    ),
                    shrinkWrap: true,
                    physics: BouncingScrollPhysics(),
                    itemCount: value.newsarticalpro.length,
                    itemBuilder: (context, index) => NewsArticleSingleRowWidget(
                      newsArticalSingleRow: value.newsarticalpro[index],
                    ),
                  );
                }
              });
            }
          }
        },
      ),
    );
  }
}
