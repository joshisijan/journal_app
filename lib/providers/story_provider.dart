import 'package:flutter/material.dart';

class StoryProvider extends ChangeNotifier{
  //story index
  int _currentIndex = 0;

  //getters
  int get getCurrentIndex => _currentIndex;

  //setters
  setCurrentIndex(int n) {
    _currentIndex = n;
    notifyListeners();
  }
}