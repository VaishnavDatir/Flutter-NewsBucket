import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:share/share.dart';

import '../widgets/apptitle.dart';

import '../screens/news_view.dart';

import '../widgets/image_not_ava.dart';

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
      appBar: AppBar(title: AppTitle()),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              ndNewsArtical.imageUrl.isEmpty
                  ? ImageNotAvaWidget(
                      isBig: true,
                    )
                  : Hero(
                      tag: ndNewsArtical.title,
                      child: Image.network(
                        ndNewsArtical.imageUrl,
                        fit: BoxFit.fitWidth,
                      ),
                    ),
              Container(
                padding: EdgeInsets.symmetric(vertical: 6, horizontal: 7),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SelectableText(
                      ndNewsArtical.title,
                      style: GoogleFonts.poppins(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    SelectableText(
                      ndNewsArtical.description,
                      style: GoogleFonts.montserrat(
                          fontSize: 20, fontWeight: FontWeight.w400),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              icon: Icon(Icons.share),
              onPressed: () {
                final RenderBox box = context.findRenderObject();
                const String appTitle = "*NewsBucket*\n";
                final String msgTitle = "*${ndNewsArtical.title}*";
                final String msgDes = ndNewsArtical.description.isEmpty
                    ? ""
                    : "\n\n${ndNewsArtical.description}";
                final String msgUrl = ndNewsArtical.newsUrl.isEmpty
                    ? ""
                    : "\n\nTo know more:\n${ndNewsArtical.newsUrl}";
                Share.share(appTitle + msgTitle + msgDes + msgUrl,
                    subject: msgTitle,
                    sharePositionOrigin:
                        box.localToGlobal(Offset.zero) & box.size);
              },
              tooltip: "Share",
            ),
            ndNewsArtical.newsUrl.isEmpty
                ? const SizedBox()
                : IconButton(
                    icon: Icon(
                      Icons.open_in_new,
                      size: 30,
                    ),
                    // color: Colors.blue[800],
                    splashRadius: 25,
                    onPressed: () {
                      Navigator.of(context).pushNamed(NewsView.routeName,
                          arguments: {"newsUrl": ndNewsArtical.newsUrl});
                    },
                    tooltip: "Open in browser",
                  ),
          ],
        ),
      ),
    );
  }
}
