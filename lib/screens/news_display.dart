import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../widgets/apptitle.dart';

import '../models/news_artical_modal.dart' as nam;

class NewsDisplayScreen extends StatelessWidget {
  static const routeName = '/NewsDisplay';

  final nam.NewsArticalModal ndNewsArtical;

  NewsDisplayScreen({this.ndNewsArtical});
  @override
  Widget build(BuildContext context) {
    // final routeArgs =
    //     ModalRoute.of(context).settings.arguments as Map<String, dynamic>;
    // final newsData = routeArgs["newsData"];
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              title: AppTitle(),
              elevation: 1,
              expandedHeight: 300,
              pinned: true,
              flexibleSpace: FlexibleSpaceBar(
                background: Container(
                  margin: const EdgeInsets.only(top: 55),
                  padding: const EdgeInsets.symmetric(vertical: 0),
                  child: Hero(
                    tag: ndNewsArtical.imageUrl,
                    child: Image.network(
                      ndNewsArtical.imageUrl,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 6, horizontal: 6),
                child: Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Container(
                            margin: EdgeInsets.only(right: 5),
                            child: SelectableText(
                              ndNewsArtical.title,
                              textAlign: TextAlign.justify,
                              style: GoogleFonts.poppins(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                        IconButton(
                          icon: Icon(Icons.share),
                          onPressed: () {},
                        )
                      ],
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
