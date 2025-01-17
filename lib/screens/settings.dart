import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:journal_app/providers/cache_provider.dart';
import 'package:journal_app/providers/theme_provider.dart';
import 'package:journal_app/widgets/cache_manager.dart';
import 'package:journal_app/widgets/color_selector.dart';
import 'package:provider/provider.dart';

class Settings extends StatelessWidget {
  final PageController pageController;
  const Settings({
    Key key,
    @required this.pageController,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> themes = context
        .select((ThemeProvider themeProvider) => themeProvider.getThemes);
    int themeId = context
        .select((ThemeProvider themeProvider) => themeProvider.getThemeId);
    return ChangeNotifierProvider(
      create: (context) => CacheProvider(),
      builder: (context, child) {
        return Stack(
          children: [
            Container(
              color: Theme.of(context).primaryColor,
              child: ListView(
                children: [
                  SizedBox(
                    height: 80.0,
                  ),
                  Container(
                    padding: EdgeInsets.all(10.0),
                    child: Text(
                      'App color',
                      style: Theme.of(context).textTheme.headline6.copyWith(
                            color: Theme.of(context).colorScheme.onPrimary,
                          ),
                    ),
                  ),
                  ColorSelector(
                    themes: themes,
                    active: themeId,
                    divisions: 8,
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Container(
                    padding: EdgeInsets.all(10.0),
                    child: Text(
                      'Storage Usage',
                      style: Theme.of(context).textTheme.headline6.copyWith(
                            color: Theme.of(context).colorScheme.onPrimary,
                          ),
                    ),
                  ),
                  CacheManager(),
                  SizedBox(
                    height: 10.0,
                  ),
                  Divider(
                    color: Theme.of(context).primaryColorLight,
                  ),
                  Container(
                    padding: EdgeInsets.all(10.0),
                    child: Text(
                      'The app is under development. Hope you will enjoy this beta testing.'
                      'Your feedback is highly appreciated. You can send your feedback and suggestions to '
                      'email address joshisijan96gmail.com',
                      style: Theme.of(context).textTheme.overline.copyWith(
                            color: Theme.of(context).colorScheme.onPrimary,
                          ),
                      textAlign: TextAlign.right,
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              top: MediaQuery.of(context).padding.top + 10.0,
              // left: 15.0,
              child: IconButton(
                icon: Icon(
                  Icons.arrow_back,
                  color: Theme.of(context).colorScheme.onPrimary,
                ),
                onPressed: () {
                  pageController.animateToPage(
                    1,
                    curve: Curves.decelerate,
                    duration: Duration(milliseconds: 350),
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }
}
