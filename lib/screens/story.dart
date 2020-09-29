import 'package:flutter/material.dart';

class Story extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        color: Theme.of(context).cardColor,
        child: ListView(
          children: [
            Text('haha', style: TextStyle(color: Theme.of(context).colorScheme.onPrimary),),
          ],
        ),
      ),
    );
  }
}
