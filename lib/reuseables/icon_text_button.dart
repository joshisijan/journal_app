import 'package:flutter/material.dart';

class IconTextButton extends StatelessWidget {
  final String title;
  final IconData icon;
  final Function onPress;

  const IconTextButton({
    Key key,
    @required this.title,
    @required this.icon,
    @required this.onPress,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: FlatButton(
        onPressed: onPress,
        padding: EdgeInsets.all(10.0),
        color: Theme.of(context).primaryColor,
        child: Row(
          children: [
            Icon(
              icon,
              color: Theme.of(context).colorScheme.onPrimary,
            ),
            SizedBox(
              width: 10.0,
            ),
            Text(
              title,
              style: TextStyle(color: Theme.of(context).colorScheme.onPrimary),
            ),
          ],
        ),
      ),
    );
  }
}
