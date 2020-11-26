import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'dart:async';
import '../widgets/apptitle.dart';

class NewsView extends StatefulWidget {
  static const routeName = '/NewsVies';
  /*  final String newsUrl;

  NewsView({this.newsUrl}); */

  @override
  _NewsViewState createState() => _NewsViewState();
}

class _NewsViewState extends State<NewsView> {
  final Completer<WebViewController> _controller =
      Completer<WebViewController>();
  bool isLoading = true;
  @override
  Widget build(BuildContext context) {
    final routeArgs =
        ModalRoute.of(context).settings.arguments as Map<String, String>;
    final newsurl = routeArgs["newsUrl"];
    return Scaffold(
      appBar: AppBar(
        // backgroundColor: Colors.white,
        // elevation: 0,
        title: AppTitle(),
      ),
      body: Stack(
        children: [
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: WebView(
              onWebResourceError: (error) {
                return Center(
                    child: const Text(
                  "Error while loading page",
                  style: TextStyle(fontSize: 22),
                ));
              },
              javascriptMode: JavascriptMode.unrestricted,
              initialUrl: newsurl,
              onWebViewCreated: (WebViewController webViewController) {
                _controller.complete(webViewController);
              },
              onPageFinished: (_) {
                setState(() {
                  isLoading = false;
                });
              },
            ),
          ),
          if (isLoading) Center(child: CircularProgressIndicator()),
        ],
      ),
    );
  }
}
