import 'package:flutter/material.dart';

class AddImage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){

      },
      child: Container(
        width: 100.0,
        height: 160.0,
        decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            borderRadius: BorderRadius.circular(5.0),
            boxShadow: [
              BoxShadow(
                color: Theme.of(context).textTheme.caption.color.withAlpha(150),
                spreadRadius: 0.5,
                blurRadius: 0.5,
                offset: Offset(0, 0.5),
              ),
            ]),
        child: Center(
          child: Icon(Icons.add_circle_outline, size: 40.0, color: Theme.of(context).primaryColor,),
        ),
      ),
    );
  }
}
