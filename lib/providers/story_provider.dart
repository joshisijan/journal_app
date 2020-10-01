import 'package:flutter/material.dart';
import 'package:journal_app/services/database.dart';

class StoryProvider extends ChangeNotifier {

  StoryProvider() {
    setStories();
  }

  List<Map<String, dynamic>> _stories = [];

  // getters
  List<Map<String, dynamic>> get getStories => _stories;

  //setters
  setStories() async {
    try{
      List<Map<String, dynamic>> map = await AppDatabase().getAllImages();
      _stories = map;
      notifyListeners();
    }catch(e){
      print('error from set stories\n' + e.toString());
    }
  }
}