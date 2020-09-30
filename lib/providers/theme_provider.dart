import 'package:flutter/material.dart';
import 'package:journal_app/services/theme_preference.dart';
import 'package:journal_app/style/theme.dart';

class ThemeProvider extends ChangeNotifier {

  ThemeProvider(){
    () async {
      int n = await ThemePreference().getTheme();
      setTheme(n);
    }.call();
  }

  // theme of the app
  ThemeData _theme = kPurpleTheme;

  //theme id
  int _themeId = 0;

  // list of all themes
  List<Map<String, dynamic>> _themes = [
    {
      'id': 0,
      'name': 'purple',
      'theme': kPurpleTheme,
    },
    {
      'id': 1,
      'name': 'red',
      'theme': kRedTheme,
    },
    {
      'id': 2,
      'name': 'light blue',
      'theme': kLightBlueTheme,
    },
    {
      'id': 3,
      'name': 'green',
      'theme': kGreenTheme,
    },
    {
      'id': 4,
      'name': 'pink',
      'theme': kPinkTheme,
    },
    {
      'id': 5,
      'name': 'deep purple',
      'theme': kDeepPurpleTheme,
    },
    {
      'id': 6,
      'name': 'deep orange',
      'theme': kDeepOrangeTheme,
    },
    {
      'id': 7,
      'name': 'lime',
      'theme': kLimeTheme,
    },
    {
      'id': 8,
      'name': 'teal',
      'theme': kTealTheme,
    },
    {
      'id': 9,
      'name': 'cyan',
      'theme': kCyanTheme,
    },
    {
      'id': 10,
      'name': 'blue',
      'theme': kBlueTheme,
    },
    {
      'id': 11,
      'name': 'indigo',
      'theme': kIndigoTheme,
    },
    {
      'id': 12,
      'name': 'light green',
      'theme': kLightGreenTheme,
    },
    {
      'id': 13,
      'name': 'brown',
      'theme': kBrownTheme,
    },
    {
      'id': 14,
      'name': 'grey',
      'theme': kGreyTheme,
    },
    {
      'id': 15,
      'name': 'amber',
      'theme': kAmberTheme,
    },
    {
      'id': 16,
      'name': 'yellow',
      'theme': kYellowTheme,
    },
  ];

  //getters
  int get getThemeId => _themeId;
  ThemeData get getTheme => _theme;
  List<Map<String, dynamic>> get getThemes => _themes;

  //setters
  setTheme(int n){
    Map<String, dynamic> map = _themes.firstWhere((element) => element['id'] == n);
    _theme = map['theme'];
    _themeId = map['id'];
    notifyListeners();
    ThemePreference().setTheme(n);
  }

}
