import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:journal_app/services/database.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class TodayProvider extends ChangeNotifier {

  TodayProvider(){
    setImagePath();
  }

  //image
  String _imagePath;

  //getters
  String get getImagePath => _imagePath;

  //setters
   setImagePath() async {
    var data = await AppDatabase().getTodayImage();
    if(data != null && data != ''){
      _imagePath = data;
    }
    return _imagePath;
  }

  setImage(PickedFile image) async {
   try{
     var imagePath = join(await getApplicationDocumentsDirectory().then((value) => value.path));
     String fileName = basename(File(image.path).path);
     File newFile =  File(image.path).copySync('$imagePath/$fileName');
     _imagePath = newFile.path;
     await AppDatabase().insertTodayImage(_imagePath);
     notifyListeners();
   }catch(e){
     print('error from set image provider\n' + e.toString());
   }
  }

  removeImage() async {
    try{
      await AppDatabase().removeTodayImage();
      _imagePath = null;
      notifyListeners();
    }catch(e){
      print('error from set image provider\n' + e.toString());
    }
  }


}