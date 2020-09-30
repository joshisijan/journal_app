import 'package:flutter/material.dart';

class TodayProvider extends ChangeNotifier {



  //image
  String _imagePath;

  //getters
  get getImagePath => _imagePath;

  //setters
  setImage(String image){
    _imagePath = image;
    notifyListeners();
  }
}