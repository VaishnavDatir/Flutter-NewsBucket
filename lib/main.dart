import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './providers/news_artical_provider.dart';

import './screens/main_screen.dart';
import './screens/news_view.dart';
import './screens/category_news_screen.dart';
import './screens/news_display.dart';

import './helpers/themehelper.dart';
import './helpers/user_preferences.dart';
// import 'package:flutter/services.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await UserPreferences().init();
  bloc.systemTheme();
  print("RUNNING APP");
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => NewsArticalProvider(),
      child: StreamBuilder(
          stream: bloc.darkThemeEnabled,
          initialData: UserPreferences().data ?? false,
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
