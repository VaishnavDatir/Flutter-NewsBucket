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

import './helpers/themehelper.dart';

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
      child: StreamBuilder(
          stream: bloc.darkThemeEnabled,
          initialData: false,
          builder: (context, snapshot) {
            return MaterialApp(
              title: 'News Bucket',
              themeMode: snapshot.data ? ThemeMode.dark : ThemeMode.light,
              darkTheme: AppTheme().darkTheme,
              theme: AppTheme().lightTheme,
              home: MainScreen(
                darkThemeEnabled: snapshot.data,
              ),
              routes: {
                NewsView.routeName: (ctx) => NewsView(),
                CategoryNews.routeName: (ctx) => CategoryNews(),
                NewsDisplayScreen.routeName: (ctx) => NewsDisplayScreen(),
              },
            );
          }),
    );
  }
}
