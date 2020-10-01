import 'package:flutter/material.dart';
import 'package:journal_app/providers/theme_provider.dart';
import 'package:provider/provider.dart';

class ColorSelector extends StatelessWidget {

  final List<Map<String, dynamic>> themes;
  final int divisions;
  final int active;
  ColorSelector({
    this.divisions = 7,
    @required this.themes,
    @required this.active,
  });

  @override
  Widget build(BuildContext context) {
    double size = ((MediaQuery.of(context).size.width - 20.0) / divisions);
    return Container(
      padding: EdgeInsets.all(10.0),
      child: Wrap(
        alignment: WrapAlignment.start,
        children: themes.map((element){
          int index = themes.indexOf(element);
          return GestureDetector(
            onTap: (){
              Provider.of<ThemeProvider>(context, listen: false).setTheme(index);
            },
            child: Container(
              width: size,
              height: size,
              decoration: BoxDecoration(
                color: themes[index]['theme'].primaryColor,
                border: Border.all(
                  width: 5.0,
                  color: active == index ? Theme.of(context).colorScheme.onPrimary.withAlpha(220) : Theme.of(context).cardColor.withAlpha(100),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
