import 'package:flutter/material.dart';
import 'package:journal_app/reuseables/custom_alert.dart';
import 'package:journal_app/screens/add.dart';
import 'package:journal_app/screens/home.dart';
import 'package:journal_app/screens/settings.dart';

class AppBase extends StatelessWidget {
  final PageController _pageController = PageController(
    initialPage: 1,
    keepPage: true,
  );
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: (){
        return CustomAlert().showExitAlert(context);
      },
      child: Scaffold(
        key: PageStorageKey('HomePage'),
        body: PageView(
          controller: _pageController,
          scrollDirection: Axis.horizontal,
          physics: NeverScrollableScrollPhysics(),
          children: [
            Add(
              pageController: _pageController,
            ),
            Home(
              pageController: _pageController,
            ),
            Settings(
              pageController: _pageController,
            ),
          ],
        ),
      ),
    );
  }
}