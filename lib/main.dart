import 'dart:core';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:journal_app/base.dart';
import 'package:journal_app/providers/theme_provider.dart';
import 'package:journal_app/providers/today_provider.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
    return ChangeNotifierProvider(
      create: (context) => ThemeProvider(),
      builder: (context, child) {
        var themeProvider = (context).watch<ThemeProvider>();
        return MaterialApp(
          title: 'Journal',
          debugShowCheckedModeBanner: false,
          theme: themeProvider.getTheme,
          home: ChangeNotifierProvider(
            create: (context) => TodayProvider(),
            builder: (context, child) {
              return AppBase();
            },
          ),
        );
      },
    );
  }
}
