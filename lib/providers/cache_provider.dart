import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

class CacheProvider extends ChangeNotifier{

  CacheProvider(){
    setCacheSize();
  }

  // cache size
  int _cacheSize = 0;
  // getters
  int get getCacheSize => _cacheSize;

  // setters
  setCacheSize() async {
    try{
      final cacheDir = await getTemporaryDirectory();
      if(cacheDir.existsSync()){
        cacheDir.listSync(recursive: true, followLinks: true)
            .forEach((element) {
          if(element is File){
            _cacheSize = _cacheSize + element.lengthSync();
          }
        });
        notifyListeners();
      }
    }catch(e){
      print('error from set cache size\n' + e.toString());
    }
  }

  deleteCache() async {
    try{
      final cacheDir = await getTemporaryDirectory();
      if(cacheDir.existsSync()){
        cacheDir.deleteSync(recursive: true);
        _cacheSize = 0;
        notifyListeners();
      }
    }catch(e){
      print('error from delete cache\n' + e.toString());
    }
  }
}