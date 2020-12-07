import 'dart:async';
import 'package:flutter/material.dart';

import '../helpers/custom_route.dart';
import './user_preferences.dart';
import 'package:flutter/services.dart';

class Bloc {
  final _themeController = StreamController<bool>();
  void Function(bool event) get changeTheme {
    systemTheme();
    return _themeController.sink.add;
  }

  get darkThemeEnabled => _themeController.stream;

  void themedispose() {
    _themeController.close();
  }

  void systemTheme() {
    final bool tf = UserPreferences().data ?? false;

    if (tf) {
      SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
          statusBarBrightness: Brightness.dark,
          statusBarIconBrightness: Brightness.light,
          statusBarColor: Colors.transparent,
          systemNavigationBarColor: Colors.black,
          systemNavigationBarIconBrightness: Brightness.light));
    } else {
      SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
          statusBarBrightness: Brightness.light,
          statusBarIconBrightness: Brightness.dark,
          statusBarColor: Colors.transparent,
          systemNavigationBarColor: Colors.white,
          systemNavigationBarIconBrightness: Brightness.dark));
    }
  }
}

final bloc = Bloc();

class AppTheme {
  get lightTheme => ThemeData(
        // brightness: Brightness.light,
        primarySwatch: Colors.indigo,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        appBarTheme: ThemeData.light().appBarTheme.copyWith(
            color: Colors.white,
            // centerTitle: true,
            brightness: Brightness.light,
            elevation: 1,
            iconTheme:
                ThemeData.light().iconTheme.copyWith(color: Colors.blue[900])),
        scaffoldBackgroundColor: Colors.white,
        pageTransitionsTheme: PageTransitionsTheme(
            builders: {TargetPlatform.android: CustomPageTransitionBuilder()}),
      );

  get darkTheme => ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.indigo,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        appBarTheme: ThemeData.dark().appBarTheme.copyWith(
            color: Colors.black,
            // centerTitle: true,
            elevation: 1,
            brightness: Brightness.dark,
            iconTheme:
                ThemeData.dark().iconTheme.copyWith(color: Colors.blue[700])),
        scaffoldBackgroundColor: Colors.black,
        accentColor: Colors.blue,
        dividerColor: Colors.blueAccent,
        pageTransitionsTheme: PageTransitionsTheme(
            builders: {TargetPlatform.android: CustomPageTransitionBuilder()}),
      );
}
