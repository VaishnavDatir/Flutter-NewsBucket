import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:share/share.dart';
import '../screens/news_view.dart';

import '../widgets/apptitle.dart';
import '../widgets/image_not_ava.dart';

import '../models/news_artical_modal.dart' as nam;

import '../helpers/db_helper.dart';

class NewsDisplayScreen extends StatefulWidget {
  static const routeName = '/NewsDisplay';

  final nam.NewsArticalModal ndNewsArtical;

  NewsDisplayScreen({this.ndNewsArtical});

  @override
  _NewsDisplayScreenState createState() => _NewsDisplayScreenState();
}

class _NewsDisplayScreenState extends State<NewsDisplayScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: AppTitle()),
      body: SingleChildScrollView(
        child: Column(
          children: [
            widget.ndNewsArtical.imageUrl.isEmpty
                ? ImageNotAvaWidget(
                    isBig: true,
                  )
                : Hero(
                    tag: widget.ndNewsArtical.title,
                    child: Image.network(
                      widget.ndNewsArtical.imageUrl,
                      fit: BoxFit.fitWidth,
                      errorBuilder: (context, error, stackTrace) {
                        return ImageNotAvaWidget(
                          isBig: true,
                        );
                      },
                    ),
                  ),
            Container(
              padding: EdgeInsets.symmetric(vertical: 6, horizontal: 7),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${widget.ndNewsArtical.sourceName} ${widget.ndNewsArtical.autherName.isEmpty ? "" : " - " + widget.ndNewsArtical.autherName}",
                    style: GoogleFonts.poppins(
                        fontSize: 15, color: Colors.grey[600]),
                  ),
                  SelectableText(
                    widget.ndNewsArtical.title.split(" - ")[0],
                    style: GoogleFonts.roboto(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(
                    height: 7,
                  ),
                  SelectableText(
                    widget.ndNewsArtical.description.contains("…")
                        ? widget.ndNewsArtical.description +
                            "\nTo know more, Visit ${widget.ndNewsArtical.sourceName} website."
                        : widget.ndNewsArtical.description,
                    style: GoogleFonts.dmSans(
                        fontSize: 20, fontWeight: FontWeight.w300),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: ListView(
        shrinkWrap: true,
        physics: BouncingScrollPhysics(),
        children: [
          Divider(
            thickness: 0,
          ),
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                IconButton(
                  icon: const Icon(Icons.share),
                  onPressed: () {
                    final RenderBox box = context.findRenderObject();
                    const String appTitle = "*NewsBucket*\n";
                    final String msgTitle = "*${widget.ndNewsArtical.title}*";
                    final String msgDes =
                        widget.ndNewsArtical.description.isEmpty
                            ? ""
                            : "\n\n${widget.ndNewsArtical.description}";
                    final String msgUrl = widget.ndNewsArtical.newsUrl.isEmpty
                        ? ""
                        : "\n\nTo know more:\n${widget.ndNewsArtical.newsUrl}";
                    Share.share(appTitle + msgTitle + msgDes + msgUrl,
                        subject: msgTitle,
                        sharePositionOrigin:
                            box.localToGlobal(Offset.zero) & box.size);
                  },
                  tooltip: "Share",
                ),
                widget.ndNewsArtical.newsUrl.isEmpty
                    ? const SizedBox()
                    : IconButton(
                        icon: const Icon(
                          Icons.open_in_new,
                          size: 30,
                        ),
                        // color: Colors.blue[800],
                        splashRadius: 25,
                        onPressed: () {
                          Navigator.of(context).pushNamed(NewsView.routeName,
                              arguments: {
                                "newsUrl": widget.ndNewsArtical.newsUrl
                              });
                        },
                        tooltip: "Open webpage",
                      ),
                FutureBuilder(
                  future: DBHelper.isStored(
                      "user_savedNews", widget.ndNewsArtical.title),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const CircularProgressIndicator();
                    } else {
                      bool res = snapshot.data;

                      return IconButton(
                          icon: snapshot.data
                              ? Icon(Icons.bookmark)
                              : Icon(Icons.bookmark_outline),
                          iconSize: 30,
                          splashRadius: 25,
                          tooltip: res
                              ? "Remove this news from save"
                              : "Save this news",
                          onPressed: () {
                            if (snapshot.data) {
                              res = deleteData(widget.ndNewsArtical.title);
                            } else {
                              res = insertData(widget.ndNewsArtical);
                            }
                            Scaffold.of(context).showSnackBar(SnackBar(
                              content: Text(res
                                  ? "Added to saved news"
                                  : "Removed from saved news"),
                              duration: Duration(seconds: 2),
                              elevation: 6.0,
                              behavior: SnackBarBehavior.floating,
                            ));
                            setState(() {});
                          });
                    }
                  },
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  bool insertData(nam.NewsArticalModal dbnews) {
    try {
      DBHelper.insert("user_savedNews", {
        "title": dbnews.title,
        "desc": dbnews.description,
        "imageurl": dbnews.imageUrl,
        "newsurl": dbnews.newsUrl,
        "sourcename": dbnews.sourceName,
        "author": dbnews.autherName
      });
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  bool deleteData(String title) {
    try {
      DBHelper.delete("user_savedNews", title);
      return false;
    } catch (e) {
      print(e);
      return true;
    }
  }
}
