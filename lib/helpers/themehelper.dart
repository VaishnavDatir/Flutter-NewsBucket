import 'dart:async';
import 'package:flutter/material.dart';

import '../helpers/custom_route.dart';

class Bloc {
  // ignore: close_sinks
  final _themeController = StreamController<bool>();
  get changeTheme => _themeController.sink.add;
  get darkThemeEnabled => _themeController.stream;
}

final bloc = Bloc();

class AppTheme {
  get lightTheme => ThemeData(
        // brightness: Brightness.dark,
        primarySwatch: Colors.indigo,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        appBarTheme: ThemeData.light().appBarTheme.copyWith(
            color: Colors.white,
            centerTitle: true,
            elevation: 0,
            iconTheme:
                ThemeData.light().iconTheme.copyWith(color: Colors.blue[900])),
        pageTransitionsTheme: PageTransitionsTheme(
            builders: {TargetPlatform.android: CustomPageTransitionBuilder()}),
      );

  get darkTheme => ThemeData(
        brightness: Brightness.dark,
        appBarTheme: ThemeData.dark().appBarTheme.copyWith(
            centerTitle: true,
            elevation: 0,
            brightness: Brightness.dark,
            iconTheme:
                ThemeData.dark().iconTheme.copyWith(color: Colors.blue[700])),
        primarySwatch: Colors.indigo,
        accentColor: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        dividerColor: Colors.blueAccent,
        hintColor: Colors.blue[800],
        inputDecorationTheme: InputDecorationTheme(
          fillColor: Colors.black87,
          filled: true,
          isCollapsed: true,
        ),
        pageTransitionsTheme: PageTransitionsTheme(
            builders: {TargetPlatform.android: CustomPageTransitionBuilder()}),
      );
}
