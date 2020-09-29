import 'package:flutter/material.dart';
import 'package:journal_app/base.dart';
import 'package:journal_app/providers/theme_provider.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final PageStorageBucket _bucket = PageStorageBucket();
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ThemeProvider(),
      builder: (context, child){
        var themeProvider = (context).watch<ThemeProvider>();
        return MaterialApp(
          title: 'Journal',
          debugShowCheckedModeBanner: false,
          theme: themeProvider.getTheme,
          home: PageStorage(
            bucket: _bucket,
            child: AppBase(),
          ),
        );
      },
    );
  }
}

