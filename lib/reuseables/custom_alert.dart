import 'package:flutter/material.dart';


class CustomAlert{
  showExitAlert(BuildContext context){
    return showDialog(
      context: context,
      child: AlertDialog(
        title: Text('Exit App'),
        content: Text('Do you really want to exit the App?'),
        actions: [
          IconButton(
            icon: Icon(Icons.check, color: Theme.of(context).primaryColor,),
            onPressed: (){
              Navigator.of(context).pop(true);
            },
          ),
          IconButton(
            icon: Icon(Icons.close, color: Theme.of(context).errorColor,),
            onPressed: (){
              Navigator.of(context).pop(false);
            },
          ),
        ],
      ),
    );
  }
}