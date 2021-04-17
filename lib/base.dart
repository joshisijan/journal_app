import 'package:flutter/material.dart';
import 'package:journal_app/providers/story_provider.dart';
import 'package:journal_app/screens/add.dart';
import 'package:journal_app/screens/home.dart';
import 'package:journal_app/screens/settings.dart';
import 'package:provider/provider.dart';

class AppBase extends StatelessWidget {
  final PageController _pageController = PageController(
    initialPage: 1,
    keepPage: true,
  );
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        return showDialog(
              context: context,
              builder: (context) => AlertDialog(
                title: Text('Exit App'),
                content: Text('Do you really want to exit the App?'),
                actions: [
                  IconButton(
                    icon: Icon(
                      Icons.check,
                      color: Theme.of(context).primaryColorDark,
                    ),
                    onPressed: () {
                      Navigator.of(context).pop(true);
                    },
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.close,
                      color: Theme.of(context).errorColor,
                    ),
                    onPressed: () {
                      Navigator.of(context).pop(false);
                    },
                  ),
                ],
              ),
            ) ??
            false;
      },
      child: Scaffold(
        body: ChangeNotifierProvider(
          create: (context) => StoryProvider(),
          builder: (context, child) {
            return PageView(
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
            );
          },
        ),
      ),
    );
  }
}
