import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:journal_app/providers/theme_provider.dart';
import 'package:provider/provider.dart';

class Settings extends StatelessWidget {
  final PageController pageController;
  const Settings({
    Key key,
    @required this.pageController,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var themeProvider = (context).watch<ThemeProvider>();

    // for toggle button
    List<bool> _themeSelected = [];
    for (int i = 0; i < themeProvider.getThemes.length; i++) {
      if (i == themeProvider.getThemeId) {
        _themeSelected.add(true);
      } else {
        _themeSelected.add(false);
      }
    }
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
              _themeSelected.length > 0
                  ? Container(
                    padding: EdgeInsets.symmetric(horizontal: 7.5),
                    child: ToggleButtonsTheme(
                        data: ToggleButtonsThemeData(
                          borderColor: Theme.of(context).colorScheme.onPrimary.withAlpha(70),
                          selectedBorderColor:
                          Theme.of(context).colorScheme.onPrimary,
                          constraints: BoxConstraints(
                            minHeight: 36.0,
                            maxHeight: 36.0,
                            minWidth: 36.0,
                            maxWidth: 36.0,
                          ),
                          borderWidth: 5.0,
                        ),
                        child: ToggleButtons(
                          isSelected: _themeSelected,
                          children: themeProvider.getThemes.map<Container>((e) {
                            return Container(
                              width: 36.0,
                              height: 36.0,
                              color: e['theme'].primaryColor,
                            );
                          }).toList(),
                          onPressed: (n) {
                            themeProvider.setTheme(n);
                          },
                        ),
                      ),
                  )
                  : SizedBox.shrink(),
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
  }
}
