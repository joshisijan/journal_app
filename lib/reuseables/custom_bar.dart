import 'package:flutter/material.dart';

class CustomBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 80.0,
      height: 5.0,
      alignment: Alignment.center,
      margin: EdgeInsets.symmetric(vertical: 15.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.0),
        color: Theme.of(context).textTheme.caption.color,
      ),
    );
  }
}
