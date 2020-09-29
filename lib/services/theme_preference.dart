import 'package:shared_preferences/shared_preferences.dart';

class ThemePreference{
  Future<int> getTheme() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getInt('themeIndex') ?? 0;
  }
  setTheme(int n) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setInt('themeIndex', n);
  }
}