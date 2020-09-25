import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
// import 'package:flutter/services.dart'; USED for SystemChrome

import './providers/news_artical_provider.dart';
import './providers/category_news_artical_provider.dart';
import './providers/custom_search_articals_providers.dart';

import './screens/main_screen.dart';
import './screens/news_view.dart';
import './screens/category_news_screen.dart';
import './screens/news_display.dart';

import './helpers/custom_route.dart';

void main() {
  // SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
  //   // statusBarColor: Colors.white,
  //   statusBarIconBrightness: Brightness.dark,
  //   // statusBarBrightness: Brightness.light,
  // ));
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (ctx) => NewsArticalProvider(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => CategoryNewsArticalProvider(),
        ),
        ChangeNotifierProvider(
            create: (ctx) => CustomSearchNewsArticalsProviders())
      ],
      child: MaterialApp(
        title: 'News Bucket',
        theme: ThemeData(
            primarySwatch: Colors.indigo,
            visualDensity: VisualDensity.adaptivePlatformDensity,
            appBarTheme: ThemeData.light().appBarTheme.copyWith(
                color: Colors.white,
                centerTitle: true,
                elevation: 0,
                iconTheme: ThemeData.light()
                    .iconTheme
                    .copyWith(color: Colors.blue[900])),
            pageTransitionsTheme: PageTransitionsTheme(builders: {
              TargetPlatform.android: CustomPageTransitionBuilder()
            })),
        home: MainScreen(),
        routes: {
          NewsView.routeName: (ctx) => NewsView(),
          CategoryNews.routeName: (ctx) => CategoryNews(),
          NewsDisplayScreen.routeName: (ctx) => NewsDisplayScreen(),
        },
      ),
    );
  }
}
